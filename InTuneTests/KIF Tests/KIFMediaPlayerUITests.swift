//
//  MediaPlayerTests.swift
//  InTuneTests
//
//  Created by Ronan on 28/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

class KIFMediaPlayerUITests: KIFTestCase {
    
    let searchText = "Primal Scream"
    
    override func setUp() {
        
    }
    
    func testSearchAndPlayInDetail() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
    }
    
    func testSearchAndPlayNextInDetail() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.nextButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
    }
    
    func testSearchAndPlayAndBack() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
        tester().tapView(withAccessibilityLabel: "Results")
    }
    
    func testSearchAndPlayAndBackAndPlay() {
        tester().enterText(searchText, intoViewWithAccessibilityLabel: Constants.Accessibility.SearchScreen.SearchBar.searchTextField)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.searchButton)
        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.sortButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.SearchScreen.cell)
        tester().waitForAnimationsToFinish()
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
        tester().tapView(withAccessibilityLabel: "Results")
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.playButton)
        tester().tapView(withAccessibilityLabel: Constants.Accessibility.MediaPlayer.nextButton)
    }
}
