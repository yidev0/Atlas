//
//  AppGridView.swift
//  Atlas
//
//  Created by Yuto on 2023/05/11.
//

import SwiftUI

struct AppGridView: View {
    
    @EnvironmentObject var appManager: ATAppManager
    @Binding var focusedApp: Int
    
    @Binding var apps: [ATApp]
    @Binding var search: String
    
    var columns: [GridItem]
    var spacing: CGFloat
    var appSize: CGFloat
    var appSizeDiff: CGFloat
    
    init(apps: Binding<[ATApp]>, focusedApp: Binding<Int>, search: Binding<String>) {
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
        self._focusedApp = focusedApp
        self._search = search
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                grid
                    .padding(.all, 8)
                    .onAppear {
                        appManager.columnCount = calculateColumnCount(width: geometry.size.width, cellWidth: appSize)
                    }
                    .onChange(of: geometry.size.width) { newValue in
                        print("window", newValue)
                        appManager.columnCount = calculateColumnCount(width: newValue, cellWidth: appSize)
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
                AppCell(app: app, isFocused: apps.firstIndex(of: app) == focusedApp)
                    .frame(
                        width: appSize,
                        height: appSize
                    )
            }
        }
    }
    
    func calculateColumnCount(width: CGFloat, cellWidth: CGFloat) -> Int {
        print(width)
        let small = Int(floor((width - 16 + spacing) / (appSize + spacing - appSizeDiff)))
        return small
    }
    
}

struct AppGridView_Previews: PreviewProvider {
    static var previews: some View {
        AppGridView(apps: .constant([]), focusedApp: .constant(1), search: .constant(""))
    }
}
