//
//  DateFormatter.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func simpleDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = Constants.Date.formatingString
        return dateFormatter
    }
}
