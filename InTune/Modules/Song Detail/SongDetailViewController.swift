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
    var songDetailView: SongDetailView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        presenter.willLayoutSubviews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share(sender:)))
        
        navigationItem.rightBarButtonItem?.accessibilityLabel = "Share"
        
        // UIBarButtonItem(title: "Share", style: .plain, target: self, action: )
    }
    
    @objc func share(sender: Any) {
        
        guard let songDetailView = songDetailView else { return }
        
        let image = UIImage(named: Constants.Images.largePlaceholder)
        
        let activity = UIActivityViewController(activityItems: [
            songDetailView.trackNameLabel.text ?? "Unknown",
            songDetailView.artistNameLabel.text ?? "Unknown",
            songDetailView.artworkImageView.image ?? image!], applicationActivities: nil)
        
        // Anything you want to exclude
        activity.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
        ]
        
        self.present(activity, animated: true, completion: nil)
    }
}

extension SongDetailViewController: SongDetailController {
    func show(result: Result) {
        guard let songDetailView: SongDetailView = SongDetailView.loadFromNib() else { return }
        songDetailView.configure(with: result)
        songDetailView.frame = view.bounds
        view.addSubview(songDetailView)
        
        self.songDetailView = songDetailView
    }
}
