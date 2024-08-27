//
//  StatisticCell.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import SwiftUI

struct StatisticCell: View {
    let statistic: Statistic

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(.secondaryText)
            
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees(statistic.percentage ?? 0 >= 0 ? 0 : 180))
                
                Text(statistic.percentage?.formatted(.percent) ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(statistic.percentage ?? 0 >= 0 ? .customRed : .customGreen)
            .opacity(statistic.percentage == nil ? 0 : 1)
        }
    }
}

#Preview {
    HStack {
        StatisticCell(statistic: .mock)
        StatisticCell(statistic: .mock2)
        StatisticCell(statistic: .mock3)
    }
}
