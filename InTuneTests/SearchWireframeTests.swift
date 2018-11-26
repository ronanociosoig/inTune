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
        let action = appController as SearchAction
        
        SearchWireframe.prepare(viewController: viewController,
                                action: action,
                                dataProvider: searchDataProvider)
        
        let presenter = viewController.presenter
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter!.dataSource)
        
        viewController.viewDidLoad()
        viewController.viewWillAppear(false)
        
        XCTAssertNotNil(viewController.tableView.dataSource)
    }

}
