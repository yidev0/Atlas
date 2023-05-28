//
//  AppGridView.swift
//  Atlas
//
//  Created by Yuto on 2023/05/11.
//

import SwiftUI

struct AppGridView: View {
    
    @EnvironmentObject var appManager: ATAppManager
    
    @Binding var apps: [ATApp]
    @Binding var search: String
    
    var columns: [GridItem]
    var spacing: CGFloat
    var appSize: CGFloat
    var appSizeDiff: CGFloat
    
    init(apps: Binding<[ATApp]>, search: Binding<String>) {
        let spacing: CGFloat = 12
        let appSize: CGFloat = 50
        let diff: CGFloat = 5
        
        self.columns = [
            GridItem(
                .adaptive(
                    minimum: appSize - diff,
                    maximum: appSize
                ),
                spacing: spacing
            )
        ]
        
        self.spacing = spacing
        self.appSize = appSize
        self.appSizeDiff = diff
        
        self._apps = apps
        self._search = search
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView {
                    grid
                        .padding(.all, 8)
                        .onAppear {
                            appManager.columnCount = calculateColumnCount(width: geometry.size.width, cellWidth: appSize)
                            appManager.columnCount = calculateRowCount(height: geometry.size.height, cellHeight: appSize)
                        }
                        .onChange(of: geometry.size.width) { newValue in
                            appManager.columnCount = calculateColumnCount(width: newValue, cellWidth: appSize)
                        }
                        .onChange(of: geometry.size.height) { newValue in
                            appManager.rowCount = calculateRowCount(height: newValue, cellHeight: appSize)
                        }
                }
                .onChange(of: appManager.focusedApp) { newValue in
                    if apps.count > appManager.focusedApp {
                        proxy.scrollTo(apps[appManager.focusedApp].identifier)
                    }
                }
            }
        }
    }
    
    var grid: some View {
        LazyVGrid(
            columns: columns,
            spacing: spacing
        ) {
            ForEach(apps, id: \.identifier) { app in
                AppCell(app: app, isFocused: apps.firstIndex(of: app) == appManager.focusedApp)
                    .frame(
                        width: appSize,
                        height: appSize
                    )
            }
        }
        .focusable()
    }
    
    func calculateColumnCount(width: CGFloat, cellWidth: CGFloat) -> Int {
        let small = Int(floor((width - 16 + spacing) / (cellWidth + spacing - appSizeDiff)))
        return small
    }
    
    func calculateRowCount(height: CGFloat, cellHeight: CGFloat) -> Int {
        let small = Int(floor((height - 16 + spacing) / (cellHeight + spacing - appSizeDiff)))
        return small
    }
    
}

struct AppGridView_Previews: PreviewProvider {
    static var previews: some View {
        AppGridView(apps: .constant([]), search: .constant(""))
    }
}
