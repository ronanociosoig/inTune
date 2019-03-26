//
//  SearchPresenterTests.swift
//  InTuneTests
//
//  Created by Ronan on 20/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SearchPresenterTests: XCTestCase {
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    let viewController = MockSearchViewController()
    let actions = MockSearchActions()

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchPresenter() {
        let presenter = SearchPresenter(viewController: viewController,
                                        actions: actions,
                                        dataProvider: dataProvider)
        
        
        // view did layout subviews calls set data source
        
        presenter.viewDidLayoutSubviews()
        XCTAssertTrue(viewController.setDataSourceCalled)
        
    }
}

class MockSearchActions: SearchActions {
    var searchCalled: Bool = false
    var selectCalled: Bool = false
    var sortCalled: Bool = false
    
    
    func search(term: String) {
        searchCalled = true
    }
    
    func select(index: Int) {
        selectCalled = true
    }
    
    func sort(option: SortOption) {
        sortCalled = true
    }
    
}

class MockSearchViewController: ViewController {
    var showSortOptionsCalled: Bool = false
    var sortButtonCalled: Bool = false
    var reloadCalled: Bool = false
    var setDataSourceCalled: Bool = true
    
    func reload() {
        reloadCalled = true
    }
    
    func setDataSource(dataSource: SearchDataSource) {
        setDataSourceCalled = true
    }
    
    func sortButton(enabled: Bool) {
        sortButtonCalled = true
    }
    
    func showSortOptions() {
        showSortOptionsCalled = true
    }
}
