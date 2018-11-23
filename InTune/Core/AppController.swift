//
//  AppController.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

class AppController {
    // let dataProvider = DataProvider(service: NetworkService())
    var coordinator: Coordinator?
    
    func start() {
        coordinator = Coordinator()
        //coordinator?.dataProvider = dataProvider
        coordinator?.start()

    }
}
