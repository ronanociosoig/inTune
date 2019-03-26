//
//  MusicPlayerPresenter.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol MusicPlayerPresenting {
    
    var selectedIndex: Int { get }
    var maxIndex: Int { get }
    
    func togglePlay()
    func isPlaying() -> Bool
    func previousAction()
    func nextAction()
}

class MusicPlayerPresenter: MusicPlayerPresenting {
    let mediaPlayer: MediaPlayer
    let musicPlayerView: MusicPlayerView
    let dataProvider: MusicPlayerDataProvider
    var selectedIndex: Int = 0
    var maxIndex: Int = 0
    var activityView: ActivityView?
    var searchResults = [SearchResult]()
    var results = [Result]()
    
    init(mediaPlayer: MediaPlayer,
         musicPlayerView: MusicPlayerView,
         dataProvider: MusicPlayerDataProvider) {
        self.mediaPlayer = mediaPlayer
        self.musicPlayerView = musicPlayerView
        self.dataProvider = dataProvider
    }
    
    func configureMusicPlayer() {
        selectedIndex = dataProvider.selectedIndex()
        searchResults.removeAll()
        searchResults.append(contentsOf: dataProvider.allSearchResults())
        results.removeAll()
        results.append(contentsOf: dataProvider.allResults())
        configureMusicPlayer(at: selectedIndex)
        maxIndex = dataProvider.maxIndex()
    }
    
    func configureMusicPlayer(at index: Int) {
        let searchResult = searchResults[index]
        guard let result = result(with: searchResult.identifier) else { return }
        
        musicPlayerView.configure(result: result)
        musicPlayerView.updateButtons()
    }
    
    func result(with identifier: Int) -> Result? {
        return (results.filter { $0.trackID == identifier }).first
    }
    
    func togglePlay() {
        mediaPlayer.currentIndex = selectedIndex
        mediaPlayer.togglePlay()
    }
    
    func isPlaying() -> Bool {
        return mediaPlayer.playing
    }
    
    func previousAction() {
        
        if selectedIndex > 0 {
            selectedIndex -= 1
            mediaPlayer.previous()
            configureMusicPlayer(at: selectedIndex)
        }
    }
    
    func nextAction() {
        mediaPlayer.next()
        nextItem()
    }
    
    func nextItem() {

        if selectedIndex < maxIndex {
            selectedIndex += 1
            
            configureMusicPlayer(at: selectedIndex)
            
//            let searchResult = searchResults[selectedIndex]
//
//            guard let result = result(with: searchResult.identifier) else { return }
//
//            musicPlayerView.configure(result: result)
//            musicPlayerView.updateButtons()
        }
    }
    
    func loadMediaPlayerItems() {
        let urls = dataProvider.mediaUrls(from: 0)
        
        if mediaPlayer.playing == true {
            mediaPlayer.togglePlay()
        }
        
        DispatchQueue.global(qos: .background).async {
            self.mediaPlayer.addPlayList(list: urls)
        }
    }
}
