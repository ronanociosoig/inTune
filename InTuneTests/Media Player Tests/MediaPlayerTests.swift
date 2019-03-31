//
//  MediaPlayerTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

@testable import InTune

class MediaPlayerTests: XCTestCase {
    let mediaPlayer = MediaPlayer()
    let playerDelegate = MockMediaPlayerDelegate()
    let referenceURLString = "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview71/v4/17/35/e4/1735e4a6-93be-53af-9d3d-b27b0df03df5/mzaf_1354415899743209556.plus.aac.p.m4a"

    override func setUp() {
        
    }
    
    func testMusicPlayer() {
        mediaPlayer.delegate = playerDelegate
        let url = URL(string: referenceURLString)!
        mediaPlayer.addPlayList(list: [url])
        
        mediaPlayer.togglePlay()
        XCTAssertTrue(mediaPlayer.playing)
        XCTAssertTrue(playerDelegate.prerollCalled)
    }
    
    func testNextPrevious() {
        mediaPlayer.delegate = playerDelegate
        let url = URL(string: referenceURLString)!
        mediaPlayer.addPlayList(list: [url, url, url])
        
        mediaPlayer.next()
        
        XCTAssertTrue(mediaPlayer.currentIndex == 1)
        
        mediaPlayer.next()
        
        XCTAssertTrue(mediaPlayer.currentIndex == 2)
        
        mediaPlayer.togglePlay()
        mediaPlayer.previous()
        
        XCTAssertTrue(mediaPlayer.currentIndex == 1)
        
        mediaPlayer.previous()
        
        XCTAssertTrue(mediaPlayer.currentIndex == 0)
        XCTAssertTrue(mediaPlayer.playing)
    }
}

class MockMediaPlayerDelegate: MediaPlayerDelegate {
    var updateCalled = false
    var prerollCalled = false
    var startedPlayingCalled = false
    
    func update() {
        updateCalled = true
    }
    
    func preroll() {
        prerollCalled = true
    }
    
    func startedPlaying() {
        startedPlayingCalled = true
    }
}
