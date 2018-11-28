//
//  MusicPlayerView.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit

class MusicPlayerView: UIView {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var togglePlayButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBAction func previousButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func togglePlayButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        artworkImageView.layer.borderWidth = 0.5
        artworkImageView.layer.borderColor = UIColor.black.cgColor
    }
}
