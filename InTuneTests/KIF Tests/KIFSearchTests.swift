//
//  SearchTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class KIFSearchTests: KIFTestCase {
    
    let searchText = "Primal Scream"

    override func setUp() {
        
    }
    
    func testEnterTextAndCancel() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.cancelButton)
    }
    
    func testSearchAndSortCancel() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.cancel)
    }
    
    func testSearchAndSortByAlbum() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.album)
    }
    
    func testSearchAndSortByLength() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.length)
    }
    
    func testSearchAndSortByPrice() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.price)
    }
    
    func testSearchAndSortByArtist() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.artist)
    }
    
    func testSearchAndSortByGenre() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.genre)
    }

    func testSearchAndSortByYear() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.SortOptions.year)
    }
    
    func testSearchAndScroll() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().accessibilityScroll(.up)
        tester().waitForAnimationsToFinish()
    }
}
