//
//  MusicPlayerController.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol IMusicPlayerController {
    func togglePlay()
    func isPlaying() -> Bool
    func previousAction()
    func nextAction()
}

class MusicPlayerController: IMusicPlayerController {
    let mediaPlayer: MediaPlayer
    let musicPlayerView: MusicPlayerView
    let dataProvider: MusicPlayerDataProvider
    
    init(mediaPlayer: MediaPlayer,
         musicPlayerView: MusicPlayerView,
         dataProvider: MusicPlayerDataProvider) {
        self.mediaPlayer = mediaPlayer
        self.musicPlayerView = musicPlayerView
        self.dataProvider = dataProvider
    }
    
    func configureMusicPlayer() {
        let selectedIndex = dataProvider.selectedIndex()
        let maxIndex = dataProvider.maxIndex()
        
        guard let result = dataProvider.selectedResult() else { return }
        
        musicPlayerView.selectedIndex = selectedIndex
        musicPlayerView.maxIndex = maxIndex
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
        
    }
    
    func nextAction() {
        mediaPlayer.next()
        nextItem()
    }
    
    func nextItem() {
        var selectedIndex = musicPlayerView.selectedIndex
        let maxIndex = musicPlayerView.maxIndex
        
        if selectedIndex < maxIndex {
            selectedIndex += 1
            
            let searchResult = dataProvider.searchResult(at: selectedIndex)
            
            guard let result = dataProvider.result(with: searchResult.identifier) else { return }
            
            musicPlayerView.selectedIndex = selectedIndex
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
        
        DispatchQueue.global(qos: .background).async {
            self.mediaPlayer.addPlayList(list: urls)
        }
    }
}
