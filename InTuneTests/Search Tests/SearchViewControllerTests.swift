//
//  SearchViewControllerTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SearchViewControllerTests: XCTestCase {
    let referenceSearchTerm = "monthy python"
    let appController = AppController()
    let searchPresenter = MockSearchPresenter()
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    
    override func setUp() {
        appController.start()
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
    }
    
    func testSearchViewController() {
        let viewController = SearchWireframe.makeViewController()
        
        SearchWireframe.prepare(viewController: viewController,
                                actions: appController as SearchActions,
                                dataProvider: dataProvider as SearchDataProvider)
        
        viewController.presenter = searchPresenter
        viewController.tableView = UITableView()
        
        viewController.viewDidLoad()
        viewController.viewDidLayoutSubviews()
        
        XCTAssertTrue(searchPresenter.viewDidLayoutSubviewsCalled)
        
    }
}
