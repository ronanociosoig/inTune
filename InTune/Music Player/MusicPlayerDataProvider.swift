//
//  MusicPlayerDataProvider.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol MusicPlayerDataProvider {
    func mediaUrls(from index: Int) -> [URL]
    func selectedIndex() -> Int
    func maxIndex() -> Int
    func allSearchResults() -> [SearchResult]
    func allResults() -> [Result]
}

extension DataProvider: MusicPlayerDataProvider {
    
    func selectedIndex() -> Int {
        return appData.selectedIndex
    }
    
    func maxIndex() -> Int {
        return appData.searchResults.count - 1
    }
    
    func allSearchResults() -> [SearchResult] {
        return appData.searchResults
    }
    
    func allResults() -> [Result] {
        return appData.results
    }
}
