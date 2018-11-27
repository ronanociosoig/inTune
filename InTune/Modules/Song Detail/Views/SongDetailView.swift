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
    
    func configure(with result: Result) {
        trackNameLabel.text = result.trackName
        artistNameLabel.text = result.artistName
        
        let dateFormatter = DateFormatter.simpleDateFormatter()
        releaseDateLabel.text = dateFormatter.string(from: result.releaseDate)
        
        artworkImageView.image = UIImage(named: Constants.Images.largePlaceholder)
        
        guard let url = URL(string: result.artworkUrl60) else { return }
        artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.largePlaceholder))
    }
}
