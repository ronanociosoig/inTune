//
//  SearchPresenter.swift
//  InTune
//
//  Created by Ronan on 24/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchPresenting: class {
    // var tappedPlayPause: PublishSubject<Any> { get };<Void>
    
    func sortBarButtonAction()
    func viewDidLayoutSubviews()
    func select(index: Int)
    func search(term: String)
    func numberOfItems() -> Int
    func item(at indexPath: IndexPath) -> SearchResult
    func dataReceived()
}

class SearchPresenter {
    private var actions: SearchActions
    private var viewController: ViewController
    private var dataProvider: SearchDataProvider
    private var term: String?
    
    let sortSubject = PublishSubject<SortOption>()
    let disposeBag = DisposeBag()
    
    let dataSource = SearchDataSource()
    
    // public let tappedPlayPause: PublishSubject<Void> = .init()
    
    init(viewController: ViewController,
         actions: SearchActions,
         dataProvider: SearchDataProvider) {
        self.viewController = viewController
        self.actions = actions
        self.dataProvider = dataProvider
        
        dataSource.presenter = self
        
        sortSubject.subscribe { (selectedOption) in
            guard let selectedOption = selectedOption.element else { return }
            self.actions.sort(option: selectedOption)
            self.viewController.reload()
        }.disposed(by: disposeBag)
    }
}

extension SearchPresenter: SearchPresenting {
    func viewDidLayoutSubviews() {
        viewController.setDataSource(dataSource: dataSource)
    }
    
    func dataReceived() {
        let searchResults = dataProvider.searchResults()
        viewController.sortButton(enabled: (!searchResults.isEmpty))
        viewController.reload()
    }
    
    func item(at indexPath: IndexPath) -> SearchResult {
        let searchResults = dataProvider.searchResults()
        return searchResults[indexPath.row]
    }
    
    func numberOfItems() -> Int {
        let searchResults = dataProvider.searchResults()
        let count = searchResults.count
        return count
    }
    
    func search(term: String) {
        self.term = term
        actions.search(term: term)
        
    }
    
    func sortBarButtonAction() {
        let alertController = SortAlertBuilder.makeSortAlertController(sortSubject: sortSubject)
        viewController.showSortOptions(alertController: alertController)
    }

    func select(index: Int) {
        actions.select(index: index)
    }
}
