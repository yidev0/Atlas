//
//  AppIconGrid.swift
//  Atlas
//
//  Created by Yuto on 2023/05/31.
//

import SwiftUI

struct AppIconGrid: View {
    
    var apps: [ATApp]
    var categories: [ATAppCategoryType]
    var focusedApp: Int
    
    var columns: [GridItem]
    var spacing: CGFloat
    var appSize: CGFloat
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: spacing
        ) {
            Section {
                ForEach(categories, id: \.self) { category in
                    AppCategoryCell(category: category)
                }
            }
            Section {
                ForEach(apps, id: \.identifier) { app in
                    AppCell(app: app, isFocused: apps.firstIndex(of: app) == focusedApp)
                        .frame(
                            width: appSize,
                            height: appSize
                        )
                }
            }
        }
        .focusable()
    }
}

struct AppIconGrid_Previews: PreviewProvider {
    static var previews: some View {
        AppIconGrid(
            apps: [
                ATApp(
                    name: "Title",
                    identifier: "com.sample.app",
                    category: .education,
                    source: nil
                ),
            ],
            categories: [.browser],
            focusedApp: 0,
            columns: [GridItem()],
            spacing: 8,
            appSize: 50
        )
    }
}
