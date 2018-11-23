//
//  Coordinator.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
// import JGProgressHUD

class Coordinator {
    let window: UIWindow
    //var dataProvider: DataProvider!
    // var appController: AppController!
    // let actions: Actions
    
    // var hud: JGProgressHUD?
    
    init() {
        // self.actions = actions
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
    
    func start() {
        showSearch()
    }
    
    func showSearch() {
        let viewController = SearchWireframe.makeViewController()
        window.rootViewController = viewController
    }
    
    func showSongDetail() {
        
    }
}
