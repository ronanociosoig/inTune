//
//  SearchWireframe.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

struct SearchWireframe {
    static func makeViewController() -> SearchViewController {
        // let moduleName = "SearchViewController"
        let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
        return SearchViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    static func prepare(viewController: SearchViewController, actions: SearchActions, dataProvider: SearchDataProvider) {
        let view = viewController as ViewController
        
        let presenter = SearchPresenter(viewController: view,
                                        actions: actions,
                                        dataProvider: dataProvider)
        
        viewController.presenter = presenter
    }
}
