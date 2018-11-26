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
    func viewWillAppear()
}

class SearchPresenter {
    var action: SearchAction!
    var viewController: ViewController!
    var dataProvider: SearchDataProvider!
    var searchResults = [SearchResult]()
    var currentSortOption: SortOption = .length
    let dataSource: SearchDataSource
    
    init(viewController: ViewController,
         action: SearchAction,
         dataProvider: SearchDataProvider,
         dataSource: SearchDataSource) {
        self.viewController = viewController
        self.action = action
        self.dataProvider = dataProvider
        self.dataSource = dataSource
    }
    
    func viewWillAppear() {
        viewController.setDataSource(dataSource: dataSource)
    }
    
    func search(term: String) {
        action.search(term: term)
    }
    
    func dataReceived() {
        searchResults = dataProvider.searchResults()
        viewController.reload()
    }
    
    func numberOfItems() -> Int {
        let count = searchResults.count
        return count
    }
    
    func item(at indexPath: IndexPath) -> SearchResult {
        return searchResults[indexPath.row]
    }
}

extension SearchPresenter: SearchPresenting {
    func selected(option: SortOption) {
        
    }
}
