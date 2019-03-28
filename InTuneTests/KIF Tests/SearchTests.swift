//
//  SearchTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class SearchTests: KIFTestCase {
    
    let searchText = "Moby"

    override func setUp() {
        
    }
    
    func testSearchAndSortCancel() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Cancel")
    }
    
    func testSearchAndSortByAlbum() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Album")
    }
    
    func testSearchAndSortByLength() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Length")
    }
    
    func testSearchAndSortByPrice() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Price")
    }
    
    func testSearchAndSortByArtist() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Artist")
    }
    
    func testSearchAndSortByGenre() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Genre")
    }

    func testSearchAndSortByYear() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Year")
    }
}
