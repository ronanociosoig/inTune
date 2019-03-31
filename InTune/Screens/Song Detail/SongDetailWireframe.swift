//
//  SongDetailWireframe.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

struct SongDetailWireframe {
    static func makeViewController() -> SongDetailViewController {
        let moduleName = "SongDetail"
        let storyboard = UIStoryboard.init(name: moduleName, bundle: nil)
        
        return SongDetailViewController.instantiateFromStoryboard(storyboard: storyboard)
    }
    
    static func prepare(viewController: SongDetailViewController,
                        actions: SongDetailActions,
                        dataProvider: SongDetailDataProvider) {
        let presenter = SongDetailPresenter(viewController: viewController as SongDetailController,
                                        actions: actions,
                                        dataProvider: dataProvider)

        viewController.presenter = presenter
    }
}
