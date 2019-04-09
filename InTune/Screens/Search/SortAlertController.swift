//
//  SortAlertController.swift
//  InTune
//
//  Created by Ronan on 02/04/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit

struct SortAlertBuilder {
    static func makeSortAlertController(presenter: SearchPresenting) -> UIAlertController {
        let alertController = UIAlertController(title: Constants.Translations.sortOptions,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(lengthAlertAction(presenter: presenter))
        alertController.addAction(genreAlertAction(presenter: presenter))
        alertController.addAction(priceAlertAction(presenter: presenter))
        alertController.addAction(artistNameAction(presenter: presenter))
        alertController.addAction(yearAction(presenter: presenter))
        alertController.addAction(albumAlertAction(presenter: presenter))
        alertController.addAction(cancelAction())
        
        return alertController
    }
    
    static func lengthAlertAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.length,
                                   style: .default) { (_) in
                                    presenter.selected(option: .length)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.length
        return action
    }
    
    static func albumAlertAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.album,
                                   style: .default) { (_) in
                                    presenter.selected(option: .album)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.album
        return action
    }
    
    static func genreAlertAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.genre,
                                   style: .default) { (_) in
                                    presenter.selected(option: .genre)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.genre
        return action
    }
    
    static func priceAlertAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.price,
                                   style: .default) { (_) in
                                    presenter.selected(option: .price)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.price
        return action
    }
    
    static func artistNameAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.artist,
                                   style: .default) { (_) in
                                    presenter.selected(option: .artist)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.artist
        return action
    }
    
    static func yearAction(presenter: SearchPresenting) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.year,
                                   style: .default) { (_) in
                                    presenter.selected(option: .year)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.year
        return action
    }
    
    static func cancelAction() -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.cancel,
                                   style: .cancel,
                                   handler: nil)
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.cancel
        return action
    }
}
