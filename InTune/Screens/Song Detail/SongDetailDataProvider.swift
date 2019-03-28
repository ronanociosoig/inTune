//
//  SongDetailDataProvider.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SongDetailDataProvider {
    func selectedResult() -> Result?
}

extension DataProvider: SongDetailDataProvider {
    func selectedResult() -> Result? {
        let selectedIndex = appData.selectedIndex
        return result(at: selectedIndex)
    }
}
