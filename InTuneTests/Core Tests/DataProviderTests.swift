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
        XCTAssertTrue(dataProvider.appData.results.isEmpty)
    }

    func testDataProviderStoresSearchTerm() {
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertNotNil(dataProvider.appData.searchTerm)
        XCTAssertTrue(dataProvider.appData.searchTerm == referenceSearchTerm)
    }
    
    func testDataProviderHasNoResults() {
        networkService.responseType = .noResultsResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(dataProvider.appData.results.isEmpty)
    }
    
    func testDataProviderHas2Results() {
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(!dataProvider.appData.results.isEmpty)
        XCTAssertTrue(dataProvider.appData.results.count == 2)
    }
    
    func testDataProviderHas50Results() {
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)

        XCTAssertTrue(!dataProvider.appData.results.isEmpty)
        XCTAssertTrue(dataProvider.appData.results.count == 50)
    }
    
    func testInvalidResponseCallsDataLoaderWithError() {
        networkService.responseType = .invalidDateResponse
        let dataLoader = MockDataLoader()
        dataProvider.dataLoaded = dataLoader
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertNotNil(dataLoader.errorMessage)
    }
    
    func testValidResponseCallsDataLoaderWithoutError() {
        networkService.responseType = .complexResponse
        let dataLoader = MockDataLoader()
        dataProvider.dataLoaded = dataLoader
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertNil(dataLoader.errorMessage)
        XCTAssertTrue(dataLoader.calledReceived)
    }
    
    func testParsingResults() {
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)

        let results = dataProvider.appData.results
        let searchResults = dataProvider.parseResults(results: results)
        XCTAssertNotNil(searchResults)
        XCTAssertTrue(results.count == searchResults.count)
    }
    
    func testParsingResultsStoredInAppData() {
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)
        
        let results = dataProvider.appData.results
        let searchResults = dataProvider.appData.searchResults
        XCTAssertNotNil(searchResults)
        XCTAssertTrue(results.count == searchResults.count)
    }
    
    func testDataIsResetOnNextSearch() {
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(!dataProvider.appData.results.isEmpty)
        XCTAssertTrue(dataProvider.appData.results.count == 50)
        
        networkService.responseType = .simpleResponse
        dataProvider.search(term: "Queen")
        
        XCTAssertTrue(dataProvider.appData.results.count == 2)
    }
    
    func testIggyPopData() {
        networkService.responseType = .iggyPopResponse
        dataProvider.search(term: "Iggy Pop")
        
        XCTAssertTrue(dataProvider.appData.results.count == 50)
    }
}

class MockDataLoader: DataLoaded {
    
    var errorMessage: String?
    var calledReceived: Bool = false
    
    func dataReceived(errorMessage: String? = nil, on queue: DispatchQueue?) {
        self.errorMessage = errorMessage
        
        calledReceived = true
    }
}
