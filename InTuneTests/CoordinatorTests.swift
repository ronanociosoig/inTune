//
//  CoordinatorTests.swift
//  InTuneTests
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest
import UIKit

@testable import InTune

class CoordinatorTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStartMakesViewController() {
        let coordinator = Coordinator()
        let appController = AppController()
        coordinator.appController = appController
        coordinator.dataProvider = appController.dataProvider
        XCTAssertNotNil(coordinator.window)
        
        coordinator.start()
        XCTAssertNotNil(coordinator.window.rootViewController)
        XCTAssertNotNil(coordinator.currentViewController)
    }
    
    
}
