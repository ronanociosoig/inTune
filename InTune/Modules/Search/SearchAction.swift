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
        
        #if arch(i386) || arch(x86_64)
        self.coordinator?.showLoading()
        #else
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
