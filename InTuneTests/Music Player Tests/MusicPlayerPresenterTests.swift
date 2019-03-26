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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func mediaUrls(from index: Int) -> [URL] {
        let url1 = URL(string: "http://www.apple.com/media/file1.mp3")!
        let url2 = URL(string: "http://www.apple.com/media/file2.mp3")!
        return [url1,url2]
    }
    
    func selectedIndex() -> Int {
        return 1
    }
    
    func allSearchResults() -> [SearchResult] {
        return searchResults
    }
    
    func allResults() -> [Result] {
        return results
    }
}
