//
//  SearchTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class SearchTests: KIFTestCase {

    override func setUp() {
        
    }
    
    func testSearchAndSortByAlbum() {
        let searchText = "Moby"
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "SearchTextField")
        tester().tapView(withAccessibilityLabel: "Search")
        tester().waitForView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Sort")
        tester().tapView(withAccessibilityLabel: "Album")
    }
    
    

}
