//
//  iTunesEndpoint.swift
//  InTune
//
//  Created by Ronan on 30/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation
import Moya

enum iTunesEndpoint {
    case search(term: String)
}

extension iTunesEndpoint: TargetType {
    // swiftlint:disable force_unwrapping
    var baseURL: URL {
        return URL(string: Constants.Network.baseUrlPath)!
    }
    // swiftlint:enable force_unwrapping
    
    var path: String {
        return Constants.Network.searchPath
    }
    
    var method: Moya.Method {
        return .get
    }
    
    // swiftlint:disable force_try force_unwrapping
    var sampleData: Data {
        return try! MockData.loadComplexServerResponse()!
    }
    
    // swiftlint:enable force_try force_unwrapping
    
    var task: Task {
        switch self {
        case .search(let term):
            return .requestParameters(parameters:
                [Constants.Network.searchParameter: term,
                 Constants.Network.media: Constants.Network.music,
                Constants.Network.entity: Constants.Network.song,
                Constants.Network.limit: Constants.Network.resultsLimit],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
