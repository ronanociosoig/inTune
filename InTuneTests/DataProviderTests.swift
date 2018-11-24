//
//  DataProviderTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class DataProviderTests: XCTestCase {
    
    let referenceSearchTerm = "monthy python"
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBasicDataProvider() {
        XCTAssertNotNil(dataProvider)
        XCTAssertNotNil(dataProvider.appData)
        XCTAssertNil(dataProvider.appData.searchTerm)
        XCTAssertTrue(dataProvider.appData.results.count == 0)
    }

    func testDataProviderStoresSearchTerm() {
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertNotNil(dataProvider.appData.searchTerm)
        XCTAssertTrue(dataProvider.appData.searchTerm == referenceSearchTerm)
    }
    
    func testDataProviderHasNoResults() {
        networkService.responseType = .noResultsResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(dataProvider.appData.results.count == 0)
    }
    
    func testDataProviderHas2Results() {
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(dataProvider.appData.results.count > 0)
        XCTAssertTrue(dataProvider.appData.results.count == 2)
    }
    
    func testDataProviderHas50Results() {
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)

        XCTAssertTrue(dataProvider.appData.results.count > 0)
        XCTAssertTrue(dataProvider.appData.results.count == 50)
    }
}
