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
    func sortBarButtonAction()
    func selected(option: SortOption)
    func viewDidLayoutSubviews()
}

class SearchPresenter {
    var actions: SearchActions!
    var viewController: ViewController!
    var dataProvider: SearchDataProvider!
    var searchResults = [SearchResult]()
    var currentSortOption: SortOption = .length
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
        selected(option: currentSortOption)
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
        
        currentSortOption = option
        
        switch option {
        case .length:
            searchResults.sort {
                $0.duration < $1.duration
            }
        case .genre:
            searchResults.sort {
                $0.genre < $1.genre
            }
        case .price:
            searchResults.sort {
                $0.price < $1.price
            }
        }
        
        viewController.reload()
    }
}
