//
//  Configuration.swift
//  ThoughtList
//
//  Created by Ronan on 09/02/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

struct Configuration {
    
    static var uiTesting: Bool {
        
        // We can use CommandLine.arguments for this as well.
        let arguments = ProcessInfo.processInfo.arguments
        let result = arguments.contains("UITesting")
        
        if result == true {
            // Speed up the animations in the app when running UI testing.
            UIApplication.shared.keyWindow?.layer.speed = 100
        }
        
        return result
    }
    
    static var networkTesting: Bool {
        let arguments = CommandLine.arguments
        return arguments.contains("NetworkTesting")
    }
    
    static var mockSearchData: Data? {
        return try! MockData.loadComplexServerResponse()
    }
}
