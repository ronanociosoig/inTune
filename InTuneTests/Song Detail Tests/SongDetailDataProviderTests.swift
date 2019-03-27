//
//  SongDetailDataProviderTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SongDetailDataProviderTests: XCTestCase {

    let referenceSearchTerm = "monthy python"
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    
    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
    }
    
    func testExample() {
        let songDetailDataProvider = dataProvider as SongDetailDataProvider
        dataProvider.appData.selectedIndex = 1
        
        let selectedResult = songDetailDataProvider.selectedResult()
        
        XCTAssertNotNil(selectedResult)
        
    }
}
