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
    
    /**
     Dequeue generic type `element` of `UITableViewCell` for `indexPath`
     
     - Parameters:
     - cellType: Element.Type
     - indexPath: header for `IndexPath`
     */
    public func dequeue<Element: UITableViewCell>(cellType: Element.Type, for indexPath: IndexPath) -> Element {
        let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        
        guard let element = cell as? Element else {
            fatalError("Cell \(cell) cannot be casted as \(cellType.identifier)")
        }
        
        return element
    }
}
