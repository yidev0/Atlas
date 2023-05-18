//
//  AppCell.swift
//  Atlas
//
//  Created by Yuto on 2023/05/12.
//

import SwiftUI

struct AppCell: View {
    
    var app: ATApp
    var isFocused: Bool
    
    var body: some View {
        Button {
            app.openApp()
        } label: {
            Image(nsImage: app.icon ?? NSImage(systemSymbolName: "app", accessibilityDescription: "app")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all, 4)
        }
        .buttonStyle(.plain)
        .background {
            switch isFocused {
            case true :
                RoundedRectangle(cornerRadius: 50/6.4)
                    .foregroundColor(.black.opacity(0.3))
                    .overlay {
                        RoundedRectangle(cornerRadius: 50/6.4)
                            .stroke()
                            .foregroundColor(.secondary)
                    }
            default:
                EmptyView()
            }
        }
    }
    
}

struct AppCell_Previews: PreviewProvider {
    static var previews: some View {
        AppCell(
            app:
                ATApp(
                    name: "Title",
                    identifier: "com.sample.app",
                    category: .education
                ),
            isFocused: true
        )
    }
}
