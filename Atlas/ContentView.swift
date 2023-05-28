//
//  ContentView.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appManager: ATAppManager
    
    @FocusState var isSearching
    
    @State var apps: [ATApp] = []
    
    var body: some View {
        VStack(spacing: 0) {
            SearchField(search: $appManager.search)
                .shadow(radius: 2)
                .focused($isSearching)
            
            AppGridView(apps: $apps, search: $appManager.search)
        }
        .onAppear {
            self.apps = appManager.searchApp(with: appManager.search)
        }
        .onChange(of: appManager.search) { newValue in
            self.apps = appManager.searchApp(with: newValue)
        }
        .onReceive(NotificationCenter.default.publisher(for: .init("OpenApp"))) { output in
            if let index = output.object as? Int, apps.count > index - 1 {
                apps[index].openApp()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ATAppManager.shared)
    }
}
