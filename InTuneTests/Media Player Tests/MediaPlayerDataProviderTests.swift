//
//  MediaPlayerDataProviderTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable force_unwrapping

import XCTest

@testable import InTune

class MediaPlayerDataProviderTests: XCTestCase {
    let referenceSearchTerm = "monthy python"
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    
    override func setUp() {
        dataProvider = DataProvider(service: networkService)
        networkService.responseType = .simpleResponse
        dataProvider.search(term: referenceSearchTerm)
    }
    
    func testMediaPlayerDataProvider() {
        let expectedURLString = "https://audio-ssl.itunes.apple.com/apple-assets-us-std-000001/AudioPreview71/v4/17/35/e4/1735e4a6-93be-53af-9d3d-b27b0df03df5/mzaf_1354415899743209556.plus.aac.p.m4a"
        
        let mediaDataProvider = dataProvider as MediaPlayerDataProvider
        
        let mediaUrls = mediaDataProvider.mediaUrls(from: 0)
        
        XCTAssertTrue(mediaUrls.count == 2)
            
        let firstUrl = mediaUrls.first!
        let firstPath = firstUrl.absoluteString
        
        XCTAssertEqual(firstPath, expectedURLString)
    }
}
