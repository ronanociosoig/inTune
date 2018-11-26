//
//  URLEncoding.swift
//  Networking
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key,
                                             value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: contentTypeKey) == nil {
            urlRequest.setValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        }
    }
}
