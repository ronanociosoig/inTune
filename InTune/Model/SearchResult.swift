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
    let collectionName: String
    let genre: String
    let duration: Int
    let durationText: String
    let releaseDate: String
    let price: String
    let previewURL: String
    
    init(identifier: Int,
         artworkUrl: URL?,
         artistName: String,
         trackName: String,
         collectionName: String,
         genre: String,
         duration: Int,
         durationText: String,
         releaseDate: String,
         price: String,
         previewURL: String) {
        self.identifier = identifier
        self.artworkUrl = artworkUrl
        self.artistName = artistName
        self.trackName = trackName
        self.collectionName = collectionName
        self.genre = genre
        self.duration = duration
        self.durationText = durationText
        self.releaseDate = releaseDate
        self.price = price
        self.previewURL = previewURL
    }
}
