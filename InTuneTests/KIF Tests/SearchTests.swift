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
    
    func testSearchTableView() {
        let searchText = "Moby"
        tester().enterText(searchText, intoViewWithAccessibilityLabel: "Search")
        tester().tapView(withAccessibilityLabel: "Search")
    }

}
