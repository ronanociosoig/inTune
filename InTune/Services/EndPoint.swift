//
//  EndPoint.swift
//  Network
//
//  Created by Ronan on 13/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
