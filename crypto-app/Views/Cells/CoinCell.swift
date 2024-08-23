//
//  CoinCell.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import SwiftUI

struct CoinCell: View {
    @Environment(\.device) private var device
    let coin: Coin
    let showHoldingColumns: Bool

    init(
        coin: Coin,
        showHoldingColumns: Bool = true
    ) {
        self.coin = coin
        self.showHoldingColumns = showHoldingColumns
    }
    
    var body: some View {
        HStack(spacing: 0) {
            LeftColumn()
            
            Spacer()
            
            CenterColumn()
            
            RightColumn()
        }
        .font(.subheadline)
    }
}

extension CoinCell {
    @ViewBuilder
    private func LeftColumn() -> some View {
        Text("\(coin.rank)")
            .font(.caption)
            .foregroundStyle(.secondaryText)
            .frame(minWidth: 30)
        
        Circle()
            .frame(width: 30)
        
        Text(coin.symbol.uppercased())
            .font(.headline)
            .foregroundStyle(.accent)
            .padding(.leading, 6)
    }
    
    @ViewBuilder
    private func CenterColumn() -> some View {
        if showHoldingColumns {
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingValue.asCurrencyWith2Decimals())
                    .bold()
                Text((coin.currentHoldings ?? 0).asCurrencyWith2Decimals())
            }
            .foregroundStyle(.accent)
        }
    }
    
    @ViewBuilder
    private func RightColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundStyle(.accent)
            Text(
                coin.priceChangePercentage24H
                    .formatted(.percent.precision(.fractionLength(2)))
            )
            .foregroundStyle(
                coin.priceChangePercentage24H > 0
                ? .customRed
                : .customGreen
            )
        }
        .frame(width: device.safeAreaWidth / 3, alignment: .trailing)
    }
}

#Preview {
    VStack {
        CoinCell(coin: Coin.mock)
        
        CoinCell(coin: Coin.mock, showHoldingColumns: false)
    }
}
