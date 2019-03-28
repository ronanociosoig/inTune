//
//  MusicPlayerViewTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class MusicPlayerViewTests: XCTestCase {
    let referenceSearchTerm = "monthy python"
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    let musicPlayer = MusicPlayerView.loadFromNib()!
    let presenter = MockMusicPresenter()
    
    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
        musicPlayer.presenter = presenter
    }

    func testMusicPlayerTitle() {
        musicPlayer.updateButtons()
        
        let result = dataProvider.allResults().first!
        let expectedTitle = result.trackName
        
        musicPlayer.configure(result: result)
        
        let title = musicPlayer.trackTitleLabel.text
        
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testNextButtonActionTapped() {
        let button = UIButton(type: .system)
        musicPlayer.nextButtonAction(button)
        
        XCTAssertTrue(presenter.nextActionCalled)
    }
    
    func testPreviousButtonActionTapped() {
        let button = UIButton(type: .system)
        musicPlayer.previousButtonAction(button)
        
        XCTAssertTrue(presenter.previousActionCalled)
    }
    
    func testToggleButtonActionTapped() {
        let button = UIButton(type: .system)
        musicPlayer.togglePlayButtonAction(button)
        
         XCTAssertTrue(presenter.togglePlayCalled)
    }
}

class MockMusicPresenter: MusicPlayerPresenting {
    var selectedIndex: Int = 0
    var maxIndex: Int = 0
    var activityView: ActivityView?
    
    var playing = false
    var togglePlayCalled = false
    var isPlayingCalled = false
    var previousActionCalled = false
    var nextActionCalled = false
    
    func togglePlay() {
        togglePlayCalled = true
        playing = !playing
    }
    
    func isPlaying() -> Bool {
        isPlayingCalled = true
        return playing
    }
    
    func previousAction() {
        previousActionCalled = true
    }
    
    func nextAction() {
        nextActionCalled = true
    }
    
    func nextItem() {
        
    }
}
