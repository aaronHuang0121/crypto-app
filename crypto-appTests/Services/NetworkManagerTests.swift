//
//  NetworkManagerTests.swift
//  crypto-appTests
//
//  Created by Aaron on 2024/9/6.
//

import Combine
import XCTest

@testable import crypto_app

final class MockNetworkManager: RestProtocol {
    func get<P, R>(endpoint: String, params: P?) -> AnyPublisher<R, crypto_app.RestError> where P : Encodable, R : Decodable {
        if R.self == String.self {
            switch endpoint {
            case "success":
                return Just(String("Success"))
                    .tryMap({ $0 as! R })
                    .mapError({ error in
                        return RestError.unknowError(error)
                    })
                    .eraseToAnyPublisher()
            case "invalidURL":
                return Fail(error: RestError.invalidURL("invalidURL"))
                    .eraseToAnyPublisher()
            case "unableToComplete":
                return Fail(error: RestError.unableToComplete)
                    .eraseToAnyPublisher()
            case "invalidResponse":
                return Fail(error: RestError.invalidResponse(404))
                    .eraseToAnyPublisher()
            default:
                return Fail(error: RestError.unknowError(NSError()))
                    .eraseToAnyPublisher()
            }
        } else {
            return Fail(error: RestError.invalidData)
                .eraseToAnyPublisher()
        }
    }
    
    func get<R>(endpoint: String) -> AnyPublisher<R, crypto_app.RestError> where R : Decodable {
        self.get(endpoint: endpoint, params: String?.none)
    }
    
    func downloadImage(_ url: URL) -> AnyPublisher<UIImage, crypto_app.RestError> {
        if let cache = self.getImageFromCache(url) {
            return Just(cache)
                .setFailureType(to: RestError.self)
                .eraseToAnyPublisher()
        }

        if url == URL(string: "success")! {
            return Just(UIImage(systemName: "square.and.arrow.up")!)
                .setFailureType(to: RestError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: RestError.invalidData)
                .eraseToAnyPublisher()
        }
    }
    
    func getImageFromCache(_ url: URL) -> UIImage? {
        if url == URL(string: "cache")! {
            return UIImage(systemName: "photo")
        }
        
        return nil
    }
}

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: MockNetworkManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.networkManager = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.networkManager = nil
    }

    func testGetSuccess() throws {
        let expectation = self.expectation(description: "Wait for get success response")

        let publisher: AnyPublisher<String, RestError> = networkManager.get(endpoint: "success")
        let cancellable = publisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Should not failed. \(error.localizedDescription)")
                }
            } receiveValue: { result in
                XCTAssertEqual("Success", result)
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 1.0)
        cancellable.cancel()
    }

    func testGetInvalidURL() throws {
            // Test the "invalidURL" endpoint that should return an invalidURL error.
            let expectation = self.expectation(description: "Wait for get invalidURL response")
            
            let publisher: AnyPublisher<String, RestError> = networkManager.get(endpoint: "invalidURL")
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .invalidURL(let url) = error {
                        XCTAssertEqual(url, "invalidURL")
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error. \(error.localizedDescription)")
                    }
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but got some value")
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }

        func testGetUnableToComplete() throws {
            // Test the "unableToComplete" endpoint.
            let expectation = self.expectation(description: "Wait for unableToComplete response")
            
            let publisher: AnyPublisher<String, RestError> = networkManager.get(endpoint: "unableToComplete")
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .unableToComplete = error {
                        XCTAssert(true)
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error. \(error.localizedDescription)")
                    }
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but got some value")
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }

        func testGetInvalidResponse() throws {
            // Test the "invalidResponse" endpoint.
            let expectation = self.expectation(description: "Wait for invalidResponse response")
            
            let publisher: AnyPublisher<String, RestError> = networkManager.get(endpoint: "invalidResponse")
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .invalidResponse(let errorCode) = error {
                        XCTAssertEqual(errorCode, 404)
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error. \(error.localizedDescription)")
                    }
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but got some value")
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }
    
        func testUnknownError() throws {
            let expectation = self.expectation(description: "Wait for unknown error")
            
            let publisher: AnyPublisher<String, RestError> = networkManager.get(endpoint: "unknown")
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .unknowError(let error) = error {
                        XCTAssert(true)
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error. \(error.localizedDescription)")
                    }
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but got some value")
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }

        func testDownloadImageSuccess() throws {
            // Test downloading an image successfully.
            let expectation = self.expectation(description: "Wait for image download success")
            let url = URL(string: "success")!
            
            let publisher: AnyPublisher<UIImage, RestError> = networkManager.downloadImage(url)
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but got failure")
                case .finished:
                    break
                }
            }, receiveValue: { image in
                XCTAssertNotNil(image, "The image should not be nil")
                XCTAssertEqual(image, UIImage(systemName: "square.and.arrow.up"), "The image should be the expected system image")
                expectation.fulfill()
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }

        func testDownloadImageFromCache() throws {
            // Test retrieving an image from the cache.
            let url = URL(string: "cache")!
            
            let image = networkManager.getImageFromCache(url)
            XCTAssertNotNil(image, "The cached image should not be nil")
            XCTAssertEqual(image, UIImage(systemName: "photo"), "The cached image should be the expected system image")
        }

        func testDownloadImageInvalidData() throws {
            // Test downloading an image with invalid data.
            let expectation = self.expectation(description: "Wait for invalid image data")
            let url = URL(string: "invalidURL")!
            
            let publisher: AnyPublisher<UIImage, RestError> = networkManager.downloadImage(url)
            let cancellable = publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if case .invalidData = error {
                        XCTAssert(true)
                        expectation.fulfill()
                    } else {
                        XCTFail("Wrong error. \(error.localizedDescription)")
                    }
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected no value, but got some value")
            })
            
            waitForExpectations(timeout: 1.0)
            cancellable.cancel()
        }
}
