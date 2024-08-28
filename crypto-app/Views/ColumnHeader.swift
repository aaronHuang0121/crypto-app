//
//  ColumnHeader.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/28.
//

import SwiftUI

struct ColumnHeader: View {
    let title: String
    let showSortOption: Bool
    let reversed: Bool
    let action: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            Image(systemName: "chevron.down")
                .opacity(showSortOption ? 1 : 0)
                .rotationEffect(.degrees(reversed ? 180 : 0))
        }
        .gesture(
            TapGesture()
                .onEnded(action)
        )
    }
}

#Preview {
    ColumnHeader(title: "Coin", showSortOption: true, reversed: true, action: {})
}
