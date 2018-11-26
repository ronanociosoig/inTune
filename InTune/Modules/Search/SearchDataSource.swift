//
//  SearchDataSource.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    weak var presenter: SearchPresenter!
    
    func register(tableView: UITableView) {
        // let nib = ResultTableViewCell.identifier
        // let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        // tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.register(cellType: ResultTableViewCell.self)
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(cellType: ResultTableViewCell.self, for: indexPath)
        
        //guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else { return UITableViewCell() }
        let item = presenter.item(at: indexPath)
        cell.configure(with: item)
        
//        let name = item.trackName
//        let artist = item.artistName
//        cell.textLabel?.text = name
//        cell.detailTextLabel?.text = artist
//        if let url = URL(string: item.artworkUrl100) {
//            cell.imageView?.image = UIImage(named: Constants.Images.placeholder)
//            cell.imageView?.sizeToFit()
//            cell.imageView?.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.placeholder))
//        }
        
        return cell
    }
}
