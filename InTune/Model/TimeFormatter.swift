//
//  TimeFormatter.swift
//  InTune
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

struct TimeFormatter {
    // Returns a format: 01:45:04
    static func string(from duration: Int) -> String {
//        let durationInSeconds: Int = duration / 1000
//        let seconds = durationInSeconds % 60
//        let minutes: Int = durationInSeconds / 60
//
//        if minutes > 59 {
//            let hours = minutes / 60
//            let remainder: Int = minutes % 60
//
//            return "\(zeroPrefix(hours)):\(zeroPrefix(remainder)):\(zeroPrefix(seconds))"
//        }
//
//        return "\(zeroPrefix(minutes)):\(zeroPrefix(seconds))"
        
        return "01:02"
    }
    
    static func zeroPrefix(_ value: In  t) -> String {
        return (value < 10) ? "0\(value)" : "\(value)"
    }
}
