//
//  UIView+Extension.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

extension UIView {
    
    /// UIView identifier
    var identifier: String {
        return String(describing: type(of: self))
    }
}
