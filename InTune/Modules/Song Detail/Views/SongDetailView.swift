//
//  SongDetailView.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class SongDetailView: UIView {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var viewController: SongDetailViewController!
    var songUrl: URL?
    
    func configure(with result: Result) {
        trackNameLabel.text = result.trackName
        artistNameLabel.text = result.artistName
        
        let dateFormatter = DateFormatter.simpleDateFormatter()
        releaseDateLabel.text = dateFormatter.string(from: result.releaseDate)
        
        artworkImageView.image = UIImage(named: Constants.Images.largePlaceholder)
        
        if let text = result.longDescription {
            descriptionLabel.text = text
        } else if let text = result.shortDescription {
            descriptionLabel.text = text
        } else {
            descriptionLabel.text = ""
        }
        
        if let url = URL(string: result.artworkUrl60) {
            artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.largePlaceholder))
        }
        
        if let trackUrl = URL(string: result.previewURL) {
            songUrl = trackUrl
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if let songUrl = songUrl {
            print("\(songUrl.absoluteString)")
            viewController.play(url: songUrl)
        }
    }
}
