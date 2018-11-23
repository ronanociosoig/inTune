//
//  FormUrlEncoderTests.swift
//  NetworkTests
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import Network

class FormUrlEncoderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleParameterEncoding() {
        let encoder = FormUrlParameterEncoder()
        let inputData: Parameters = ["country":"UK"]
        let referenceOutput = "country=UK"
        let output = encoder.urlEncode(parameters: inputData)
        
        XCTAssertTrue(output == referenceOutput, "Output should be the same as the reference.")
    }
    
    func testMultiParameterEncoding() {
        let encoder = FormUrlParameterEncoder()
        let inputData: Parameters = ["country":"UK", "adult": 1, "locale": "en-GB"]
        let referenceOutput = "country=UK&adult=1&locale=en-GB"
        let output = encoder.urlEncode(parameters: inputData)
        XCTAssertTrue(output == referenceOutput, "Output should be the same as the reference.")
    }
}
