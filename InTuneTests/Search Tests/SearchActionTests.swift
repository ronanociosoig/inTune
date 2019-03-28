//
//  SearchActionTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SearchActionTests: XCTestCase {
    let appController = AppController()
    let coordinator = MockCoordinator()
    let dataProvider = DataProvider(service: MockNetworkService())

    override func setUp() {
        appController.dataProvider = dataProvider
        appController.start()
        appController.coordinator = coordinator
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchActions() {
        let actions = appController as SearchActions
        
        actions.search(term: "Iggy Pop")
        
        XCTAssertTrue(coordinator.startLoadingCalled)
        
        actions.select(index: 0)
        
        XCTAssertTrue(coordinator.showSongDetailCalled)
        XCTAssertTrue(coordinator.showMusicPlayerCalled)
        
        actions.sort(option: .album)
    }
}

class MockCoordinator: Coordinating {
    var startLoadingCalled = false
    var showSongDetailCalled = false
    var showMusicPlayerCalled = false
    
    var musicPlayerView: MusicPlayerView?
    
    var musicPlayerPresenter: MusicPlayerPresenting?
    
    var dataProvider: DataProvider?
    
    func start() {
        
    }
    
    func showLoading() {
        startLoadingCalled = true
    }
    
    func dismissLoading() {
        
    }
    
    func showSearch() {
        
    }
    
    func showSearchResults() {
        
    }
    
    func showSongDetail() {
        showSongDetailCalled = true
    }
    
    func showMusicPlayer() {
        showMusicPlayerCalled = true
    }
}
