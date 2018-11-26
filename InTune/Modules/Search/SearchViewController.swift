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
    func showSortOptions()
}

class SearchViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenter!
    
    var sortOptionsView: SortOptionsView?
    
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
    }
    
    override func viewDidLayoutSubviews() {
        tableView.rowHeight = 61
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        presenter.viewDidLayoutSubviews()
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
    func showSortOptions() {
       //  searchController.searchBar.isHidden = true
        sortOptionsView = SortOptionsView.fromNib()
      //   navigationItem.hidesSearchBarWhenScrolling = false
        let screenWidth = view.frame.size.width
     //  guard let navigationBar = navigationController?.navigationBar else { return }
        guard let sortOptionsView = sortOptionsView else { return }
        
        let optionsFrame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: screenWidth, height: 50))
        sortOptionsView.frame = optionsFrame
        
        view.addSubview(sortOptionsView)
        //view.bringSubviewToFront(sortOptionsView)
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

