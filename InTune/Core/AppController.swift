//
//  AppController.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol AppControlling {
    func start()
    func search(term: String)
}


class AppController: AppControlling {
    let dataProvider = DataProvider(service: NetworkService())
    var coordinator: Coordinator?
    let mediaPlayer = MediaPlayer()
    
    func start() {
        coordinator = Coordinator()
        coordinator?.appController = self
        coordinator?.dataProvider = dataProvider
        coordinator?.start()
        
        dataProvider.dataLoaded = coordinator
        mediaPlayer.delegate = coordinator
    }
    
    func configureMediaPlayer() {
        let selectedIndex = dataProvider.appData.selectedIndex
        let urls = dataProvider.mediaUrls(from: selectedIndex)
        if mediaPlayer.playing == true {
           mediaPlayer.togglePlay()
        }
        mediaPlayer.addPlayList(list: urls)
    }
    
    
}
