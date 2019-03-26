//
//  CoordinatorTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest
import UIKit

@testable import InTune

class CoordinatorTests: XCTestCase {
    let appController = AppController()
    var coordinator: Coordinator!

    override func setUp() {
        coordinator = Coordinator(appController: appController)
        coordinator.dataProvider = appController.dataProvider
    }

    func testStartMakesViewController() {
        XCTAssertNotNil(coordinator.window)
        
        coordinator.start()
        XCTAssertNotNil(coordinator.window.rootViewController)
    }
    
    func testShowLoading() {
        coordinator.window.rootViewController = UIViewController()
        coordinator.showLoading()
        
        XCTAssertNotNil(coordinator.hud)
        
        coordinator.dismissLoading()
        
        XCTAssertNil(coordinator.hud)
    }
    
    func testShowSearch() {
        coordinator.start()
        
        XCTAssertNotNil(coordinator.presenter)
    }
    
    func testShowResults() {
        let presenter = MockSearchPresenter()
        coordinator.start()
        coordinator.presenter = presenter
        coordinator.showSearchResults()
        
        XCTAssertTrue(presenter.dataReceivedCalled)
    }
}

class MockSearchPresenter: SearchPresenting {
    var dataReceivedCalled = false
    
    func sortBarButtonAction() {
        
    }
    
    func selected(option: SortOption) {
        
    }
    
    func viewDidLayoutSubviews() {
        
    }
    
    func select(index: Int) {
        
    }
    
    func search(term: String) {
        
    }
    
    func numberOfItems() -> Int {
        return 0
    }
    
    func item(at indexPath: IndexPath) -> SearchResult {
        return SearchResult(identifier: 123, artworkUrl: URL(string: "https://itunes.apple.com"), artistName: "U2", trackName: "Bloody Sunday", collectionName: "Album", genre: "Rock", duration: 35295235, durationText: "5.45", releaseDate: "1984-03-42", price: "1.25", previewURL: "https://itunes.apple.com/preview/123/page.html")
    }
    
    func dataReceived() {
        dataReceivedCalled = true
    }
    
}
