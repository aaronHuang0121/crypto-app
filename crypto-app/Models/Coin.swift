//
//  Coin.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Foundation

struct Coin: Identifiable, Codable, Equatable, Hashable {
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
    func updateHoldings(_ amount: Double) -> Coin {
        Coin(
            id: self.id,
            symbol: self.symbol,
            name: self.name,
            image: self.image,
            currentPrice: self.currentPrice,
            marketCap: self.marketCap,
            marketCapRank: self.marketCapRank,
            fullyDilutedValuation: self.fullyDilutedValuation,
            totalVolume: self.totalVolume,
            high24H: self.high24H,
            low24H: self.low24H,
            priceChange24H: self.priceChange24H,
            priceChangePercentage24H: self.priceChangePercentage24H,
            marketCapChange24H: self.marketCapChange24H,
            marketCapChangePercentage24H: self.marketCapChangePercentage24H,
            circulatingSupply: self.circulatingSupply,
            totalSupply: self.totalSupply,
            maxSupply: self.maxSupply,
            ath: self.ath,
            athChangePercentage: self.athChangePercentage,
            athDate: self.athDate,
            atl: self.atl,
            atlChangePercentage: self.atlChangePercentage,
            atlDate: self.athDate,
            lastUpdated: self.lastUpdated,
            priceChangePercentage1H: self.priceChangePercentage1H,
            sparklineIn7D: self.sparklineIn7D,
            currentHoldings: amount,
            priceChangePercentage24hInCurrency: self.priceChangePercentage24hInCurrency
        )
    }
}

struct SparkineIn7D: Codable, Equatable, Hashable {
    let price: [Double]?
}

struct ROI: Codable, Equatable, Hashable {
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
        sparklineIn7D: .init(
            price: [
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
        ),
        currentHoldings: nil
    )
}
