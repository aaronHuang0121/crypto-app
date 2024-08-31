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
                CryptoChart(coin: viewModel.coin)
                
                StatisticSection(
                    title: "Overview",
                    statistics: viewModel.overviews,
                    showDescription: true
                )
                
                StatisticSection(
                    title: "Additional Details",
                    statistics: viewModel.additionals
                )
                
                VStack(alignment: .leading, spacing: 10) {
                    if let websiteURL = viewModel.websiteURL {
                        Link("Website", destination: websiteURL)
                    }
                    
                    if let redditURL = viewModel.redditURL {
                        Link("Reddit", destination: redditURL)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.blue)
                .font(.headline)
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
    private func StatisticSection(
        title: String,
        statistics: [Statistic],
        showDescription: Bool = false
    ) -> some View {
        Text(title)
            .font(.title)
            .bold()
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Divider()
        
        if showDescription, let description = viewModel.description {
            VStack(alignment: .leading) {
                Text(description)
                    .lineLimit(viewModel.showFullDescription ? nil : 3)
                    .font(.callout)
                    .foregroundStyle(.secondaryText)
                
                Button(
                    action: {
                        viewModel.showFullDescription.toggle()
                    },
                    label: {
                        Text(viewModel.showFullDescription ? "Less" : "Read more...")
                    }
                )
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.vertical, 4)
            }
            .animation(.easeInOut, value: viewModel.showFullDescription)
        }
        
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
