//
//  SongDetailDataProvider.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol SongDetailDataProvider {
    func next()
    func previous()
}

extension DataProvider: SongDetailDataProvider {
    func next() {
        
    }
    
    func previous() {
        
    }
}
