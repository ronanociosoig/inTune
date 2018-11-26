//
//  UITableViewCell+Extension.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// UITableViewCell identifier
    public static var identifier: String {
        return String(describing: self)
    }
}


extension UITableView {
    
    /// Register UITableViewCell type
    public func register(cellType: UITableViewCell.Type) {
        self.register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    /// Register UITableViewCell types
    public func register(cellTypes: UITableViewCell.Type...) {
        cellTypes.forEach(register)
    }
}
