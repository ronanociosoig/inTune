//
//  SearchWireframeTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SearchWireframeTests: XCTestCase {
    
    func testWireframeConnections() {
        let viewController = SearchWireframe.makeViewController()
        let appController = AppController()
        let searchDataProvider = appController.dataProvider as SearchDataProvider
        let actions = appController as SearchActions
        
        SearchWireframe.prepare(viewController: viewController,
                                actions: actions,
                                dataProvider: searchDataProvider)
        
        let presenter = viewController.presenter
        
        XCTAssertNotNil(presenter)
    }
}
