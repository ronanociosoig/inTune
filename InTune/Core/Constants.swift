//
//  Constants.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

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
        static let cancel = "Cancel"
        static let searchBarPlaceholder = "Search iTunes for music."
        static let sortButtonTitle = "Sort"
        static let sortOptions = "Sorting Options"
        static let genreSortOption = "Genre"
        static let lengthSortOption = "Length"
        static let priceSortOption = "Price"
    
        struct Error {
            static let jsonDecodingError = "Error: JSON decoding error."
            static let noDataError = "Error: No data received."
            static let noResultsFound = "No results were found for your search."
        }
    }
    
    struct Images {
        static let placeholder = "Placeholder"
    }
    
    struct Theme {
        static let tintColor = UIColor(red: 249/255, green: 163/255, blue: 61/255, alpha: 1.0)
    }
}

