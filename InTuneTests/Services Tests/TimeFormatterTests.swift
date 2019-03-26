//
//  TimeFormatterTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class TimeFormatterTests: XCTestCase {
    func testZeroPrefixTrue() {
        let output = TimeFormatter.zeroPrefix(5)
        let expectedOutput = "05"
        XCTAssertTrue(output == expectedOutput)
    }
    
    func testZeroPrefixFalse() {
        let output = TimeFormatter.zeroPrefix(12)
        let expectedOutput = "12"
        XCTAssertTrue(output == expectedOutput)
    }
    
    func testOneSecondDurationParsing() {
        let output = TimeFormatter.string(from:1000)
        XCTAssertTrue(output == "00:01")
    }
    
    func testOneMinuteDurationParsing() {
        let output = TimeFormatter.string(from: 1000 * 60)
        XCTAssertTrue(output == "01:00")
    }
    
    func testFifteenMinutesDurationParsing() {
        let output = TimeFormatter.string(from: 1000 * 60 * 15)
        XCTAssertTrue(output == "15:00")
    }
    
    func testOneHourDurationParsing() {
        let output = TimeFormatter.string(from: 1000 * 60 * 60)
        XCTAssertTrue(output == "01:00:00")
    }
}
