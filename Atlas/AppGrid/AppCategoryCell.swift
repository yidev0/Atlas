//
//  AppCategoryCell.swift
//  Atlas
//
//  Created by Yuto on 2023/05/12.
//

import SwiftUI

struct AppCategoryCell: View {
    
    var category: ATAppCategoryType
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            Image(systemName: category.symbol)
                .font(.title)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(category.color.gradient)
        }
        .aspectRatio(1, contentMode: .fit)
        .background(.regularMaterial)
        .cornerRadius(8)
    }
}

struct AppCategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        AppCategoryCell(
            category: .socialNetworking
        )
        .frame(width: 80, height: 80)
        .padding()
    }
}
