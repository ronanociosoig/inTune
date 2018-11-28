//
//  MusicPlayerView.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class MusicPlayerView: UIView {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var togglePlayButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    let mediaPlayer = MediaPlayer()
    
    func configure(result: Result) {
        trackTitleLabel.text = result.trackName
        
        let artworkUrl = result.artworkUrl30
        guard let url = URL(string: artworkUrl) else { return }
        artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.placeholder))
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func togglePlayButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
    }
}
