//
//  SongDetailViewController.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

protocol SongDetailController {
    
}

class SongDetailViewController: UIViewController {
    
    var presenter: SongDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension SongDetailViewController: SongDetailController {
    
}
