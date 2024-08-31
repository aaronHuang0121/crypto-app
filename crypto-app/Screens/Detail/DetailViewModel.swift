//
//  DetailViewModel.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/28.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    let coin: Coin
    @Published var detail: CoinDetail? = nil
    @Published var overviews: [Statistic] = []
    @Published var additionals: [Statistic] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        addSubscribers(coin: coin)
    }
}

extension DetailViewModel {
    private func addSubscribers(coin: Coin) {
        getCoinDetail(coin: coin)
        self.overviews = createOverviewStatistics(coin: coin)
    }

    private func getCoinDetail(coin: Coin) {
        NetworkManager.shared
            .getCoinDetail(id: coin.id)
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        print("subscribe error: \(error.localizedDescription)")
                    }
                }, 
                receiveValue: { [weak self] detail in
                    guard let self else { return }
                    self.detail = detail
                    self.additionals = self.createAdditionalArray(detail: detail, coin: coin)
                }
            )
            .store(in: &cancellables)
    }
    
    private func createOverviewStatistics(coin: Coin) -> [Statistic] {
        let price = coin.currentPrice.asCurrencyWith2Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: "Current Price", value: price, percentage: pricePercentChange)
        
        let marketCap = "$\(coin.marketCap.formattedWithAbbreviations())"
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentage: marketCapPercentChange)

        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank, percentage: nil)

        let volume = "$\(coin.totalVolume.formattedWithAbbreviations())"
        let volumeStat = Statistic(title: "Volume", value: volume, percentage: nil)

        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func createAdditionalArray(detail: CoinDetail?, coin: Coin) -> [Statistic] {
        let high = coin.high24H.asCurrencyWith2Decimals()
        let highStat = Statistic(title: "24h High", value: high, percentage: nil)
        
        let low = coin.low24H.asCurrencyWith2Decimals()
        let lowStat = Statistic(title: "24h Low", value: low, percentage: nil)
        
        let priceChange = coin.priceChange24H.asCurrencyWith2Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentage: pricePercentChange)
        
        let marketCapChange = "$\(coin.marketCapChange24H.formattedWithAbbreviations())"
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentage: marketCapPercentChange)
        
        let blockTime = detail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(String(describing: blockTime))"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString, percentage: nil)
        
        let hashing = detail?.hashingAlgorithm ?? "N/A"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing, percentage: nil)
        
        return [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
    }
}
