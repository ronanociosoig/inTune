//
//  AppData.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

enum SortOption: Int {
    case length, genre, price
}

class AppData {
    var searchTerm: String?
    var results = [Result]()
    var searchResults = [SearchResult]()
    var selectedIndex: Int = 0
    
    var currentSortOption: SortOption = .length
    
    func sort(option: SortOption) {
        
        currentSortOption = option
        
        switch option {
        case .length:
            searchResults.sort {
                $0.duration < $1.duration
            }
        case .genre:
            searchResults.sort {
                $0.genre < $1.genre
            }
        case .price:
            searchResults.sort {
                $0.price < $1.price
            }
        }
    }
}
