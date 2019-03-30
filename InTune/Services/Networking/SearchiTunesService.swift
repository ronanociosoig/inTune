//
//  SearchiTunesService.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import Networking
import Moya
import Result

class SearchiTunesService: SearchiTunesLoadingService {
    var provider: MoyaProvider<iTunesEndpoint> {
        if Configuration.uiTesting == true {
            return MoyaProvider<iTunesEndpoint>(stubClosure: MoyaProvider.immediatelyStub)
        } else if Configuration.networkTesting {
            return MoyaProvider<iTunesEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
        } else {
            return MoyaProvider<iTunesEndpoint>(callbackQueue: DispatchQueue.global(qos: .background))
        }
    }
    
    func load(term: String, completion: @escaping (_ data: Data?,_ error: String?)->()) {
        
        if term.count == 0 {
            completion(nil, NetworkResponse.noData.rawValue)
            return
        }
        
        provider.request(.search(term: term)) { result in
            switch result {
            case .success(let response):
                completion(response.data,nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
