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
}

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenter!
    
    let cellIdentifier = "cellIdentifier"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.placeholder = "Search iTunes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func register() {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else { return UITableViewCell() }
        let item = presenter.item(at: indexPath)
        let name = item.trackName
        let artist = item.artistName
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = artist
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // print("Search for: \(String(describing: searchBar.text))")
        
        if let text = searchBar.text, text.count > 0 {
            presenter.search(term: text)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // let searchBar = searchController.searchBar

    }
}

extension SearchViewController: ViewController {
    func reload() {
        tableView.reloadData()
    }
}

