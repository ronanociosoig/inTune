//
//  SongDetailPresenterTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import XCTest

@testable import InTune

class SongDetailPresenterTests: XCTestCase {
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresenter() {
        let viewController = SongDetailWireframe.makeViewController()
        let dataProvider = DataProvider(service: networkService)
        let appController = AppController()
        
        let songDetailActions = appController as SongDetailActions
        
        let songDetailPresenter = SongDetailPresenter(viewController: viewController, actions: songDetailActions, dataProvider: dataProvider)
        
        XCTAssertNotNil(songDetailPresenter)
    }
    
}
