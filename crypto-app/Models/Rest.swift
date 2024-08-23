//
//  Rest.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Combine
import Foundation
import os

enum Rest {
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Rest")
    static let baseURL = "https://api.coingecko.com"
}

enum RestError: LocalizedError {
    case invalidURL(String)
    case unableToComplete
    case invalidResponse(Int)
    case invalidData
    case unknowError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid Url: \(url)"
        case .unableToComplete:
            return "Unable to complete"
        case .invalidResponse(let statusCode):
            return "Invalid response with error code: \(statusCode)"
        case .invalidData:
            return "Invalid data"
        case .unknowError(let error):
            return error.localizedDescription
        }
    }
}

protocol RestProtocol {
    func get<P: Encodable, R: Decodable>(
        endpoint: String,
        params: P?
    ) -> AnyPublisher<R, RestError>
}
