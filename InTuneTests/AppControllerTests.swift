//
//  AppControllerTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class AppControllerTests: XCTestCase {
    
    let appController = AppController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasDataProvider() {
        XCTAssertNotNil(appController)
        XCTAssertNotNil(appController.dataProvider)
    }
    
    func testHasCoordinator() {
        appController.start()
        XCTAssertNotNil(appController.coordinator)
    }
}
