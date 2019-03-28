//
//  SongDetailTests.swift
//  InTuneTests
//
//  Created by Ronan on 28/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class SongDetailTests: KIFTestCase {

    let searchText = "Moby"
    
    override func setUp() {
        
    }
    
    func testSearchAndShareFromDetail() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "SearchResultCell")
        
        // It doesn't find the tableView
        // let firstRow = IndexPath(row: 0, section: 0)
        // tester().tapRow(at: firstRow, inTableViewWithAccessibilityIdentifier: "ResultsTable")
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: "Share")
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
