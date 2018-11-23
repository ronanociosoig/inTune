//
//  SearchWireframe.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

struct SearchWireframe {
    static func makeViewController() -> ViewController {
        let moduleName = "ViewController"
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: moduleName) as! ViewController
    }
    
    static func prepare(viewController: ViewController) {
        
    }
}
