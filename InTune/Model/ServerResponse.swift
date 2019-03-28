//
//  ServerResponse.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//
// Generated by https://app.quicktype.io

import Foundation

struct ServerResponse: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let wrapperType: String
    let kind: String
    let artistID: Int
    let trackID: Int
    let artistName: String
    let collectionName: String
    let trackName: String
    let artistViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let trackPrice: Double?
    let releaseDate: Date
    let trackTimeMillis: Int
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: Bool?
    let shortDescription, longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case trackID = "trackId"
        case artistName = "artistName"
        case trackName
        case collectionName
        case artistViewURL = "artistViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100
        case trackPrice
        case releaseDate
        case trackTimeMillis, country, currency
        case isStreamable
        case primaryGenreName
        case shortDescription, longDescription
    }
    
    init(wrapperType: String,
         kind: String,
         artistID: Int,
        trackID: Int,
        artistName: String,
        trackName: String,
        collectionName: String,
        artistViewURL: String,
        trackViewURL: String,
        previewURL: String,
        artworkUrl30: String,
        artworkUrl60: String,
        artworkUrl100: String,
        trackPrice: Double?,
        releaseDate: Date,
        trackTimeMillis: Int,
        country: String,
        currency: String,
        primaryGenreName: String,
        isStreamable: Bool?,
        shortDescription: String?,
        longDescription: String?) {
        self.wrapperType = wrapperType
        self.kind = kind
        self.artistID = artistID
        self.trackID = trackID
        self.artistName = artistName
        self.trackName = trackName
        self.collectionName = collectionName
        self.artistViewURL = artistViewURL
        self.trackViewURL = trackViewURL
        self.previewURL = previewURL
        self.artworkUrl100 = artworkUrl100
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.trackTimeMillis = trackTimeMillis
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.isStreamable = isStreamable
        self.shortDescription = shortDescription
        self.longDescription = longDescription
    }
}
