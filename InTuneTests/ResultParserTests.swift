//
//  ResultParserTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class ResultParserTests: XCTestCase {
    let parser = ResultParser()
    
    func testResultValues() {
        let sampleResult = TestResult.makeResult()
        let searchResult = parser.parse(result: sampleResult)
        
        XCTAssertTrue(searchResult.identifier == sampleResult.artistID)
        XCTAssertTrue(searchResult.artistName == sampleResult.artistName)
        XCTAssertTrue(searchResult.trackName == sampleResult.trackName)
        XCTAssertTrue(searchResult.genre == sampleResult.primaryGenreName)
        XCTAssertTrue(searchResult.durationText == "05:35")
        XCTAssertTrue(searchResult.releaseDate == "02-11-1991")
        XCTAssertTrue(searchResult.price == "$2.55")
    }
}

struct TestResult {
    static func makeResult() -> Result {
        let trackTime: Int = (1000 * 60 * 5) + (1000 * 35) // 05:35
        let dateFormatter = DateFormatter.simpleDateFormatter()
        // Need to shift the hour of the date.
        let date = dateFormatter.date(from: "02-11-1991")!
        let releaseDate = date.addingTimeInterval(3600*2)
        return Result(wrapperType: "track",
                            kind: "song",
                            artistID: 139342,
                            trackID: 72953472,
                            artistName: "Moby",
                            trackName: "Go",
                            artistViewURL: "https://itunes.apple.com/artist/139342",
                            trackViewURL: "https://itunes.apple.com/track/72953472",
                            previewURL: "https://itunes.apple.com/preview/72953472",
                            artworkUrl30: "https://itunes.apple.com/artworkl30/72953472",
                            artworkUrl60: "https://itunes.apple.com/artworkl60/72953472",
                            artworkUrl100: "https://itunes.apple.com/artworkl00/72953472",
                            trackPrice: 2.55,
                            releaseDate: releaseDate,
                            trackTimeMillis: trackTime,
            country: "USA",
            currency: "USD",
            primaryGenreName: "Electronic",
            isStreamable: false,
            shortDescription: nil,
            longDescription: nil)
    }
}
