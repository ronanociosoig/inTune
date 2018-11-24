//
//  Constants.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol LocalisedMessages {
    
}

struct Constants {
    struct Network {
        static let baseUrlPath = "https://itunes.apple.com/search"
        static let searchParameter = "terms"
    }
    
    struct Translations {
        static let loading = "Loading"
        static let ok = "OK"
    
        struct Error {
            static let jsonDecodingError = "Error: JSON decoding error."
            static let noDataError = "Error: No data received."
        }
    }
}

