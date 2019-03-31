//
//  SearchResultTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

@testable import InTune

class SearchResultTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchResult() {
        let simpleResponseData = try! MockData.loadSimpleResponse()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let serverResponse = try! decoder.decode(ServerResponse.self, from: simpleResponseData!)
        
        let results = serverResponse.results
        
        guard let result = results.first else {
            XCTFail("There must be some results. ")
            return
        }
        
        let searchResult = SearchResult(identifier: result.trackID,
                                        artworkUrl: URL(string: result.artworkUrl100),
                                        artistName: result.artistName,
                                        trackName: result.trackName,
                                        collectionName: result.collectionName,
                                        genre: result.primaryGenreName,
                                        duration: result.trackTimeMillis,
                                        durationText: "",
                                        releaseDate: "",
                                        price: "",
                                        previewURL: "")
        
        XCTAssertNotNil(searchResult)
        
    }
}
