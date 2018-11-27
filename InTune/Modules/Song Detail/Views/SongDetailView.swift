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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var songPlayer: SongPlayer!
    
    func configure(with result: Result) {
        trackNameLabel.text = result.trackName
        artistNameLabel.text = result.artistName
        artistNameLabel.textColor = Constants.Theme.tintColor
        
        let dateFormatter = DateFormatter.simpleDateFormatter()
        releaseDateLabel.text = result.primaryGenreName + " • " + dateFormatter.string(from: result.releaseDate)
        
        let priceFormatter = NumberFormatter.priceFormatter()
        priceLabel.text = priceFormatter.string(from: result.trackPrice as NSNumber)
        
        artworkImageView.image = UIImage(named: Constants.Images.largePlaceholder)
        
        collectionNameLabel.text = result.collectionName
        
        if let text = result.longDescription {
            descriptionLabel.text = text
        } else if let text = result.shortDescription {
            descriptionLabel.text = text
        } else {
            descriptionLabel.text = ""
        }
        
        if let url = URL(string: result.artworkUrl100) {
            artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.largePlaceholder))
        }
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        songPlayer.togglePlay()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        songPlayer.next()
    }
}
