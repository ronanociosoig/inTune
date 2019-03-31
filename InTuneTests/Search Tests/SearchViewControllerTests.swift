//
//  SearchViewControllerTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

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
        let coordinator = appController.coordinator as! Coordinator
        
        UIApplication.shared.keyWindow?.layer.speed = 100
        let viewController = SearchWireframe.makeViewController()
        
        SearchWireframe.prepare(viewController: viewController,
                                actions: appController as SearchActions,
                                dataProvider: dataProvider as SearchDataProvider)
        
        viewController.presenter = searchPresenter
        
        let tableView = UITableView()
        viewController.tableView = tableView
        
        viewController.viewDidLoad()
        viewController.viewDidLayoutSubviews()
        viewController.viewDidAppear(true)
        
        XCTAssertTrue(searchPresenter.viewDidLayoutSubviewsCalled)
        
        coordinator.window.rootViewController = viewController
        
        viewController.showSortOptions()
        
//        let alertController = viewController.presentingViewController
//
//        _ = alertController?.view
//
//        XCTAssertNotNil(alertController)
        
        viewController.buttonAction(UIButton.init(type: .system))
        
        XCTAssertTrue(searchPresenter.viewDidLayoutSubviewsCalled)
        
        viewController.sort(with: .album)
        
        XCTAssertTrue(searchPresenter.selectedCalled)
        
        let searchBar = UISearchBar()
        searchBar.text = referenceSearchTerm
        viewController.searchBarSearchButtonClicked(searchBar)
        
        XCTAssertTrue(searchPresenter.searchCalled)
        
        let dataSource = MockSearchDataSource()
        
        viewController.setDataSource(dataSource: dataSource)
        viewController.reload()
        
        XCTAssertTrue(dataSource.numberOfRowsCalled)
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(searchPresenter.selectCalled)
    }
}

class MockSearchDataSource: SearchDataSource {
    var numberOfRowsCalled = false
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsCalled = true
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
