//
//  SongDetailPresenter.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SongDetailPresenting: class {
    func willLayoutSubviews()
}

class SongDetailPresenter {
    var actions: SongDetailActions
    var viewController: SongDetailController
    var dataProvider: SongDetailDataProvider
    var selectedResult: Result?
    
    init(viewController: SongDetailController,
         actions: SongDetailActions,
         dataProvider: SongDetailDataProvider) {
        self.viewController = viewController
        self.actions = actions
        self.dataProvider = dataProvider
        self.selectedResult = dataProvider.selectedResult()
    }
}

extension SongDetailPresenter: SongDetailPresenting {
    func willLayoutSubviews() {
        if let result = selectedResult {
            viewController.show(result: result)
        }
    }
}
