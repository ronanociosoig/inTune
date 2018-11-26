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
    struct Date {
        static let formatingString = "dd-MM-yyyy"
    }
    
    struct Network {
        static let baseUrlPath = "https://itunes.apple.com"
        static let searchParameter = "term"
        static let limit = "limit"
        static let resultsLimit = 200
        static let media = "media"
        static let music = "music"
        static let entity = "entity"
        static let song = "song"
    }
    
    struct Translations {
        static let loading = "Loading"
        static let ok = "OK"
        static let searchBarPlaceholder = "Search iTunes for music."
        static let sortButtonTitle = "Sort"
    
        struct Error {
            static let jsonDecodingError = "Error: JSON decoding error."
            static let noDataError = "Error: No data received."
        }
    }
    
    struct Images {
        static let placeholder = "Placeholder"
    }
}

