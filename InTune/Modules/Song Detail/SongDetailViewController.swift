//
//  SongDetailViewController.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import AVFoundation

protocol SongDetailController {
    func show(result: Result)
}

class SongDetailViewController: UIViewController {
    
    var presenter: SongDetailPresenter!
    var songDetailView: SongDetailView?
    
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let songDetailView: SongDetailView = SongDetailView.loadFromNib() else {
            print("Error loading the nib. ")
            return
        }
        
        songDetailView.frame = view.bounds
        view.addSubview(songDetailView)
        
        songDetailView.viewController = self
        
        self.songDetailView = songDetailView
    }
    
    override func viewWillLayoutSubviews() {
        presenter.willLayoutSubviews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(share(sender:)))
        
        navigationItem.rightBarButtonItem?.accessibilityLabel = "Share"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    func play(url: URL) {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                let category = AVAudioSession.Category.playback
                try audioSession.setCategory(category, mode: .default, options: .mixWithOthers)
                try audioSession.setActive(true)
            }
            catch {
                print("Setting category to AVAudioSessionCategoryPlayback failed.")
            }
            
            let playerItem = AVPlayerItem(url: url)
            
            player = AVPlayer(playerItem: playerItem)
            player?.play()
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
