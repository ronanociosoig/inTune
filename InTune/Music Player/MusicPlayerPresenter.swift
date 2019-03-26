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
    private var mediaPlayer: MediaPlaying
    private let musicPlayerView: MusicPlayerViewing
    private let dataProvider: MusicPlayerDataProvider
    internal var selectedIndex: Int = 0
    internal var maxIndex: Int = 0
    internal var activityView: ActivityView?
    private var searchResults = [SearchResult]()
    private var results = [Result]()
    
    init(mediaPlayer: MediaPlaying,
         musicPlayerView: MusicPlayerViewing,
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
        
        maxIndex = results.count - 1
        
        configureMusicPlayer(at: selectedIndex)
    }
    
    private func configureMusicPlayer(at index: Int) {
        let searchResult = searchResults[index]
        guard let result = result(with: searchResult.identifier) else { return }
        
        musicPlayerView.configure(result: result)
        musicPlayerView.updateButtons()
    }
    
    private func result(with identifier: Int) -> Result? {
        return (results.filter { $0.trackID == identifier }).first
    }
    
    internal func togglePlay() {
        mediaPlayer.currentIndex = selectedIndex
        mediaPlayer.togglePlay()
    }
    
    internal func isPlaying() -> Bool {
        return mediaPlayer.playing
    }
    
    internal func previousAction() {
        
        if selectedIndex > 0 {
            selectedIndex -= 1
            mediaPlayer.previous()
            configureMusicPlayer(at: selectedIndex)
        }
    }
    
    internal func nextAction() {
        mediaPlayer.next()
        nextItem()
    }
    
    internal func nextItem() {

        if selectedIndex < maxIndex {
            selectedIndex += 1
            
            configureMusicPlayer(at: selectedIndex)
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
