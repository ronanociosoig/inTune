//
//  MusicPlayerDataProviderTests.swift
//  InTuneTests
//
//  Created by Ronan on 25/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class MusicPlayerDataProviderTests: XCTestCase {
    let referenceSearchTerm = "monthy python"
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectedIndex() {
        let expectedSelectedIndex = 121
        let appData = dataProvider.appData
        appData.selectedIndex = expectedSelectedIndex
        
        let musicPlayerDataProvider = dataProvider as MusicPlayerDataProvider
        
        let actualSelectedIndex = musicPlayerDataProvider.selectedIndex()
        
        XCTAssertEqual(actualSelectedIndex, expectedSelectedIndex)
    }
    
    func testAllResults() {
        
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
        
        XCTAssertTrue(dataProvider.appData.results.count == 2)
        
        let musicDataProvider = dataProvider as MusicPlayerDataProvider
        
        let allResults = musicDataProvider.allResults()
        
        XCTAssertTrue(allResults.count == 2)
    }
    
    func testAllSearchResults() {
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
        
        let musicDataProvider = dataProvider as MusicPlayerDataProvider
        
        let allSearchResults = musicDataProvider.allSearchResults()
        
        XCTAssertTrue(allSearchResults.count == 2)
    }
}
