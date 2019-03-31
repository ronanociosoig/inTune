//
//  SongDetailPresenterTests.swift
//  InTuneTests
//
//  Created by Ronan on 26/03/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

// swiftlint:disable all

import XCTest

@testable import InTune

class SongDetailPresenterTests: XCTestCase {
    
    let networkService = MockNetworkService()
    var dataProvider: DataProvider!
    let viewController = SongDetailWireframe.makeViewController()
    let appController = AppController()

    override func setUp() {
        dataProvider = DataProvider(service: networkService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresenter() {
        let songDetailActions = appController as SongDetailActions
        
        let songDetailPresenter = SongDetailPresenter(viewController: viewController, actions: songDetailActions, dataProvider: dataProvider)
        
        XCTAssertNotNil(songDetailPresenter)
    }
    
    func testWillLayoutCallsShowResult() {
        let songDetailActions = appController as SongDetailActions
        let mockViewController = MockViewController()
        let presenter = SongDetailPresenter(viewController: mockViewController,
                                                      actions: songDetailActions,
                                                      dataProvider: dataProvider)
        
        networkService.responseType = .simpleResponse
        dataProvider.search(term: "Moby")
        
        guard let result = dataProvider.appData.results.first else {
            XCTFail()
            return
        }

        presenter.selectedResult = result
        
        presenter.willLayoutSubviews()
        
        XCTAssertTrue(mockViewController.showCalled)
        XCTAssertNotNil(mockViewController.result)
        XCTAssertEqual(result.artistID, mockViewController.result!.artistID)
    }
    
}

class MockViewController: SongDetailController {
    var showCalled: Bool = false
    var result: Result?
    
    func show(result: Result) {
        showCalled = true
        self.result = result
    }
}
