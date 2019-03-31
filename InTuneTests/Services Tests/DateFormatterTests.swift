//
//  DateFormatterTests.swift
//  InTuneTests
//
//  Created by Ronan on 03/12/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

@testable import InTune

class DateFormatterTests: XCTestCase {
    let dateFormatter = DateFormatter()
    
    func testUpperCaseYearBeforeMonth() {
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let referenceDate = "2018-01-02"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertTrue(referenceDate == dateString)
    }
    
    func testLowerCaseYearAfterMonth() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let referenceDate = "02-01-2018"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertTrue(referenceDate == dateString)
    }
    
    func testUpperCaseYearWithMonthAndDay() {
        dateFormatter.dateFormat = "YYYY-MM-d"
        let referenceDate = "2018-01-12"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertTrue(referenceDate == dateString)
    }
    
    // The tests below assert to false because of the way that date format works.
    // The error is in using YYYY instead of yyyy
    // But note that from the test cases above, it does work some times. 
    
    func testUpperCaseYearAfterMonth() {
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let referenceDate = "02-01-2018"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertFalse(referenceDate == dateString)
        print("Date is: \(dateString)")
    }
    
    func testUpperCaseYearOnly() {
        dateFormatter.dateFormat = "YYYY"
        let referenceDate = "2018"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertFalse(referenceDate == dateString)
    }
    
    func testUpperCaseYearWithMonth() {
        dateFormatter.dateFormat = "YYYY-MM"
        let referenceDate = "2018-01"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertFalse(referenceDate == dateString)
    }
    
    func testMonthAndDayWithUpperCaseYear() {
        dateFormatter.dateFormat = "MM-d-YYYY"
        let referenceDate = "01-12-2018"
        let date = dateFormatter.date(from: referenceDate)
        let dateString = dateFormatter.string(from: date!)
        XCTAssertFalse(referenceDate == dateString)
    }
}
