//
//  StatisticsRow.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/27.
//

import SwiftUI

struct StatisticsRow: View {
    @Environment(\.device) private var device

    let statistics: [Statistic]
    var showPortolio: Bool

    var body: some View {
        HStack {
            ForEach(statistics) { statistic in
                StatisticCell(statistic: statistic)
                    .frame(width: device.safeAreaWidth / CGFloat(3))
            }
        }
        .frame(
            width: device.safeAreaWidth,
            alignment: showPortolio ? .trailing : .leading
        )
    }
}

private struct PreviewWrapper: View {
    @State private var toggle: Bool = false

    var body: some View {
        VStack {
            StatisticsRow(
                statistics: [.mock, .mock2, .mock3, .mock],
                showPortolio: toggle
            )
            Toggle("Show Portolio", isOn: $toggle)
                .padding()
        }
    }
}

#Preview {
    PreviewWrapper()
}
