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
    let artworkUrl: URL
    let artistName: String
    let trackName: String
    let genre: String
    let duration: String
    let releaseDate: String
    let trackPrice: String
}
