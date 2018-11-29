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
    
    init(mediaPlayer: MediaPlayer,
         musicPlayerView: MusicPlayerView,
         dataProvider: MusicPlayerDataProvider) {
        self.mediaPlayer = mediaPlayer
        self.musicPlayerView = musicPlayerView
        self.dataProvider = dataProvider
    }
    
    func configureMusicPlayer() {
        selectedIndex = dataProvider.selectedIndex()
        configureMusicPlayer(at: selectedIndex)
    }
    
    func configureMusicPlayer(at index: Int) {
        maxIndex = dataProvider.maxIndex()
        
        let searchResult = dataProvider.searchResult(at: index)
        guard let result = dataProvider.result(with: searchResult.identifier) else { return }
        
        musicPlayerView.configure(result: result)
        musicPlayerView.updateButtons()
    }
    
    func togglePlay() {
        mediaPlayer.togglePlay()
    }
    
    func isPlaying() -> Bool {
        return mediaPlayer.playing
    }
    
    func previousAction() {
        
        if selectedIndex > 0 {
            selectedIndex -= 1
            loadMediaPlayerItems(from: selectedIndex)
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
            
            let searchResult = dataProvider.searchResult(at: selectedIndex)
            
            guard let result = dataProvider.result(with: searchResult.identifier) else { return }
            
            musicPlayerView.configure(result: result)
            musicPlayerView.updateButtons()
        }
    }
    
    func loadMediaPlayerItems() {
        let selectedIndex = dataProvider.selectedIndex()
        loadMediaPlayerItems(from: selectedIndex)
    }
    
    func loadMediaPlayerItems(from index: Int) {
        
        let urls = dataProvider.mediaUrls(from: index)
        
        if mediaPlayer.playing == true {
            mediaPlayer.togglePlay()
        }
        
        //DispatchQueue.global(qos: .background).async {
            self.mediaPlayer.addPlayList(list: urls)
        //}
    }
}
