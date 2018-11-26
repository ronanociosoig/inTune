//
//  SearchResult.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let identifier: Int
    let artworkUrl: URL?
    let artistName: String
    let trackName: String
    let genre: String
    let duration: String
    let releaseDate: String
    let price: String
    
    init(identifier: Int,
         artworkUrl: URL?,
         artistName: String,
         trackName: String,
         genre: String,
         duration: String,
         releaseDate: String,
         price: String) {
        self.identifier = identifier
        self.artworkUrl = artworkUrl
        self.artistName = artistName
        self.trackName = trackName
        self.genre = genre
        self.duration = duration
        self.releaseDate = releaseDate
        self.price = price
    }
}
