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
        let moduleName = "SearchViewController"
        let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: moduleName) as! SearchViewController
    }
    
    static func prepare(viewController: SearchViewController, action: SearchAction, dataProvider: SearchDataProvider) {
        let view = viewController as ViewController
        let dataSource = SearchDataSource()
        let presenter = SearchPresenter(viewController: view,
                                        action: action,
                                        dataProvider: dataProvider,
                                        dataSource: dataSource)
        
        viewController.presenter = presenter
        dataSource.presenter = presenter
        
    }
}
