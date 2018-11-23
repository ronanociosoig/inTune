//
//  NetworkService.swift
//  BitRich
//
//  Created by Ronan on 04/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation


class NetworkService: ServiceProvider {
    
    let router = Router<iTunesAPI>()
    
    func makeSearchiTunesService() -> SearchiTunesLoadingService {
        return SearchiTunesService()
    }
}
