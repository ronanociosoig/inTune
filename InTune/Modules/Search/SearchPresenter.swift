//
//  SearchPresenter.swift
//  InTune
//
//  Created by Ronan on 24/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SearchPresenting {
    func sortBarButtonAction()
    func selected(option: SortOption)
    func viewDidLayoutSubviews()
    func select(index: Int)
}

class SearchPresenter {
    var actions: SearchActions!
    var viewController: ViewController!
    var dataProvider: SearchDataProvider!
    var searchResults = [SearchResult]()
    let dataSource: SearchDataSource
    
    init(viewController: ViewController,
         actions: SearchActions,
         dataProvider: SearchDataProvider,
         dataSource: SearchDataSource) {
        self.viewController = viewController
        self.actions = actions
        self.dataProvider = dataProvider
        self.dataSource = dataSource
    }
    
    func viewDidLayoutSubviews() {
        viewController.setDataSource(dataSource: dataSource)
    }
    
    func search(term: String) {
        actions.search(term: term)
    }
    
    func dataReceived() {
        searchResults = dataProvider.searchResults()
        viewController.sortButton(enabled: (searchResults.count > 0))
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
    
    func sortBarButtonAction() {
        viewController.showSortOptions()
    }
    
    func selected(option: SortOption) {
        actions.sort(option: option)
        
        viewController.reload()
    }
    
    func select(index: Int) {
        actions.select(index: index)
    }
}
