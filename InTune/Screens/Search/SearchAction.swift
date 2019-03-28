//
//  SearchAction.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SearchActions {
    func search(term: String)
    func select(index: Int)
    func sort(option: SortOption)
}

extension AppController: SearchActions {
    func search(term: String) {
        dataProvider.search(term: term)
        
        // If therre is a delay in the simulator, then since the network responds faster,
        // the call to show the loading HUD can happen after the response has been received, and thus
        // it can get stuck on the screen.
        #if arch(i386) || arch(x86_64)
        self.coordinator?.showLoading()
        #else
        // This fixes a UI bug when the loading HUD appears while the keyboard is still being displayed
        // By delaying the call to show the loading HUD, it gives time for the keyboard to hide.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.coordinator?.showLoading()
        }
        #endif
    }
    
    func select(index: Int) {
        dataProvider.appData.selectedIndex = index
        coordinator?.showSongDetail()
        
        if coordinator?.musicPlayerView == nil {
            coordinator?.showMusicPlayer()
        }
        
        musicPlayerPresenter?.loadMediaPlayerItems()
        musicPlayerPresenter?.configureMusicPlayer()
    }
    
    func sort(option: SortOption) {
        dataProvider.sort(option: option)
    }
}
