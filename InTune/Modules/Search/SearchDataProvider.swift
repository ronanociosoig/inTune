//
//  SearchDataProvider.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SearchDataProvider {
    func searchResults() -> [Result]
}

extension DataProvider: SearchDataProvider {
    func searchResults() -> [Result] {
        return appData.results
    }
}
