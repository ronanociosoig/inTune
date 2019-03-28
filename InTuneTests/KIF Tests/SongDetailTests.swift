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
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        
        // It doesn't find the tableView
        // let firstRow = IndexPath(row: 0, section: 0)
        // tester().tapRow(at: firstRow, inTableViewWithAccessibilityIdentifier: "ResultsTable")
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SongDetailScreen.shareButton)
    }
    
    func testSearchAndOpeniTunesFromDetail() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Translations.openIniTunes)
    }
}
