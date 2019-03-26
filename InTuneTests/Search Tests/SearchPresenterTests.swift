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
    let expectedSearchTerm = "House"

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
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
        
        // dataReceived calls sort button enable and reload
        presenter.dataReceived()
        XCTAssertTrue(viewController.reloadCalled)
        XCTAssertTrue(viewController.sortButtonCalled)
        XCTAssertFalse(viewController.sortButtonEnabled)
        
        dataProvider.search(term: expectedSearchTerm)
        
        presenter.dataReceived()
        XCTAssertTrue(viewController.sortButtonEnabled)
        
        presenter.sortBarButtonAction()
        XCTAssertTrue(viewController.showSortOptionsCalled)
    }
    
    func testSearchActionsCalled() {
        
        let presenter = SearchPresenter(viewController: viewController,
                                        actions: actions,
                                        dataProvider: dataProvider)
        
        presenter.search(term: expectedSearchTerm)
        
        XCTAssertTrue(actions.searchCalled)
        XCTAssertTrue(actions.term == expectedSearchTerm)

    }
}

class MockSearchActions: SearchActions {
    var searchCalled: Bool = false
    var selectCalled: Bool = false
    var sortCalled: Bool = false
    var term: String?
    
    func search(term: String) {
        searchCalled = true
        self.term = term
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
    var sortButtonEnabled: Bool = false
    
    func reload() {
        reloadCalled = true
    }
    
    func setDataSource(dataSource: SearchDataSource) {
        setDataSourceCalled = true
    }
    
    func sortButton(enabled: Bool) {
        sortButtonCalled = true
        sortButtonEnabled = enabled
    }
    
    func showSortOptions() {
        showSortOptionsCalled = true
    }
}
