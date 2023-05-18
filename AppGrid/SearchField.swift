//
//  SearchField.swift
//  Atlas
//
//  Created by Yuto on 2023/05/13.
//

import SwiftUI

struct SearchField: View {
    
    @FocusState var isFocused
    @Binding var search: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search", text: $search)
                .accessibilityAddTraits(.isSearchField)
                .textFieldStyle(.plain)
                .focused($isFocused)
            
            Button {
                
            } label: {
                Image(systemName: "gear")
            }
            .accessibilityLabel("Settings")
        }
        .padding(.all, 4)
        .background {
            Color(.controlBackgroundColor)
                .cornerRadius(8)
        }
        .onChange(of: isFocused) { newValue in
            print(newValue)
        }
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField(search: .constant("aa"))
    }
}
