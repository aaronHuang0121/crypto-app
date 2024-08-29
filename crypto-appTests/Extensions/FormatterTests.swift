//
//  FormatterTests.swift
//  crypto-appTests
//
//  Created by Aaron on 2024/8/29.
//

import XCTest

@testable import crypto_app

final class FormatterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_double_formatted_with_abbreviations_shouldSucceed() throws {
        XCTAssertEqual(Double(12).formattedWithAbbreviations(), "12.00")
        XCTAssertEqual(Double(1234).formattedWithAbbreviations(), "1.23K")
        XCTAssertEqual(Double(123456).formattedWithAbbreviations(), "123.46K")
        XCTAssertEqual(Double(12345678).formattedWithAbbreviations(), "12.35M")
        XCTAssertEqual(Double(1234567890).formattedWithAbbreviations(), "1.23B")
        XCTAssertEqual(Double(123456789012).formattedWithAbbreviations(), "123.46B")
        XCTAssertEqual(Double(12345678901234).formattedWithAbbreviations(), "12.35T")
    }
    
    func test_double_formaated_with_currency_with_2_decimals_shouldSucceed() throws {
        // Test Case 1: Basic Positive Number
        XCTAssertEqual(1234.56.asCurrencyWith2Decimals(), "$1,234.56")
        
        // Test Case 2: Basic Negative Number
        XCTAssertEqual((-1234.56).asCurrencyWith2Decimals(), "-$1,234.56")
        
        // Test Case 3: Whole Number
        XCTAssertEqual(1000.0.asCurrencyWith2Decimals(), "$1,000.00")
        
        // Test Case 4: Large Number
        XCTAssertEqual(1000000.99.asCurrencyWith2Decimals(), "$1,000,000.99")
        
        // Test Case 5: Small Decimal Number
        XCTAssertEqual(0.56.asCurrencyWith2Decimals(), "$0.56")
        
        // Test Case 6: Very Small Number
        XCTAssertEqual(0.01.asCurrencyWith2Decimals(), "$0.01")
        
        // Test Case 7: Zero
        XCTAssertEqual(0.0.asCurrencyWith2Decimals(), "$0.00")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
