//
//  iTunesEndpoint.swift
//  InTune
//
//  Created by Ronan on 30/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Moya

enum iTunesAPIEndpoint {
    case search(term: String)
}

extension iTunesAPIEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: Constants.Network.baseUrlPath)!
    }
    
    var path: String {
        return Constants.Network.searchPath
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data() //try! MockData.loadComplexServerResponse()
    }
    
    var task: Task {
        switch self {
        case .search(let term):
            return .requestParameters(parameters: [Constants.Network.searchParameter:term, Constants.Network.media:Constants.Network.music,
                                                   Constants.Network.entity:Constants.Network.song,
                                                   Constants.Network.limit: Constants.Network.resultsLimit], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
