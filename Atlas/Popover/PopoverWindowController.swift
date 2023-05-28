//
//  PopoverWindowController.swift
//  Atlas
//
//  Created by Yuto on 2023/05/07.
//

import Foundation
import SwiftUI

class PopoverWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}

class PopoverWindowController: NSWindowController, NSWindowDelegate {
    
    var manager = ATAppManager.shared
    
    init(contentView: AnyView) {
        let window = PopoverWindow(
            contentRect: NSRect(
                x: manager.position.x,
                y: manager.position.y,
                width: manager.windowSize.width,
                height: manager.windowSize.height
            ),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.hasShadow = true
        window.level = .floating
        
        window.maxSize = CGSize(width: manager.windowSize.width + 200,
                                height: manager.windowSize.height + 200)
        
        super.init(window: window)
        
        window.delegate = self
        self.window = window
        
        windowDidLoad()
        
        let hostingController = NSHostingController(rootView: contentView)
        window.contentViewController = hostingController
        hostingController.view.window?.makeFirstResponder(hostingController.view)
        
        self.window?.makeFirstResponder(nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        animateWindowAppearance()
    }
    
    func animateWindowAppearance() {
        guard let window = window else {
            return
        }
        
        NSAnimationContext.runAnimationGroup({ context in
//            context.duration = 0.2 // Animation duration
            print("present window", manager.position)
            // Animate the window to the desired size using the animator()
            window.animator().setFrame(
                NSRect(
                    x: manager.position.x,
                    y: manager.position.y,
                    width: manager.windowSize.width,
                    height: manager.windowSize.height
                ),
                display: true
            )
            print("window updated", window.frame)
        })
    }
    
    func windowDidExpose(_ notification: Notification) {
        animateWindowAppearance()
    }

    func windowDidResignKey(_ notification: Notification) {
//        window?.close()
    }
    
//    override func keyDown(with event: NSEvent) {
//        window?.contentView?.keyDown(with: event)
//    }
}


struct CustomPopover: View {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            ContentView()
                .environmentObject(ATAppManager.shared)
        }
        .background(.thinMaterial)
        .cornerRadius(8, antialiased: true)
    }
}
