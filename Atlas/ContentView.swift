//
//  ContentView.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appManager: ATAppManager
    
    @State var focusedApp: Int = 0
    @State var search: String = ""
    @State var keyMonitor: Any?
    @FocusState var isSearching
    
    @State var apps: [ATApp] = []
    
    init() {
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(search: $search)
                .shadow(radius: 2)
                .focused($isSearching)
            
            AppGridView(apps: $apps, focusedApp: $focusedApp, search: $search)
        }
        .onAppear {
            self.apps = appManager.searchApp(with: search)
            setupKeyEvent()
        }
        .onChange(of: search) { newValue in
            self.apps = appManager.searchApp(with: newValue)
        }
    }
    
    func setupKeyEvent() {
        if keyMonitor != nil { return }
        keyMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) { nsevent in
            if isSearching {
                if nsevent.keyCode == 53 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if search == "" {
                            NSApplication.shared.keyWindow?.close()
                        } else {
                            search = ""
                        }
                    }
                }
            } else {
                if nsevent.keyCode == 123 { // right
                    focusedApp = focusedApp > 1 ? focusedApp - 1 : 0
                } else if nsevent.keyCode == 124 { // left
                    focusedApp = focusedApp < apps.count ? focusedApp + 1 : 0
                } else if nsevent.keyCode == 125 { // down
                    focusedApp += appManager.columnCount
                } else if nsevent.keyCode == 126 { // up
                    focusedApp -= appManager.columnCount
                }
                
                if focusedApp < 0 {
                    focusedApp = 0
                } else if focusedApp > apps.count - 1 {
                    focusedApp = apps.count - 1
                }
                
                if nsevent.keyCode == 36 { // return
                    apps[focusedApp].openApp()
                }
            }
            return nsevent
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ATAppManager.shared)
    }
}
