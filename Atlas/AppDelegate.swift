//
//  AppDelegate.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    
    var manager = ATAppManager.shared
    var popoverWindowController: PopoverWindowController!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        manager.checkDockPosition {
            DispatchQueue.main.async {
                self.popoverWindowController = PopoverWindowController(
                    contentView:
                        AnyView(
                            CustomPopover()
                                .frame(
                                    idealWidth: self.manager.windowSize.width,
                                    idealHeight: self.manager.windowSize.height
                                )
                        )
                )
                NSApp.activate(ignoringOtherApps: true)
                self.showWindow()
            }
        }
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            self.keyDown(event: event) ? nil : event
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if popoverWindowController.window?.isVisible == true {
            withAnimation {
                popoverWindowController.close()
            }
        } else {
            showWindow()
        }
        return true
    }
    
    func showWindow() {
        manager.checkDockPosition {
            DispatchQueue.main.async {
                self.popoverWindowController.showWindow(nil)
                self.popoverWindowController.animateWindowAppearance()
            }
        }
    }
    
    func keyDown(event: NSEvent) -> Bool {
        let appManager = ATAppManager.shared
        let columnCount = appManager.columnCount
        
        switch event.keyCode {
        case 53: // esc
            if appManager.search != "" {
                appManager.search = ""
            } else {
                self.popoverWindowController.close()
            }
            
        case 123: // right
            appManager.focusedApp = appManager.focusedApp > 1 ? appManager.focusedApp - 1 : 0
        case 124: // left
            appManager.focusedApp = appManager.focusedApp < appManager.apps.count ? appManager.focusedApp + 1 : 0
        case 125: // down
            appManager.focusedApp += columnCount
        case 126: // up
            appManager.focusedApp -= columnCount
            
        case 36: // return
            NotificationCenter.default.post(name: .init("OpenApp"), object: appManager.focusedApp)
            
        default:
            return false
        }
        
        if appManager.focusedApp < 0 {
            appManager.focusedApp = 0
        } else if appManager.focusedApp > appManager.apps.count - 1 {
            appManager.focusedApp = appManager.apps.count - 1
        }
        
        return true
    }
    
}
