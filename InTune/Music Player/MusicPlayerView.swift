//
//  MusicPlayerView.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import Haneke

protocol MusicPlayerViewing {
    func configure(result: Result)
    func updateButtons()
    func updatePlayerButton()
}

class MusicPlayerView: UIView, MusicPlayerViewing {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var togglePlayButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    var presenter: MusicPlayerPresenting?

    let playIcon = UIImage(named: Constants.Images.playIcon)
    let pauseIcon = UIImage(named: Constants.Images.pauseIcon)
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    override func awakeFromNib() {
        backgroundColor = .clear
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = bounds
        insertSubview(blurView, at: 0)
    }
    
    func configure(result: Result) {
        trackTitleLabel.text = result.trackName
        
        let artworkUrl = result.artworkUrl30
        guard let url = URL(string: artworkUrl) else { return }
        artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.placeholder))
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        presenter.previousAction()
    }
    
    @IBAction func togglePlayButtonAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        presenter.togglePlay()
        updatePlayerButton()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        presenter.nextAction()
    }
    
    func updatePlayerButton() {
        guard let presenter = presenter else { return }
        let image = presenter.isPlaying() ? pauseIcon : playIcon
        togglePlayButton.setImage(image, for: .normal)
    }
    
    func updateButtons() {
        guard let presenter = presenter else { return }
        // Update the next and previous buttons.
        previousButton.isEnabled = (presenter.selectedIndex > 0)
        nextButton.isEnabled = (presenter.selectedIndex < presenter.maxIndex)
        updatePlayerButton()
        
        blurView.frame = bounds
    }
}
