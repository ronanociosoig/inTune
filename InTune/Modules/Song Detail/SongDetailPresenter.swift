//
//  SongDetailPresenter.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

class SongDetailPresenter {
    var actions: SongDetailActions!
    var viewController: SongDetailController!
    var dataProvider: SongDetailDataProvider!
    
    init(viewController: SongDetailController,
         actions: SongDetailActions,
         dataProvider: SongDetailDataProvider) {
        self.viewController = viewController
        self.actions = actions
        self.dataProvider = dataProvider
    }
}
