//
//  SearchiTunesServiceTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SearchiTunesServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchWithEmptyTermReturnsError() {
        let referenceResponse = try! MockData.loadNoResultsResponse()
        
        
        
    }

    func testLoadWithNoResultsResponse() {
        
    }
    
    func testLoadSimpleResponse() {
        
    }
    
    func testLoadComplexResponse() {
        
    }
    
    
}
