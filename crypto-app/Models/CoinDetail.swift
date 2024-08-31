//
//  CoinDetail.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/28.
//

import Foundation

struct CoinDetail: Codable, Identifiable {
    let id: String?
    let symbol: String?
    let name: String?
    let webSlug: String?
    let assetPlatformid: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case webSlug = "web_slug"
        case assetPlatformid = "asset_platform_id"
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description
        case links
    }
    
    var readableDescription: String? {
        self.description?.en?.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
}

extension CoinDetail {
    struct Description: Codable, Equatable {
        let en: String?
    }
    
    struct Links: Codable, Equatable {
        let homepage: [String]?
        let subredditUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case homepage
            case subredditUrl = "subreddit_url"
        }
    }
}

extension CoinDetail {
    static let mock = CoinDetail(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        webSlug: "bitcoin",
        assetPlatformid: nil,
        blockTimeInMinutes: 10,
        hashingAlgorithm: "SHA-256",
        description: .init(en: "Bitcoin is the first successful internet money based on peer-to-peer technology..."),
        links: .init(
            homepage: [
                "http://www.bitcoin.org",
                "",
                ""
            ],
            subredditUrl: "https://www.reddit.com/r/Bitcoin/"
        )
    )
}
