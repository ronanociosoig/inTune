//
//  SearchiTunesService.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import Network

class SearchiTunesService: NetworkService, SearchiTunesLoadingService {
    func load(term: String, completion: @escaping (_ data: Data?,_ error: String?)->()) {
        
        if term.count == 0 {
            completion(nil, NetworkResponse.noData.rawValue)
        }
        
        router.request(.search(term: term)) { (data, response, error) in
            
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = NetworkResponseParser.parse(response)
                
                switch result {
                case .success:
                    completion(data, nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
