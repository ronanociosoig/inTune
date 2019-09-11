//
//  SearchiTunesService.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import Moya
import Result

#if DEBUG
import OHHTTPStubs
#endif

public enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case notModified = "Not modified."
}

class SearchiTunesService: SearchiTunesLoadingService {
    #if DEBUG
    weak var basicStub: OHHTTPStubsDescriptor?
    #endif
    
    var provider: MoyaProvider<iTunesEndpoint> {
        if Configuration.uiTesting == true {
            return MoyaProvider<iTunesEndpoint>(stubClosure: MoyaProvider.immediatelyStub)
        } else if Configuration.networkTesting {
            return MoyaProvider<iTunesEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
        } else if Configuration.useStubs {
            #if DEBUG
            // Install - this isn't really needed as it is enabled by default
            OHHTTPStubs.setEnabled(true)
            
            // swiftlint:disable all
            let stubPath = OHPathForFile("simpleServerResponse.json", type(of: self))
            basicStub = stub(condition: isHost("itunes.apple.com")) { _ in
                let useDelay = false
                return fixture(filePath: stubPath!, headers: ["Content-Type": "text/plain"])
                    .requestTime(useDelay ? 2.0 : 0.0, responseTime:OHHTTPStubsDownloadSpeedWifi)
            }
            basicStub?.name = "Basic iTunes search stub"
            // swiftlint:enable all
            #endif
            return MoyaProvider<iTunesEndpoint>(callbackQueue: DispatchQueue.global(qos: .background))
        } else {
            return MoyaProvider<iTunesEndpoint>(callbackQueue: DispatchQueue.global(qos: .background))
        }
    }
    
    func load(term: String, completion: @escaping (_ data: Data?, _ error: String?) -> Void) {
        
        if term.isEmpty {
            completion(nil, NetworkResponse.noData.rawValue)
            return
        }
        
        provider.request(.search(term: term)) { result in
            switch result {
            case .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
