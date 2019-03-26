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
    var musicPlayerPresenter: MusicPlayerPresenter?
    
    func start() {
        coordinator = Coordinator(appController: self)
        coordinator?.appController = self
        coordinator?.dataProvider = dataProvider
        coordinator?.start()
        
        dataProvider.dataLoaded = coordinator
        mediaPlayer.delegate = coordinator
    }
}
