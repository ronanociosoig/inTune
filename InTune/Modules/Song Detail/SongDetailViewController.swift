//
//  SongDetailViewController.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

protocol SongDetailController {
    func show(result: Result)
}

class SongDetailViewController: UIViewController {
    
    var presenter: SongDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        presenter.willLayoutSubviews()
    }
}

extension SongDetailViewController: SongDetailController {
    func show(result: Result) {
        guard let songDetailView: SongDetailView = SongDetailView.loadFromNib() else { return }
        songDetailView.configure(with: result)
        songDetailView.frame = view.bounds
        view.addSubview(songDetailView)
    }
}
