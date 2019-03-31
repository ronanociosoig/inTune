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
    let presenter = MockSearchPresenter()
    let musicPlayerPresenter = MockMusicPlayerPresenter()

    override func setUp() {
        coordinator = Coordinator(appController: appController)
        coordinator.dataProvider = appController.dataProvider
        coordinator.start()
    }

    func testStartMakesViewController() {
        XCTAssertNotNil(coordinator.window)
        
        XCTAssertNotNil(coordinator.window.rootViewController)
    }
    
    func testShowSearch() {
        XCTAssertNotNil(coordinator.presenter)
    }
    
    func testShowLoading() {
        coordinator.window.rootViewController = UIViewController()
        coordinator.showLoading()
        
        XCTAssertNotNil(coordinator.hud)
        
        coordinator.dismissLoading()
        
        XCTAssertNil(coordinator.hud)
    }
    
    func testShowResults() {
        let presenter = MockSearchPresenter()
        coordinator.presenter = presenter
        coordinator.showSearchResults()
        
        XCTAssertTrue(presenter.dataReceivedCalled)
    }
    
    func testShowSongDetail() {
        coordinator.presenter = presenter
        
        coordinator.showSongDetail()
        
        guard let navigationController = coordinator.window.rootViewController as? UINavigationController else {
            XCTFail("RootViewController must be a NavigationController")
            return
        }
        
        let topViewController = navigationController.topViewController
        
        XCTAssertNotNil(topViewController)
    }
    
    func testShowMusicPlayer() {
        coordinator.presenter = presenter
        coordinator.showMusicPlayer()
        
        guard let navigationController = coordinator.window.rootViewController as? UINavigationController else {
            XCTFail("RootViewController must be a NavigationController")
            return
        }
        
        for view in navigationController.view.subviews {
            let name = String(describing: type(of: view))
            
            if name == "MusicPlayerView" {
                XCTAssertTrue(true)
            }
        }
        
        coordinator.hideMusicPlayer()
        
        for view in navigationController.view.subviews {
            let name = String(describing: type(of: view))
            
            if name == "MusicPlayerView" {
                
                XCTFail("The Music Player view should not visible.")
                return
            }
        }
        
        XCTAssertTrue(true)
    }
    
    func testShowAlertController() {
        coordinator.showAlert(with: "Validate Testing")
        
        guard let navigationController = coordinator.window.rootViewController as? UINavigationController else {
            XCTFail("RootViewController must be a NavigationController")
            return
        }
        
        if navigationController.presentingViewController != nil {
            XCTAssertTrue(true)
        }
    }
    
    func testMediaPlayerDelegateCalls() {
        coordinator.musicPlayerPresenter = musicPlayerPresenter
        let mediaPlayerDelegate = coordinator as MediaPlayerDelegate
        
        mediaPlayerDelegate.preroll()
        
        XCTAssertNotNil(coordinator.hud)
        
        mediaPlayerDelegate.startedPlaying()
        
        XCTAssertNil(coordinator.hud)
        
        mediaPlayerDelegate.update()
        
        XCTAssertTrue(musicPlayerPresenter.nextItemCalled)
    }
    
    func testDataReceived() {
        coordinator.musicPlayerPresenter = musicPlayerPresenter
        let dataLoadedCallback = coordinator as DataLoaded
        let presenter = MockSearchPresenter()
        coordinator.presenter = presenter
        coordinator.showLoading()
        
        let queue = DispatchQueue.main
        
        dataLoadedCallback.dataReceived(errorMessage: nil, on: queue)
        
        queue.async {
            XCTAssertNil(self.coordinator.hud)
            XCTAssertTrue(self.presenter.dataReceivedCalled)
        }
    }
}

class MockSearchPresenter: SearchPresenting {
    var dataReceivedCalled = false
    var viewDidLayoutSubviewsCalled = false
    var sortBarButtonActionCalled = false
    var selectedCalled = false
    var searchCalled = false
    var selectCalled = false 
    
    func sortBarButtonAction() {
        sortBarButtonActionCalled = true
    }
    
    func selected(option: SortOption) {
        selectedCalled = true
    }
    
    func viewDidLayoutSubviews() {
        viewDidLayoutSubviewsCalled = true
    }
    
    func select(index: Int) {
        selectCalled = true
    }
    
    func search(term: String) {
        searchCalled = true
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

class MockMusicPlayerPresenter: MusicPlayerPresenting {
    var selectedIndex: Int = 0
    var maxIndex: Int = 0
    var playing: Bool = false
    var nextItemCalled = false
    
    var activityView: ActivityView?
    
    func togglePlay() {
        
    }
    
    func isPlaying() -> Bool {
        return playing
    }
    
    func previousAction() {
        
    }
    
    func nextAction() {
        
    }
    
    func nextItem() {
        nextItemCalled = true
    }
}
