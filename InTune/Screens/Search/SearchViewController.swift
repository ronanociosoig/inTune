//
//  SearchViewController.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

protocol ViewController: class {
    func reload()
    func setDataSource(dataSource: SearchDataSource)
    func sortButton(enabled: Bool)
    func showSortOptions()
}

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenting?
    private var searchText: String?
    
    private let rowHeight: CGFloat = 61
    private let sideInset: CGFloat = 5
    
    private let playerContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 63, right: 0)
    private let noPlayerContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()

        addNavigationButton()
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.Translations.searchBarPlaceholder
        searchController.searchBar.accessibilityLabel = "SearchTextField"
        searchController.searchBar.isAccessibilityElement = true
        searchController.searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor(named: Constants.Theme.tintColor)
        searchController.accessibilityLabel = "SearchController"
        searchController.isAccessibilityElement = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        title = searchText
    }
    
    override func viewDidLayoutSubviews() {
        tableView.rowHeight = rowHeight
        tableView.separatorInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        tableView.accessibilityLabel = "ResultsTable"
        tableView.isAccessibilityElement = true
        tableView.contentInset = playerContentInset
        tableView.scrollIndicatorInsets = playerContentInset
        
        presenter?.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = true
        
        guard let presenter = presenter else { return }
        
        if presenter.numberOfItems() == 0 {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = Constants.Translations.searchScreenTitle
    }
    
    private func addNavigationButton() {
        let barButton = UIBarButtonItem(title: Constants.Translations.sortButtonTitle, style: .plain, target: self, action: #selector(buttonAction))
        barButton.tintColor = UIColor(named: Constants.Theme.tintColor)
        barButton.isEnabled = false
        barButton.accessibilityLabel = "Sort"
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func buttonAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        
        presenter.sortBarButtonAction()
    }

    func showSortOptions() {
        let alertController = UIAlertController(title: nil,
                                                message: Constants.Translations.sortOptions,
                                                preferredStyle: .actionSheet)
        
        let lengthAction = UIAlertAction(title: Constants.Translations.SortOptions.length,
                                         style: .default) { (_) in
            self.sort(with: .length)
        }
        
        alertController.addAction(lengthAction)
        
        let genreAction = UIAlertAction(title: Constants.Translations.SortOptions.genre,
                                        style: .default) { (_) in
                self.sort(with: .genre)
        }
        
        alertController.addAction(genreAction)
        
        let priceAction = UIAlertAction(title: Constants.Translations.SortOptions.price,
                                        style: .default) { (_) in
                                            self.sort(with: .price)
        }
        
        alertController.addAction(priceAction)
        
        let artistNameAction = UIAlertAction(title: Constants.Translations.SortOptions.artist,
                                        style: .default) { (_) in
                                            self.sort(with: .artist)
        }
        
        alertController.addAction(artistNameAction)
        
        let yearAction = UIAlertAction(title: Constants.Translations.SortOptions.year,
                                             style: .default) { (_) in
                                                self.sort(with: .year)
        }
        
        alertController.addAction(yearAction)
        
        let albumAction = UIAlertAction(title: Constants.Translations.SortOptions.album,
                                       style: .default) { (_) in
                                        self.sort(with: .album)
        }
        albumAction.accessibilityLabel = Constants.Translations.SortOptions.album
        alertController.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: Constants.Translations.cancel,
                                        style: .cancel,
                                        handler: nil)
        
        alertController.addAction(cancelAction)
        
        present(alertController,
                               animated: true,
                               completion: nil)
    }
    
    func sort(with option: SortOption) {
        guard let presenter = presenter else { return }
        presenter.selected(option: option)
    }
}

// MARK: - UITableView Delegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let presenter = presenter else { return }
        presenter.select(index: indexPath.row)
    }
}

// MARK: - UISearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            title = text
            searchText = text
            guard let presenter = presenter else { return }
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

