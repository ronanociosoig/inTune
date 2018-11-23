//
//  SearchiTunesServiceTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest
import Networking

@testable import InTune

class SearchiTunesServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchWithEmptyTermReturnsError() {
        // let referenceResponse = try! MockData.loadNoResultsResponse()

        let expectation = self.expectation(description: "No results in response data")

        let networkService = MockNetworkService()
        let searchService = networkService.makeSearchiTunesService()

        searchService.load(term: "") { (data, errorMessage) in
            XCTAssertNotNil(errorMessage)

            if errorMessage != nil {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadWithNoResultsResponse() {
        
    }
    
    func testLoadSimpleResponse() {
        
    }
    
    func testLoadComplexResponse() {
        
    }
    
    
}
