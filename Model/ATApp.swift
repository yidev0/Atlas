//
//  ATApp.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import Foundation
import AppKit

class ATApp: Hashable {
    static func == (lhs: ATApp, rhs: ATApp) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    var name: String
    var identifier: String
    var category: ATAppCategoryType?
    var icon: NSImage?
    var color: NSColor?
    var source: ATAppSource?
    
    init(
        name: String,
        identifier: String,
        category: ATAppCategoryType?,
        icon: NSImage? = nil,
        color: NSColor? = nil,
        source: ATAppSource?
    ) {
        self.name = name
        self.identifier = identifier
        self.category = category
        self.icon = icon
        self.color = color
        self.source = source
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    public func openApp() {
        if let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: self.identifier) {
            
            let configuration = NSWorkspace.OpenConfiguration()
            configuration.activates = true
            configuration.hides = true
            
            NSWorkspace.shared.openApplication(
                at: appURL,
                configuration: configuration
            ) { runningApplication, error in
                if let error = error {
                    print("Failed to open application: \(error)")
                } else {
                    runningApplication?.activate(options: .activateIgnoringOtherApps)
                }
            }
        }
    }
}
