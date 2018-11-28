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
        coordinator?.showLoading()
    }
    
    func select(index: Int) {
        dataProvider.appData.selectedIndex = index
        coordinator?.showSongDetail()
        
        if coordinator?.musicPlayerView == nil {
            coordinator?.showMusicPlayer()
        }
        
        coordinator?.configureMusicPlayer()
        configureMediaPlayer()
    }
    
    func sort(option: SortOption) {
        dataProvider.sort(option: option)
    }
}
