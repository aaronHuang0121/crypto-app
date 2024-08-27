//
//  CoinLogo.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import SwiftUI

struct CoinLogo: View {
    let coin: Coin
    let isSelected: Bool

    var body: some View {
        VStack {
            RemoteImage(url: coin.image)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(width: 75)
        .padding(4)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.customGreen : .clear, lineWidth: 1)
        }
    }
}

#Preview {
    HStack {
        CoinLogo(coin: .mock, isSelected: true)
        CoinLogo(coin: .mock, isSelected: false)
    }
}
