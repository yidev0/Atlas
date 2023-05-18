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
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        showWindow()
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
    
}
