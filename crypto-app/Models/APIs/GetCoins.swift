//
//  GetCoins.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Combine
import Foundation

extension Rest {
    enum GetCoins {
        struct Params: Encodable {
            let vsCurrency: String
            var order: Order?
            var perPage: Int = 100
            var page: Int = 1
            var sparkline: Bool = false
            var priceChangePercentage: String?
            
            enum Order: String, Encodable {
                case marketCapDesc = "market_cap_desc"
                case marketCapAsc = "market_cap_asc"
                case volumnDesc = "volumn_desc"
                case volumnAsc = "volumn_asc"
                case idDesc = "id_desc"
                case idAsc = "id_asc"
            }
        }
        
        typealias Response = [Coin]
    }
}

extension RestProtocol {
    func getCoins(
        params: Rest.GetCoins.Params
    ) -> AnyPublisher<Rest.GetCoins.Response, RestError> {
        get(endpoint: "/coins/markets", params: params)
    }
}
