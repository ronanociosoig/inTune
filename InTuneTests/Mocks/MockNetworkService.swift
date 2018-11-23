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
    func makeSearchiTunesService() -> SearchiTunesLoadingService {
        return SearchiTunesService()
    }
}

class MockSearchiTunesService: NetworkService, SearchiTunesLoadingService {
    func load(term: String, completion: @escaping (Data?, String?) -> ()) {
        let outputData = try! MockData.loadComplexServerResponse()
        completion(outputData, nil)
    }
}
