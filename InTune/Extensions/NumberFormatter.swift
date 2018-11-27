//
//  NumberFormatter.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func priceFormatter() -> NumberFormatter {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.currencyCode = "USD"
        priceFormatter.currencySymbol = "$"
        return priceFormatter
    }
}
