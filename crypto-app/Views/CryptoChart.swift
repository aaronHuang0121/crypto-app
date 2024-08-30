//
//  CryptoChart.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/30.
//

import Charts
import SwiftUI

struct CryptoChart: View {
    let data: [(x: Date, y: Double)]
    let minY: Double
    let maxY: Double
    let minX: Date
    let maxX: Date
    let grewUp: Bool
    let areaSize: CGFloat
    @State private var showUps: [Bool]
    
    init(coin: Coin) {
        let prices = coin.sparklineIn7D?.price ?? []
        self.maxY = prices.max() ?? 0
        self.minY = prices.min() ?? 0
        self.areaSize = (maxY - minY) * 0.2
        
        let dates = coin.lastUpdated.toArray(byAdding: -7, count: prices.count)
        self.minX = dates.min() ?? Date()
        self.maxX = dates.max() ?? Date()

        self.data = prices
            .enumerated()
            .map({ index, value in
                (
                    x: dates[index],
                    y: value
                )
            })
        
        self.grewUp = (prices.last ?? 0) - (prices.first ?? 0) > 0
        self._showUps = .init(
            initialValue: Array(repeating: false, count: prices.count)
        )
    }

    private var lineColor: Color {
        grewUp ? .customRed : .customGreen
    }
    
    var body: some View {
        Chart(data.indices, id: \.self) { index in
            if showUps[index] {
                LineMark(
                    x: .value("Date", data[index].x),
                    y: .value("Price", data[index].y)
                )
                .foregroundStyle(lineColor)
                
                AreaMark(
                    x: .value("Date", data[index].x),
                    yStart: .value("Price", data[index].y - areaSize),
                    yEnd: .value("Price", data[index].y)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [lineColor.opacity(0.1), lineColor.opacity(0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartXScale(domain: minX...maxX)
        .chartXAxis {
            AxisMarks {
                AxisValueLabel(
                    format: Date.FormatStyle(date: .numeric),
                    anchor: .leading,
                    collisionResolution: .disabled
                )
                .font(.caption)
                .foregroundStyle(.secondaryText)
            }
        }
        .chartYScale(domain: minY*0.95...maxY*1.05)
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisValueLabel(
                    format: FloatingPointFormatStyle<Double>(
                        locale: Locale(identifier: "en_US")
                    )
                    .notation(.compactName)
                    .precision(.fractionLength(2))
                )
                .font(.caption)
                .foregroundStyle(.secondaryText)
            }
        }
        .frame(height: 200)
        .onAppear {
            for index in data.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01 * Double(index)) {
                    withAnimation(.linear(duration: 0.01)) {
                        showUps[index] = true
                    }
                }
            }
        }
    }
}

#Preview {
    CryptoChart(coin: .mock)
}
