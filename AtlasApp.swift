//
//  AtlasApp.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import SwiftUI

@main
struct AtlasApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    let persistenceController = PersistenceController.shared
    
    @State var showMenubar = true
    
    var body: some Scene {
        
        Settings {
            SettingsView()
                .frame(width: 400, height: 380, alignment: .center)
        }
        
        MenuBarExtra(isInserted: $showMenubar) {
            ContentView()
                .environmentObject(ATAppManager.shared)
                .frame(maxHeight: 500)
        } label: {
            Image(systemName: "app.fill")
        }
        .menuBarExtraStyle(.window)

    }
    
}
