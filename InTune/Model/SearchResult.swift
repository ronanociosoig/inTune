//
//  SearchResult.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let trackID: Int
    let artworkUrl100: URL
    let artistName: String
    let trackName: String
    let date: String
    let length: String
    let trackPrice: String
    let genre: String
}
