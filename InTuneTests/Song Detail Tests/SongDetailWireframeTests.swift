//
//  SongDetailWireframeTests.swift
//  InTuneTests
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import XCTest
import UIKit

@testable import InTune

class SongDetailWireframeTests: XCTestCase {
    let networkService = MockNetworkService()
    
    func testWireframeConnections() {
        let viewController = SongDetailWireframe.makeViewController()
        let appController = AppController()
        let dataProvider = DataProvider(service: networkService)
        let songDetailDataProvider = dataProvider as SongDetailDataProvider
        let actions = appController as SongDetailActions
        
        networkService.responseType = .simpleResponse
        dataProvider.search(term: "Queen")
        
        SongDetailWireframe.prepare(viewController: viewController,
                                actions: actions,
                                dataProvider: songDetailDataProvider)
        
        let presenter = viewController.presenter
        
        XCTAssertNotNil(presenter)
        
        viewController.viewDidLoad()
        viewController.viewWillLayoutSubviews()
        viewController.viewDidAppear(true)
        
        guard let result = dataProvider.appData.results.first else {
            XCTFail()
            return
        }
        
        viewController.show(result: result)
        
        let button = UIButton(type: .system)
        
        viewController.share(sender: button)
    }
}
