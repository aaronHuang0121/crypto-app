//
//  Coin.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Foundation

struct Coin: Identifiable, Codable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    var marketCapRank: Double?
    let fullyDilutedValuation: Double
    let totalVolume: Double
    let high24H: Double
    let low24H: Double
    let priceChange24H: Double
    let priceChangePercentage24H: Double
    let marketCapChange24H: Double
    let marketCapChangePercentage24H: Double
    let circulatingSupply: Double
    let totalSupply: Double
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: Date
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: Date
    var roi: ROI?
    let lastUpdated: Date
    var priceChangePercentage1H: Double?
    var sparklineIn7D: SparkineIn7D?
    var currentHoldings: Double?
    var priceChangePercentage24hInCurrency: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case priceChangePercentage1H = "price_change_percentage_1h"
        case sparklineIn7D = "sparkline_in_7d"
        case currentHoldings
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
    }
}

extension Coin {
    var currentHoldingValue: Double {
        currentHoldings.map({ $0 * currentPrice }) ?? 0
    }
    
    var rank: Int {
        marketCapRank.map({ Int($0) }) ?? 0
    }
}

extension Coin {
    mutating func updateHoldings(_ amount: Double) {
        self.currentHoldings = amount
    }
}

struct SparkineIn7D: Codable, Equatable {
    let prices: [Double]?
}

struct ROI: Codable, Equatable {
    let times: Double
    let currency: String
    let percentage: Double
}

extension Coin {
    static let mock = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 70187,
        marketCap: 1381651251183,
        marketCapRank: 1,
        fullyDilutedValuation: 1474623675796,
        totalVolume: 20154184933,
        high24H: 70215,
        low24H: 68060,
        priceChange24H: 2126.88,
        priceChangePercentage24H: 3.12502,
        marketCapChange24H: 44287678051,
        marketCapChangePercentage24H: 3.31157,
        circulatingSupply: 19675987,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 73738,
        athChangePercentage: -4.77063,
        athDate: Date(timeIntervalSince1970: 1710400236.635),
        atl: 67.81,
        atlChangePercentage: 103455.83335,
        atlDate: Date(timeIntervalSince1970: 1373068800),
        roi: nil,
        lastUpdated: Date(timeIntervalSince1970: 1712508571.736),
        priceChangePercentage1H: nil,
        sparklineIn7D: nil,
        currentHoldings: nil
    )
}
