//
//  MockNetworkService.swift
//  FlyByDayTests
//
//  Created by Ronan on 17/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import Networking

@testable import InTune

class MockNetworkService: ServiceProvider {
    
    var responseType: MockResponseType = .complexResponse
    
    func simulateResponseType(responseType: MockResponseType) {
        self.responseType = responseType
    }
    
    func makeSearchiTunesService() -> SearchiTunesLoadingService {
        let service = MockSearchiTunesService()
        service.responseType = responseType
        return service
    }
}

enum MockResponseType {
    case complexResponse
    case simpleResponse
    case noResultsResponse
}

class MockSearchiTunesService: NetworkService, SearchiTunesLoadingService {
    
    var responseType: MockResponseType = .complexResponse
    
    func load(term: String, completion: @escaping (Data?, String?) -> ()) {
        
        switch responseType {
        case MockResponseType.complexResponse:
            let outputData = try! MockData.loadComplexServerResponse()
            completion(outputData, nil)
            return
        case MockResponseType.simpleResponse:
            let outputData = try! MockData.loadSimpleResponse()
            completion(outputData, nil)
            return
        default:
            let outputData = try! MockData.loadNoResultsResponse()
            completion(outputData, nil)
            return
        }
    }
}
