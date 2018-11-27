//
//  SongDetailDataProvider.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SongDetailDataProvider {
    func nextResult() -> Result?
    func previousResult() -> Result?
    func selectedResult() -> Result?
}

extension DataProvider: SongDetailDataProvider {
    func nextResult() -> Result? {
        if appData.selectedIndex < appData.searchResults.count - 1 {
            appData.selectedIndex += 1
        } else {
            appData.selectedIndex = 0
        }
        return selectedResult()
    }
    
    func previousResult() -> Result? {
        if appData.selectedIndex > 0 {
           appData.selectedIndex -= 1
        } else {
            appData.selectedIndex = appData.searchResults.count - 1
        }
        return selectedResult()
    }
    
    func selectedResult() -> Result? {
        let selectedIndex = appData.selectedIndex
        return result(at: selectedIndex)
    }
}
