//
//  SettingsView.swift
//  Atlas
//
//  Created by Yuto on 2023/05/16.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Text("General")
                .tabItem {
                    Label("General", systemImage: "gear")
                }
            Text("Options")
                .tabItem {
                    Label("Options", systemImage: "slider.horizontal.3")
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
