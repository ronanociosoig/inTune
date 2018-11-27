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
    func select(item: Result)
}

extension AppController: SearchActions {
    func search(term: String) {
        dataProvider.search(term: term)
        coordinator?.showLoading()
    }
    
    func select(item: Result) {
        
    }
}
