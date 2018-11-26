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
    
    let dateFormatter = DateFormatter()
    let priceFormatter = NumberFormatter()
    // let timeFormatter =
    
//    func parse(result: Result) -> SearchResult {
//        return SearchResult()
//    }
    
    // Returns a format: 01:45:04
    func parseDuration(duration: Int) -> String {
        let durationInSeconds: Int = duration/1000
        let seconds = durationInSeconds % 60
        let minutes: Int = durationInSeconds / 60
        if minutes > 60 {
            let hours = minutes / 60
            let remainder: Int = minutes % 60
            return "\(hours):\(remainder):\(seconds)"
        }
        
        return "\(minutes):\(seconds)"
    }
}
