//
//  ServerResponse.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

struct ServerResponse: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let wrapperType: WrapperType
    let kind: Kind
    let artistID, collectionID, trackID: Int
    let artistName: ArtistName
    let collectionName, trackName, collectionCensoredName, trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: Explicitness
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country: Country
    let currency: Currency
    let primaryGenreName: String
    let isStreamable: Bool?
    let collectionArtistName, shortDescription, longDescription: String?
    let contentAdvisoryRating: ContentAdvisoryRating?
    let collectionArtistID: Int?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName, shortDescription, longDescription, contentAdvisoryRating
        case collectionArtistID = "collectionArtistId"
    }
}

enum ArtistName: String, Codable {
    case birdsOfPrey = "Birds of Prey"
    case jeanMichelJarrePrimalScream = "Jean-Michel Jarre & Primal Scream"
    case kolchakTheNightStalker = "Kolchak: The Night Stalker"
    case maynardFerguson = "Maynard Ferguson"
    case mötleyCrüe = "Mötley Crüe"
    case primalScream = "Primal Scream"
    case rustedRoot = "Rusted Root"
}

enum Explicitness: String, Codable {
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
    case tv14 = "TV-14"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case song = "song"
    case tvEpisode = "tv-episode"
}

enum WrapperType: String, Codable {
    case track = "track"
}
