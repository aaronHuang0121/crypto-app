//
//  CoinTests.swift
//  crypto-appTests
//
//  Created by Aaron on 2024/8/23.
//

import XCTest

@testable import crypto_app

final class CoinTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_decodeJson_coin_shouldSucceed() throws {
        let mock = Coin.mock
        let jsonData = """
        {
            "id": "bitcoin",
            "symbol": "btc",
            "name": "Bitcoin",
            "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            "current_price": 70187,
            "market_cap": 1381651251183,
            "market_cap_rank": 1,
            "fully_diluted_valuation": 1474623675796,
            "total_volume": 20154184933,
            "high_24h": 70215,
            "low_24h": 68060,
            "price_change_24h": 2126.88,
            "price_change_percentage_24h": 3.12502,
            "market_cap_change_24h": 44287678051,
            "market_cap_change_percentage_24h": 3.31157,
            "circulating_supply": 19675987,
            "total_supply": 21000000,
            "max_supply": 21000000,
            "ath": 73738,
            "ath_change_percentage": -4.77063,
            "ath_date": "2024-03-14T07:10:36.635Z",
            "atl": 67.81,
            "atl_change_percentage": 103455.83335,
            "atl_date": "2013-07-06T00:00:00.000Z",
            "roi": null,
            "last_updated": "2024-04-07T16:49:31.736Z"
          }
        """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder()      
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            guard let date = dateFormatter.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
            }
            return date
        })
        let decoded = try decoder.decode(Coin.self, from: jsonData)
        XCTAssertEqual(decoded.id, mock.id)
        XCTAssertEqual(decoded.symbol, mock.symbol)
        XCTAssertEqual(decoded.name, mock.name)
        XCTAssertEqual(decoded.image, mock.image)
        XCTAssertEqual(decoded.currentPrice, mock.currentPrice)
        XCTAssertEqual(decoded.marketCap, mock.marketCap)
        XCTAssertEqual(decoded.marketCapRank, mock.marketCapRank)
        XCTAssertEqual(decoded.fullyDilutedValuation, mock.fullyDilutedValuation)
        XCTAssertEqual(decoded.totalVolume, mock.totalVolume)
        XCTAssertEqual(decoded.high24H, mock.high24H)
        XCTAssertEqual(decoded.low24H, mock.low24H)
        XCTAssertEqual(decoded.priceChange24H, mock.priceChange24H)
        XCTAssertEqual(decoded.priceChangePercentage24H, mock.priceChangePercentage24H)
        XCTAssertEqual(decoded.marketCapChange24H, mock.marketCapChange24H)
        XCTAssertEqual(decoded.marketCapChangePercentage24H, mock.marketCapChangePercentage24H)
        XCTAssertEqual(decoded.circulatingSupply, mock.circulatingSupply)
        XCTAssertEqual(decoded.totalSupply, mock.totalSupply)
        XCTAssertEqual(decoded.maxSupply, mock.maxSupply)
        XCTAssertEqual(decoded.ath, mock.ath)
        XCTAssertEqual(decoded.athChangePercentage, mock.athChangePercentage)
        XCTAssertEqual(decoded.athDate, mock.athDate)
        XCTAssertEqual(decoded.atl, mock.atl)
        XCTAssertEqual(decoded.atlChangePercentage, mock.atlChangePercentage)
        XCTAssertEqual(decoded.atlDate, mock.atlDate)
        XCTAssertEqual(decoded.roi, mock.roi)
        XCTAssertEqual(decoded.lastUpdated, mock.lastUpdated)
        XCTAssertEqual(decoded.priceChangePercentage1H, mock.priceChangePercentage1H)
        XCTAssertEqual(decoded.sparklineIn7D, mock.sparklineIn7D)
        XCTAssertEqual(decoded.currentHoldings, mock.currentHoldings)
    }
    
    func test_encodeJson_coin_shouldSucceed() throws {
        let mock = Coin.mock
        let jsonData = try JSONEncoder().encode(mock)
        let decoded = try JSONDecoder().decode(Coin.self, from: jsonData)
        
        XCTAssertEqual(decoded.id, mock.id)
        XCTAssertEqual(decoded.symbol, mock.symbol)
        XCTAssertEqual(decoded.name, mock.name)
        XCTAssertEqual(decoded.image, mock.image)
        XCTAssertEqual(decoded.currentPrice, mock.currentPrice)
        XCTAssertEqual(decoded.marketCap, mock.marketCap)
        XCTAssertEqual(decoded.marketCapRank, mock.marketCapRank)
        XCTAssertEqual(decoded.fullyDilutedValuation, mock.fullyDilutedValuation)
        XCTAssertEqual(decoded.totalVolume, mock.totalVolume)
        XCTAssertEqual(decoded.high24H, mock.high24H)
        XCTAssertEqual(decoded.low24H, mock.low24H)
        XCTAssertEqual(decoded.priceChange24H, mock.priceChange24H)
        XCTAssertEqual(decoded.priceChangePercentage24H, mock.priceChangePercentage24H)
        XCTAssertEqual(decoded.marketCapChange24H, mock.marketCapChange24H)
        XCTAssertEqual(decoded.marketCapChangePercentage24H, mock.marketCapChangePercentage24H)
        XCTAssertEqual(decoded.circulatingSupply, mock.circulatingSupply)
        XCTAssertEqual(decoded.totalSupply, mock.totalSupply)
        XCTAssertEqual(decoded.maxSupply, mock.maxSupply)
        XCTAssertEqual(decoded.ath, mock.ath)
        XCTAssertEqual(decoded.athChangePercentage, mock.athChangePercentage)
        XCTAssertEqual(decoded.athDate, mock.athDate)
        XCTAssertEqual(decoded.atl, mock.atl)
        XCTAssertEqual(decoded.atlChangePercentage, mock.atlChangePercentage)
        XCTAssertEqual(decoded.atlDate, mock.atlDate)
        XCTAssertEqual(decoded.roi, mock.roi)
        XCTAssertEqual(decoded.lastUpdated, mock.lastUpdated)
        XCTAssertEqual(decoded.priceChangePercentage1H, mock.priceChangePercentage1H)
        XCTAssertEqual(decoded.sparklineIn7D, mock.sparklineIn7D)
        XCTAssertEqual(decoded.currentHoldings, mock.currentHoldings)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
