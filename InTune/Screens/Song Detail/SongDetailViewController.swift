//
//  SongDetailViewController.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

protocol SongDetailController: class {
    func show(result: Result)
}

class SongDetailViewController: UIViewController {
    
    var presenter: SongDetailPresenting?
    var songDetailView: SongDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let songDetailView: SongDetailView = SongDetailView.loadFromNib() else {
            os_log("Error loading the nib. ", log: Log.general, type: .error)
            return
        }
        
        songDetailView.frame = view.bounds
        view.addSubview(songDetailView)
        
        self.songDetailView = songDetailView
    }
    
    override func viewWillLayoutSubviews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share(sender:)))
        
        navigationItem.rightBarButtonItem?.accessibilityLabel = Constants.Accessibility.SongDetailScreen.shareButton
        
        guard let presenter = presenter else { return }
        
        presenter.willLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func share(sender: Any) {
        
        guard let songDetailView = songDetailView else { return }
        
        let image = UIImage(named: Constants.Images.largePlaceholder)
        
        // swiftlint:disable force_unwrapping
        
        let activity = UIActivityViewController(activityItems: [
            songDetailView.trackNameLabel.text ?? "Unknown",
            songDetailView.artistNameLabel.text ?? "Unknown",
            songDetailView.artworkImageView.image ?? image!,
            songDetailView.trackViewURL ?? ""
            ], applicationActivities: nil)
        
        // swiftlint:enable force_unwrapping
        
        // Anything you want to exclude
        activity.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo
        ]
        
        self.present(activity, animated: true, completion: nil)
    }
}

extension SongDetailViewController: SongDetailController {
    func show(result: Result) {
        
        if let songDetailView = songDetailView {
            songDetailView.configure(with: result)
            songDetailView.frame = view.bounds
        }
    }
}
