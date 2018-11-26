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
        let price = priceFormatter.string(from: priceNumber) ?? "$0.00"
        let artworkUrl = URL(string: result.artworkUrl100)
        let releaseDate = dateFormatter.string(from: result.releaseDate)

        return SearchResult(identifier: result.artistID,
                            artworkUrl: artworkUrl,
                            artistName: result.artistName,
                            trackName: result.trackName,
                            genre: result.primaryGenreName,
                            duration: duration,
                            releaseDate: releaseDate,
                            price: price)
    }
}
