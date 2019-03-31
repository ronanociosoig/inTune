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
        return Constants.Network.searchPath
    }

    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var httpTask: HTTPTask {
        switch self {
        case .search(let term):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [Constants.Network.searchParameter: term, Constants.Network.media: Constants.Network.music,
                                          Constants.Network.entity: Constants.Network.song,
                                          Constants.Network.limit: Constants.Network.resultsLimit])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
}
