//
//  Constants.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

// swiftlint:disable nesting identifier_name

import UIKit

struct Constants {
    struct Date {
        static let formatingString = "dd-MM-yyyy"
    }
    
    struct Network {
        static let baseUrlPath = "https://itunes.apple.com"
        static let searchPath = "search"
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
        static let openIniTunes = "Open In iTunes"
        static let searchScreenTitle = "Results"
        static let notAvailable = "N/A"
        
        struct SortOptions {
            static let genre = "Genre"
            static let length = "Length"
            static let price = "Price"
            static let artist = "Artist"
            static let year = "Year"
            static let album = "Album"
        }
    
        struct Error {
            static let jsonDecodingError = "Error: JSON decoding error."
            static let noDataError = "Error: No data received."
            static let noResultsFound = "No results were found for your search."
        }
    }
    
    struct Images {
        static let placeholder = "Placeholder"
        static let largePlaceholder = "LargePlaceholder"
        static let playIcon = "PlayIcon"
        static let pauseIcon = "PauseIcon"
    }
    
    struct Theme {
        static let tintColor = "OrangeThemeColor"
    }
    
    struct MusicPlayer {
        static let height: CGFloat = 64.0
    }
    
    struct Accessibility {
        struct SearchScreen {
            static let sortButton = "Sort"
            static let resultsTable = "ResultsTable"
            static let searchButton = "Search"
            static let cell = "SearchResultCell"
            
            struct SearchBar {
                static let searchController = "SearchController"
                static let searchTextField = "SearchTextField"
                static let cancelButton = "Cancel"
            }
            
            struct SortOptions {
                static let genre = "Genre"
                static let length = "Length"
                static let price = "Price"
                static let artist = "Artist"
                static let year = "Year"
                static let album = "Album"
                static let cancel = "Cancel"
            }
        }
        struct SongDetailScreen {
            static let openIniTunesButton = "Open In iTunes"
            static let shareButton = "Share"
            
        }
        struct MediaPlayer {
            static let playButton = "Play"
            static let nextButton = "Next"
        }
    }
}
