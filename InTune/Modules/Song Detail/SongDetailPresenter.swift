//
//  SongDetailPresenter.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SongDetailPresenting {
    func willLayoutSubviews()
}

protocol SongPlayer {
    func togglePlay()
    func next()
}

class SongDetailPresenter: SongPlayer {
    var actions: SongDetailActions!
    var viewController: SongDetailController!
    var dataProvider: SongDetailDataProvider!
    var selectedResult: Result?
    let mediaPlayer = MediaPlayer()
    
    init(viewController: SongDetailController,
         actions: SongDetailActions,
         dataProvider: SongDetailDataProvider) {
        self.viewController = viewController
        self.actions = actions
        self.dataProvider = dataProvider
        self.selectedResult = dataProvider.selectedResult()
    }
    
    func togglePlay() {
        guard let preview = selectedResult?.previewURL else { return }
        guard let url = URL(string: preview) else { return }
        mediaPlayer.play(url: url)
    }
    
    func next() {
        
    }
}

extension SongDetailPresenter: SongDetailPresenting {
    func willLayoutSubviews() {
        if let result = selectedResult {
            viewController.show(result: result)
        }
    }
}
