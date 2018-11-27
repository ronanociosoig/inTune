//
//  SongDetailWireframeTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SongDetailWireframeTests: XCTestCase {
    func testWireframeConnections() {
        let viewController = SongDetailWireframe.makeViewController()
        let appController = AppController()
        let searchDataProvider = appController.dataProvider as SongDetailDataProvider
        let actions = appController as SongDetailActions
        
        SongDetailWireframe.prepare(viewController: viewController,
                                actions: actions,
                                dataProvider: searchDataProvider)
        
        let presenter = viewController.presenter
        
        XCTAssertNotNil(presenter)
    }
}
