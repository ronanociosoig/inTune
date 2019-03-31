//
//  NetworkService.swift
//  InTune
//
//  Created by Ronan on 31/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import Foundation

class NetworkService: ServiceProvider {
    
    func makeSearchiTunesService() -> SearchiTunesLoadingService {
        return SearchiTunesService()
    }
}
