//
//  ResultParser.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

extension NumberFormatter {
    func durationFormatter() {
        
    }
}

struct ResultParser {
    
    let dateFormatter = DateFormatter.simpleDateFormatter()
    let priceFormatter = NumberFormatter()
    
    func parse(result: Result) -> SearchResult {
        priceFormatter.numberStyle = .currency
        priceFormatter.currencyCode = result.currency
        priceFormatter.currencySymbol = "$"
        
        let duration = TimeFormatter.string(from: result.trackTimeMillis)
        let priceNumber = result.trackPrice as NSNumber
        var price = priceFormatter.string(from: priceNumber) ?? "$0.00"
        
        if result.trackPrice < 0 {
            price = "N/A"
        }
        
        let artworkUrl = URL(string: result.artworkUrl100)
        let releaseDate = dateFormatter.string(from: result.releaseDate)

        return SearchResult(identifier: result.trackID,
                            artworkUrl: artworkUrl,
                            artistName: result.artistName,
                            trackName: result.trackName,
                            genre: result.primaryGenreName,
                            duration: result.trackTimeMillis,
                            durationText: duration,
                            releaseDate: releaseDate,
                            price: price)
    }
}
