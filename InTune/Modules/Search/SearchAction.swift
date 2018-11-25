//
//  SearchAction.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SearchAction {
    func search(term: String)
}

extension AppController: SearchAction {
    func search(term: String) {
        dataProvider.search(term: term)
    }
}
