//
//  SearchiTunesServiceTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

// swiftlint:disable all

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
        // let referenceResponse = try! MockData.loadNoResultsResponse()

        let expectation = self.expectation(description: "No results in response data")

        let networkService = NetworkService()
        let searchService = networkService.makeSearchiTunesService()

        searchService.load(term: "") { (_, errorMessage) in
            XCTAssertNotNil(errorMessage)

            if errorMessage != nil {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadComplexResponse() {
        let expectation = self.expectation(description: "No results in response data")
        
        let networkService = MockNetworkService()
        let searchService = networkService.makeSearchiTunesService() as! MockSearchiTunesService
        searchService.responseType = .complexResponse
        
        searchService.load(term: "something you cannot find") { (data, _) in
            XCTAssertNotNil(data)
            
            if data != nil {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadIggyPopResponse() {
        let expectation = self.expectation(description: "No results in response data")
        
        let networkService = MockNetworkService()
        let searchService = networkService.makeSearchiTunesService() as! MockSearchiTunesService
        searchService.responseType = .iggyPopResponse
        
        searchService.load(term: "something you cannot find") { (data, _) in
            XCTAssertNotNil(data)
            
            if data != nil {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadDataFromServer() {
        let searchTerm = "South Side"
        let expectation = self.expectation(description: "Search for Moby on iTunes.")
        let networkService = NetworkService()
        let searchService = networkService.makeSearchiTunesService()
 
        searchService.load(term: searchTerm) { (data, errorMessage) in
            if let errorMessage = errorMessage {
                print("Error message: \(errorMessage)")
                XCTFail()
                return
            }
            
            guard let data = data else {
                XCTFail("Must have a response to run the test.")
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let dict = jsonData as? NSDictionary
                let results = dict?["results"]
                
                print("results output: \(String(describing: results))")
                expectation.fulfill()
            } catch {
                XCTFail("Failed to parse the JSON response.")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
