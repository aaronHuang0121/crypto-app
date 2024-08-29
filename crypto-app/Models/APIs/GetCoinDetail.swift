//
//  GetCoinDetail.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/29.
//

import Combine
import Foundation

extension Rest {
    enum GetCoinDetail {
        typealias Response = CoinDetail
    }
}

extension RestProtocol {
    func getCoinDetail(id: String) -> AnyPublisher<Rest.GetCoinDetail.Response, RestError> {
        get(endpoint: "/coins/\(id)")
    }
}
