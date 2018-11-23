//
//  iTunesAPI.swift
//  InTune
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import Networking

enum iTunesAPI {
    case search(term: String)
}

extension iTunesAPI: EndPointType {
    public var baseURL: URL {
        guard let url = URL(string: Constants.Network.baseUrlPath) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    public var path: String {
        return ""
    }

    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var httpTask: HTTPTask {
        switch self {
        case .search(let term):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["term":term])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
