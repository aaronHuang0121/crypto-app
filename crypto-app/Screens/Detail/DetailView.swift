//
//  DetailView.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/28.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    
    init(coin: Coin) {
        self._viewModel = .init(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer(minLength: 150)
                
                StatisticSection(
                    title: "Overview",
                    statistics: viewModel.overviews
                )
                
                StatisticSection(
                    title: "Additional Details",
                    statistics: viewModel.additionals
                )
                
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundStyle(.secondaryText)
                    
                    RemoteImage(url: viewModel.coin.image)
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}

extension DetailView {
    @ViewBuilder
    private func StatisticsGrid(_ statistics: [Statistic]) -> some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible()), count: 2),
            alignment: .leading, 
            spacing: 20
        ) {
            ForEach(statistics) { statistic in
                StatisticCell(statistic: statistic)
            }
        }
    }
    
    @ViewBuilder
    private func StatisticSection(title: String, statistics: [Statistic]) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Divider()
        
        StatisticsGrid(statistics)
    }
    
    @ViewBuilder
    private func toolbarTrailingItems() -> some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.secondaryText)
            
            RemoteImage(url: viewModel.coin.image)
                .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: .mock)
    }
}
