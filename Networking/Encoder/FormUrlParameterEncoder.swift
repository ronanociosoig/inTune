//
//  FormUrlParameterEncoder.swift
//  Networking
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

public struct FormUrlParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        let formattedParameters = urlEncode(parameters: parameters)
        urlRequest.httpBody = formattedParameters.data(using: .utf8, allowLossyConversion: false)
    }
    
    public func urlEncode(parameters: Parameters) -> String {
        var output = ""
        var first = true
        for (key, value) in parameters {
            var join = ""
            if first == true {
                first = false
            } else {
                join = "&"
            }
            
            if value is Int || value is String || value is Double || value is Float {
                output.append(join + key + "=" + toString(value))
            }
        }
        return output
    }
    
    public func toString(_ value: Any) -> String {
        return "\(value)"
    }
}
