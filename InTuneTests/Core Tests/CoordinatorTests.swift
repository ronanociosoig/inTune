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
        
    }

    func testStartMakesViewController() {
        let appController = AppController()
        let coordinator = Coordinator(appController: appController)
        
        coordinator.dataProvider = appController.dataProvider
        XCTAssertNotNil(coordinator.window)
        
        coordinator.start()
        XCTAssertNotNil(coordinator.window.rootViewController)
    }
    
    func testShowSearch() {
        let appController = AppController()
        let coordinator = Coordinator(appController: appController)
        
        coordinator.window.rootViewController = UIViewController()
        coordinator.showLoading()
        
        XCTAssertNotNil(coordinator.hud)
    }
}
