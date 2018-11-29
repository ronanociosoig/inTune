//
//  ResultParser.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

struct ResultParser {
    
    let dateFormatter = DateFormatter.simpleDateFormatter()
    let priceFormatter = NumberFormatter.priceFormatter()
    
    func parse(result: Result) -> SearchResult {
        
        let duration = TimeFormatter.string(from: result.trackTimeMillis)
        let priceNumber = result.trackPrice as NSNumber
        var price = priceFormatter.string(from: priceNumber) ?? "$0.00"
        
        if result.trackPrice < 0 {
            price = Constants.Translations.notAvailable
        }
        
        let artworkUrl = URL(string: result.artworkUrl30)
        dateFormatter.dateFormat = "yyyy"
        let releaseDate = dateFormatter.string(from: result.releaseDate)

        return SearchResult(identifier: result.trackID,
                            artworkUrl: artworkUrl,
                            artistName: result.artistName,
                            trackName: result.trackName,
                            collectionName: result.collectionName,
                            genre: result.primaryGenreName,
                            duration: result.trackTimeMillis,
                            durationText: duration,
                            releaseDate: releaseDate,
                            price: price,
                            previewURL: result.previewURL)
    }
}
