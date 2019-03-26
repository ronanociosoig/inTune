//
//  AppDataTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class AppDataTests: XCTestCase {

    let referenceSearchTerm = "monthy python"
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    
    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .complexResponse
        dataProvider.search(term: referenceSearchTerm)
    }
    
    func testsortData() {
        dataProvider.appData.sort(option: .album)
        dataProvider.appData.sort(option: .artist)
        dataProvider.appData.sort(option: .length)
        dataProvider.appData.sort(option: .genre)
        dataProvider.appData.sort(option: .price)
        dataProvider.appData.sort(option: .year)
    }
}
