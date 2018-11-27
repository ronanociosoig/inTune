//
//  SearchViewController.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

protocol ViewController {
    func reload()
    func setDataSource(dataSource: SearchDataSource)
    func sortButton(enabled: Bool)
    func showSortOptions()
}

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenter!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.Translations.searchBarPlaceholder
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = Constants.Theme.tintColor
        addNavigationButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidLayoutSubviews() {
        tableView.rowHeight = 61
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        presenter.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        title = ""
        
        navigationItem.hidesSearchBarWhenScrolling = true
        
        if presenter.numberOfItems() == 0 {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = "Results"
    }
    
    func addNavigationButton() {
        let barButton = UIBarButtonItem(title: Constants.Translations.sortButtonTitle, style: .plain, target: self, action: #selector(buttonAction))
        barButton.tintColor = Constants.Theme.tintColor
        barButton.isEnabled = false
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func buttonAction(_ sender: Any) {
        presenter.sortBarButtonAction()
    }

    func showSortOptions() {
        let alertController = UIAlertController(title: nil,
                                                message: Constants.Translations.sortOptions,
                                                preferredStyle: .actionSheet)
        
        let lengthAction = UIAlertAction(title: Constants.Translations.lengthSortOption,
                                         style: .default) { (_) in
            self.sort(with: .length)
        }
        
        alertController.addAction(lengthAction)
        
        let genreAction = UIAlertAction(title: Constants.Translations.genreSortOption,
                                        style: .default) { (_) in
                self.sort(with: .genre)
        }
        
        alertController.addAction(genreAction)
        
        let priceAction = UIAlertAction(title: Constants.Translations.priceSortOption,
                                        style: .default) { (_) in
                                            self.sort(with: .price)
        }
        
        alertController.addAction(priceAction)
        
        let cancelAction = UIAlertAction(title: Constants.Translations.cancel,
                                        style: .cancel,
                                        handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController,
                               animated: true,
                               completion: nil)
    }
    
    func sort(with option: SortOption) {
        presenter.selected(option: option)
    }
}

// MARK: - UITableView Delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.select(index: indexPath.row)
    }
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            presenter.search(term: text)
            searchController.isActive = false
        }
    }
}

// MARK: - ViewController protocol

extension SearchViewController: ViewController {
    func reload() {
        tableView.reloadData()
    }
    
    func setDataSource(dataSource: SearchDataSource) {
        dataSource.register(tableView: tableView)
    }
    
    func sortButton(enabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
}

