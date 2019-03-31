//
//  FormUrlEncoderTests.swift
//  NetworkingTests
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import Networking

class FormUrlEncoderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleParameterEncoding() {
        let encoder = FormUrlParameterEncoder()
        let inputData: Parameters = ["country": "UK"]
        let referenceOutput = "country=UK"
        let output = encoder.urlEncode(parameters: inputData)
        
        XCTAssertTrue(output == referenceOutput, "Output should be the same as the reference.")
    }
    
    func testMultiParameterEncoding() {
        let encoder = FormUrlParameterEncoder()
        let inputData: Parameters = ["country": "UK", "adult": 1, "locale": "en-GB"]
        let output = encoder.urlEncode(parameters: inputData)
        let parts = output.split(separator: "&")
        XCTAssertTrue(parts.count == 3)
        var hitCount = 0
        for part in parts {
            if part == "country=UK"
                || part == "adult=1"
                || part == "locale=en-GB" {
                hitCount += 1
            }
            
        }
        XCTAssertTrue(hitCount == 3, "Output should be the same as the reference.")
    }
}
