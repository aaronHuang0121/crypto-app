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
            "last_updated": "2024-04-07T16:49:31.736Z",
            "sparkline_in_7d": {
                        "price": [
                            61005.78733421509,
                            60948.17691922144,
                            60810.769041548345,
                            60913.545793254416,
                            60757.57796842585,
                            60604.46221206046,
                            60542.53727609908,
                            60513.22423696902,
                            60903.501101464666,
                            59169.10290355411,
                            58999.583067501706,
                            58868.05861956446,
                            59227.33377346871,
                            59292.82539415719,
                            59561.42502840903,
                            59060.772363156204,
                            59477.46876924232,
                            59287.74283482554,
                            59060.12610074137,
                            59009.13331494045,
                            59295.06644147175,
                            59410.03562420505,
                            59242.4062301116,
                            59370.33738264078,
                            59610.019205226825,
                            59688.748544613954,
                            59505.209064536895,
                            59341.323684985815,
                            59272.94103896139,
                            59433.15898376004,
                            59398.14200516048,
                            59517.04183871499,
                            59931.75994130691,
                            59518.13288406425,
                            59500.585638116,
                            59834.744187742945,
                            59944.1339303113,
                            60792.81990824211,
                            61524.47420600682,
                            61014.719001986436,
                            61350.064462403796,
                            61196.416673763524,
                            61108.930323290086,
                            60975.49873085402,
                            60889.695556727274,
                            60320.460014699886,
                            60615.25775495694,
                            60795.28443057881,
                            60935.99484313054,
                            60842.721465040064,
                            60894.232083015864,
                            60958.824053964636,
                            60932.02359297336,
                            61211.045261694686,
                            61376.73740019104,
                            60862.17994470777,
                            60901.35189172805,
                            60755.24024762029,
                            60289.44581145123,
                            60318.613294064446,
                            60300.558880810284,
                            60394.12509145167,
                            60308.28537322583,
                            60517.9067058922,
                            60532.15699045179,
                            60383.66005871233,
                            60519.48661932766,
                            60827.69960219288,
                            60818.06398338679,
                            60660.07504007888,
                            60614.946036560636,
                            60862.643450316245,
                            60946.07087640283,
                            61072.64188640716,
                            61116.742598936595,
                            61259.24572953686,
                            61041.90203746067,
                            61045.00293514066,
                            60816.78517998003,
                            61100.04239140031,
                            61119.04206361144,
                            61266.49135181372,
                            61566.22627047148,
                            61883.72524061102,
                            63034.25197975495,
                            63306.926239253815,
                            63771.186594942046,
                            63673.43203996905,
                            64367.731453455875,
                            64183.40662601132,
                            64162.36575527889,
                            63936.837036734,
                            63905.614348637326,
                            64034.758841340714,
                            63962.84668451357,
                            63932.554341758856,
                            63976.29051995182,
                            64231.201414131196,
                            64310.62330987425,
                            64266.71314472571,
                            64358.60916887261,
                            64135.95102342594,
                            64120.87993123906,
                            64131.99005024106,
                            64145.82498319456,
                            64075.42833552749,
                            64007.333394978436,
                            64250.14964502494,
                            64177.82268716298,
                            64274.542576046464,
                            64268.82714724803,
                            64152.90757050182,
                            63978.09316734037,
                            63966.96652548775,
                            64187.06046280384,
                            64348.38141951863,
                            64189.237324505426,
                            64179.32668855927,
                            64058.06992713776,
                            64226.14643976747,
                            64193.39226786866,
                            63986.98426792576,
                            63890.019395367206,
                            63914.83460227322,
                            63899.35295347262,
                            63994.01727917139,
                            63875.82753563255,
                            63978.71637618148,
                            64174.04585508156,
                            64184.878478399085,
                            64160.99778877754,
                            64146.798312548526,
                            64162.22727642108,
                            64206.79942164749,
                            64175.52726249115,
                            64404.26476403028,
                            64648.01695080237,
                            64668.10743447946,
                            64161.86255348353,
                            64232.150789389576,
                            63970.52896510488,
                            64061.22024001037,
                            64103.0117295644,
                            64066.217642792566,
                            63899.92754087854,
                            63832.970159577926,
                            63861.89002499945,
                            63699.15704866862,
                            63924.41283700123,
                            63836.73883798777,
                            63933.82328931946,
                            63576.318664383034,
                            63347.36179059262,
                            63256.05299398837,
                            63611.32880563979,
                            63682.379967191926,
                            63301.11051602876,
                            63519.18096059275,
                            63295.24366746738,
                            63413.572298013576,
                            63181.365739458604,
                            63119.02250734977,
                            62895.08768907413,
                            62772.132112030995,
                            63182.52894576545,
                            62964.425406138565,
                            62952.1483185441,
                            63094.222435720454
                            ]
                    }
          }
        """
            .data(using: .utf8)!
        
        let decoder = JSONDecoder.default
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
        let jsonData = try JSONEncoder.default.encode(mock)
        let decoded = try JSONDecoder.default.decode(Coin.self, from: jsonData)
        
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
