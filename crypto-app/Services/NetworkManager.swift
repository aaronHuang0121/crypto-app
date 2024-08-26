//
//  NetworkManager.swift
//  crypto-app
//
//  Created by Aaron on 2024/8/23.
//

import Combine
import Foundation
import UIKit

final class NetworkManager: RestProtocol {
    static let shared = NetworkManager()
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10   // 10s
        config.urlCache = .init(
            memoryCapacity: 20 * 1024 * 1024,
            diskCapacity: 30 * 1024 * 1024
        )
        self.session = URLSession(configuration: config)
    }
    
    private func makeRequest<P: Encodable>(
        httpMethod: String,
        endpoint: String,
        params: P?
    ) -> Result<URLRequest, RestError> {
        guard let baseURL = URL(string: Rest.baseURL), 
              var component = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return .failure(.invalidURL(Rest.baseURL))
        }
        component.path = "/api/v3" + endpoint
        
        if let params {
            component.percentEncodedQueryItems = params.toQueryItems()
        }
        
        guard let url = component.url else {
            return .failure(.invalidURL(Rest.baseURL + endpoint))
        }
        
        Rest.logger.log("\(httpMethod) \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // Test token
        request.addValue("x-cg-pro-api-key", forHTTPHeaderField: "CG-xdZphsCURzUJ7vfSbVJV6YDD")
        
        return .success(request)
    }

    func request<P: Encodable, R: Decodable>(
        httpMethod: String,
        endpoint: String,
        params: P?
    ) -> AnyPublisher<R, RestError> {
        switch makeRequest(httpMethod: httpMethod, endpoint: endpoint, params: params) {
        case .success(let request):
            return self.session.dataTaskPublisher(for: request)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .tryMap({ (data, response) in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw RestError.invalidResponse(0)
                    }
                    
                    guard 200..<300 ~= httpResponse.statusCode else {
                        throw RestError.invalidResponse(httpResponse.statusCode)
                    }

                    return data
                })
                .receive(on: DispatchQueue.main)
                .decode(type: R.self, decoder: JSONDecoder.default)
                .mapError({ error in
                    if let error = error as? RestError {
                        return error
                    } else if let error = error as? DecodingError {
                        print(error.localizedDescription)
                        return RestError.unknowError(error)
                    }
                    return RestError.unknowError(error)
                })
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    func downloadImage(_ url: URL) -> AnyPublisher<UIImage, RestError> {
        let request = URLRequest(url: url)
        if let uiImage = getImageFromCache(url) {
            return Just(uiImage)
                .setFailureType(to: RestError.self)
                .eraseToAnyPublisher()
        }
        
        return self.session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw RestError.invalidResponse(0)
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw RestError.invalidResponse(httpResponse.statusCode)
                }
                
                guard let uiImage = UIImage(data: data) else {
                    throw RestError.invalidData
                }

                return uiImage
            }
            .receive(on: DispatchQueue.main)
            .mapError({ error in
                if let error = error as? RestError {
                    return error
                } else {
                    return RestError.unknowError(error)
                }
            })
            .eraseToAnyPublisher()
    }

    func getImageFromCache(_ url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cache = self.session.configuration.urlCache?.cachedResponse(for: request)?.data,
           let uiImage = UIImage(data: cache) else {
            return nil
        }

        return uiImage
    }
}

extension NetworkManager {
    func get<P, R>(
        endpoint: String,
        params: P?
    ) -> AnyPublisher<R, RestError> where P : Encodable, R : Decodable {
        request(
            httpMethod: "GET",
            endpoint: endpoint,
            params: params
        )
    }
}
