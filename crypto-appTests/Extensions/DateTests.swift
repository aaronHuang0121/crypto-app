//
//  DateTests.swift
//  crypto-appTests
//
//  Created by Aaron on 2024/8/30.
//

import XCTest

@testable import crypto_app

final class DateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_date_toArray_shouldSucceed() throws {
        let startDate = Date(timeIntervalSince1970: 7 * 86400) // 1970-01-08 00:00:00 UTC
        let result = startDate.toArray(byAdding: -7, count: 3)
        
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0], Date(timeIntervalSince1970: 0))
        XCTAssertEqual(result[1], Date(timeIntervalSince1970: 7 * 86400 / 2))
        XCTAssertEqual(result[2], Date(timeIntervalSince1970: 7 * 86400))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
