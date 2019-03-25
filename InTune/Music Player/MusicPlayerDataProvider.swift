//
//  MusicPlayerDataProvider.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol MusicPlayerDataProvider {
    func searchResult(at index: Int) -> SearchResult
    func result(with identifier: Int) -> Result?
    func mediaUrls(from index: Int) -> [URL]
    func selectedIndex() -> Int
    func maxIndex() -> Int
}

extension DataProvider: MusicPlayerDataProvider {
    
    func searchResult(at index: Int) -> SearchResult {
        return appData.searchResults[index]
    }
    
    func result(with identifier: Int) -> Result? {
        return (appData.results.filter { $0.trackID == identifier }).first
    }
    
    func selectedIndex() -> Int {
        return appData.selectedIndex
    }
    
    func maxIndex() -> Int {
        return appData.searchResults.count - 1
    }
}
