//
//  SearchViewController.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import Haneke

protocol ViewController {
    func reload()
    func setDataSource(dataSource: SearchDataSource)
    func sortButton(enabled: Bool)
    func showSortOptionsAlert()
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

        addNavigationButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.hidesSearchBarWhenScrolling = false
        tableView.rowHeight = 61
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
        
        if presenter.numberOfItems() == 0 {
            searchController.searchBar.becomeFirstResponder()
        }
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
}

extension SearchViewController {
    func showSortOptionsAlert() {
        
        let alertController = UIAlertController(title: nil,
                                                message: "Sort options",
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: Constants.Translations.ok,
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okButton)

        present(alertController, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            presenter.search(term: text)
        }
    }
}

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

