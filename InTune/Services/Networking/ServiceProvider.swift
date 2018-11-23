//
//  ServiceProvider.swift
//  FlyByDay
//
//  Created by Ronan on 17/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol ServiceProvider: AnyObject {
    func makeSearchiTunesService() -> SearchiTunesLoadingService
}

protocol SearchiTunesLoadingService: AnyObject {
    func load(term: String, completion: @escaping (_ data: Data?,_ error: String?)->())
}

