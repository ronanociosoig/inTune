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
    
    var mediaPlayer: MediaPlayer!
    
    var selectedIndex: Int = 0
    var maxIndex: Int = 0
    
    let playIcon = UIImage(named: Constants.Images.playIcon)
    let pauseIcon = UIImage(named: Constants.Images.pauseIcon)
    
    func configure(result: Result) {
        trackTitleLabel.text = result.trackName
        
        let artworkUrl = result.artworkUrl30
        guard let url = URL(string: artworkUrl) else { return }
        artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.placeholder))
    }
    
    func updateButtons() {
        // Update the next and previous buttons.
        previousButton.isEnabled = (selectedIndex > 0)
        nextButton.isEnabled = (selectedIndex < maxIndex)
        updatePlayerButton()
    }
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        mediaPlayer.previous()
    }
    
    @IBAction func togglePlayButtonAction(_ sender: Any) {
        mediaPlayer.togglePlay()
        updatePlayerButton()
    }
    
    func updatePlayerButton() {
        let image = mediaPlayer.playing ? pauseIcon : playIcon
        togglePlayButton.setImage(image, for: .normal)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        mediaPlayer.next()
    }
}
