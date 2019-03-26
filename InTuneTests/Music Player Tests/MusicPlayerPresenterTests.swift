//
//  MusicPlayerPresenterTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class MusicPlayerPresenterTests: XCTestCase {
    
    let mediaPlayer = MockMediaPlayer()
    let musicPlayerView = MockMusicPlayerView()
    let musicDataProvider = MockMusicDataProvider()
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    
    let referenceSearchTerm = "monthy python"

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMusicPlayerPresenter() {
        let musicPlayerPresenter = MusicPlayerPresenter(mediaPlayer: mediaPlayer,
                                                        musicPlayerView: musicPlayerView,
                                                        dataProvider: musicDataProvider)
        
        mediaPlayer.playing = true
        
        let playing = musicPlayerPresenter.isPlaying()
        
        XCTAssertTrue(playing)
    }
    
    func testConfigurePlayer() {
        let musicPlayerPresenter = MusicPlayerPresenter(mediaPlayer: mediaPlayer,
                                                        musicPlayerView: musicPlayerView,
                                                        dataProvider: musicDataProvider)
        
        
        
        musicDataProvider.searchResults = dataProvider.allSearchResults()
        musicDataProvider.results = dataProvider.allResults()
        musicPlayerPresenter.configureMusicPlayer()
        XCTAssertTrue(musicDataProvider.allResultsCalled)
        XCTAssertTrue(musicDataProvider.allSearchResultsCalled)
        XCTAssertTrue(musicPlayerView.configureCalled)
        XCTAssertTrue(musicPlayerView.updateButtonsCalled)
    }
    
    func testLoadMediaPlayerItems() {
        let musicPlayerPresenter = MusicPlayerPresenter(mediaPlayer: mediaPlayer,
                                                        musicPlayerView: musicPlayerView,
                                                        dataProvider: musicDataProvider)
        
        
        
        musicDataProvider.searchResults = dataProvider.allSearchResults()
        musicDataProvider.results = dataProvider.allResults()
        musicPlayerPresenter.configureMusicPlayer()
        
        mediaPlayer.playing = true
        musicPlayerPresenter.loadMediaPlayerItems()
        XCTAssertTrue(musicDataProvider.mediaUrlsCalled)
        XCTAssertTrue(mediaPlayer.togglePlayCalled)
    }
}

class MockMediaPlayer: MediaPlaying {
    var playing: Bool = false
    var currentIndex: Int = 0
    
    var nextCalled: Bool = false
    var previousCalled: Bool = false
    var togglePlayCalled: Bool = false
    var addPlayListCalled: Bool = false
    
    var playlist = [URL]()
    
    func addPlayList(list: [URL]) {
        addPlayListCalled = true
        playlist.append(contentsOf: list)
    }
    
    func togglePlay() {
        togglePlayCalled = true
    }
    
    func next() {
        nextCalled = true
    }
    
    func previous() {
        previousCalled = true
    }
}

class MockMusicPlayerView: MusicPlayerViewing {
    var configureCalled: Bool = false
    var updateButtonsCalled: Bool = false
    var updatePlayerButtonCalled: Bool = false
    
    func configure(result: Result) {
        configureCalled = true
    }
    
    func updateButtons() {
        updateButtonsCalled = true
    }
    
    func updatePlayerButton() {
        updatePlayerButtonCalled = true
    }
}

class MockMusicDataProvider: MusicPlayerDataProvider {
    var results = [Result]()
    var searchResults = [SearchResult]()
    
    var mediaUrlsCalled: Bool = false
    var selectedIndexCalled: Bool = false
    var allSearchResultsCalled: Bool = false
    var allResultsCalled: Bool = false
    
    func mediaUrls(from index: Int) -> [URL] {
        mediaUrlsCalled = true
        let url1 = URL(string: "http://www.apple.com/media/file1.mp3")!
        let url2 = URL(string: "http://www.apple.com/media/file2.mp3")!
        return [url1,url2]
    }
    
    func selectedIndex() -> Int {
        selectedIndexCalled = true
        return 1
    }
    
    func allSearchResults() -> [SearchResult] {
        allSearchResultsCalled = true
        return searchResults
    }
    
    func allResults() -> [Result] {
        allResultsCalled = true
        return results
    }
}
