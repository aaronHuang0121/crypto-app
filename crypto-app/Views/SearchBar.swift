//
//  SearchBar.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/26.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchKey: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchKey.isEmpty ? .secondaryText : .accent)
            
            TextField("Search by name or symbol...", text: $searchKey)
                .autocorrectionDisabled()
                .foregroundStyle(.accent)
                .font(.headline)
                .overlay(
                    alignment: .trailing,
                    content: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.accent)
                            .opacity(searchKey.isEmpty ? 0 : 1)
                            .gesture(
                                TapGesture()
                                    .onEnded({ 
                                        UIApplication.shared.endEditing()
                                        self.searchKey = ""
                                    })
                            )
                    }
                )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(color: .accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

private struct PreviewWrapper: View {
    @State private var searchKey: String = ""
    var body: some View {
        SearchBar(searchKey: $searchKey)
    }
}

#Preview {
    PreviewWrapper()
}
