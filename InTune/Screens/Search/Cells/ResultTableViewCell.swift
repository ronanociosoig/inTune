//
//  ResultTableViewCell.swift
//  InTune
//
//  Created by Ronan on 25/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import Haneke

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var trackIdentifier: Int?
    
    func configure(with item: SearchResult) {
        artworkImageView.layer.cornerRadius = 3
        artworkImageView.layer.masksToBounds = true
        artworkImageView.image = UIImage(named: Constants.Images.placeholder)
        artworkImageView.hnk_setImage(from: item.artworkUrl, placeholder: UIImage(named: Constants.Images.placeholder))
        trackNameLabel.text = item.trackName
        artistNameLabel.text = item.artistName
        genreLabel.text = item.genre
        durationLabel.text = item.durationText
        releaseDateLabel.text = item.releaseDate
        priceLabel.text = item.price
        trackIdentifier = item.identifier
    }
}
