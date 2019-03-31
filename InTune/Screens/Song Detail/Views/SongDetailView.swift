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
    
    @IBOutlet weak var openInSafariButton: UIButton!
    
    var trackViewURL: String!
    
    func dateAndGenre(result: Result) -> String {
        let dateFormatter = DateFormatter.simpleDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return result.primaryGenreName + " • " + dateFormatter.string(from: result.releaseDate)
    }
    
    func configure(with result: Result) {
        trackNameLabel.text = result.trackName
        artistNameLabel.text = result.artistName
        artistNameLabel.textColor = UIColor(named: Constants.Theme.tintColor)
        releaseDateLabel.text = dateAndGenre(result: result)
        
        if let price = result.trackPrice, price > 0 {
            let priceFormatter = NumberFormatter.priceFormatter()
            priceLabel.text = priceFormatter.string(from: price as NSNumber)
        } else {
            priceLabel.text = Constants.Translations.notAvailable
        }
        
        artworkImageView.layer.cornerRadius = 5
        artworkImageView.layer.masksToBounds = true
        artworkImageView.image = UIImage(named: Constants.Images.largePlaceholder)
        
        collectionNameLabel.text = result.collectionName
        
        trackViewURL = result.trackViewURL
        
        if let url = URL(string: result.artworkUrl100) {
            artworkImageView.hnk_setImage(from: url, placeholder: UIImage(named: Constants.Images.largePlaceholder))
        }
        
        openInSafariButton.setTitle(Constants.Translations.openIniTunes, for: .normal)
        openInSafariButton.accessibilityLabel = Constants.Translations.openIniTunes
        openInSafariButton.isAccessibilityElement = true
    }
    
    @IBAction func openInSafariButtonAction(_ sender: Any) {
        if let trackViewURL = trackViewURL, let url = URL(string: trackViewURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
