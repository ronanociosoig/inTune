//
//  SearchPresenter.swift
//  InTune
//
//  Created by Ronan on 24/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

enum SortOption: Int {
    case length, genre, price
}

protocol SearchPresenting {
    func selected(option: SortOption)
}

class SearchPresenter {
    var action: SearchAction!
    var viewController: ViewController!
    var dataProvider: SearchDataProvider!
    var searchResults = [SearchResult]()
    var currentSortOption: SortOption = .length
    
    init(viewController: ViewController, action: SearchAction, dataProvider: SearchDataProvider) {
        self.viewController = viewController
        self.action = action
        self.dataProvider = dataProvider
    }
    
    func search(term: String) {
        action.search(term: term)
    }
    
    func dataReceived() {
        viewController.reload()
    }
    
    func numberOfItems() -> Int {
        let count = dataProvider.searchResults().count
        return count
    }
    
    func item(at indexPath: IndexPath) -> Result {
        let item = dataProvider.searchResults()[indexPath.item]
        return item
    }
}

extension SearchPresenter: SearchPresenting {
    func selected(option: SortOption) {
        
    }
}
