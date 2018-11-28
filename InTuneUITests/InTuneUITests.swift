//
//  InTuneUITests.swift
//  InTuneUITests
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

class InTuneUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        print(XCUIApplication().debugDescription)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchForArtist() {
        let mKey = app/*@START_MENU_TOKEN@*/.keys["M"]/*[[".keyboards.keys[\"M\"]",".keys[\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Moby"].buttons["Sort"].tap()
        app.sheets.buttons["Genre"].tap()
    }
    
    func testShareResult() {
        let mKey = app/*@START_MENU_TOKEN@*/.keys["M"]/*[[".keyboards.keys[\"M\"]",".keys[\"M\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables["ResultsTable"]/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Let's Go Free")/*[[".cells.containing(.staticText, identifier:\"00:38\")",".cells.containing(.staticText, identifier:\"Let's Go Free\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Moby"].tap()
    }
    
    func testPlayResult() {
        let mKey = app.keys["M"]
        mKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let yKey = app/*@START_MENU_TOKEN@*/.keys["y"]/*[[".keyboards.keys[\"y\"]",".keys[\"y\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        yKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables["ResultsTable"]/*@START_MENU_TOKEN@*/.staticTexts["Down Slow"]/*[[".cells.matching(identifier: \"SearchResultCell\").staticTexts[\"Down Slow\"]",".staticTexts[\"Down Slow\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let playButton = app.buttons["Play"]
        playButton.tap()
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        app.navigationBars["Results"].buttons["Results"].tap()
        
    }
    
    //  NavigationBar 'InTune.SearchView'
    
    // Button, 0x600002ac4dd0, {{326.3, -44.0}, {40.7, 44.0}}, label: 'Sort', Disabled

}
