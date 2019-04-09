//
//  SortAlertController.swift
//  InTune
//
//  Created by Ronan on 02/04/2019.
//  Copyright © 2019 Sonomos. All rights reserved.
//

import UIKit
import RxSwift

struct SortAlertBuilder {
    static func makeSortAlertController(sortSubject: PublishSubject<SortOption>) -> UIAlertController {
        let alertController = UIAlertController(title: Constants.Translations.sortOptions,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(lengthAlertAction(sortSubject: sortSubject))
        alertController.addAction(genreAlertAction(sortSubject: sortSubject))
        alertController.addAction(priceAlertAction(sortSubject: sortSubject))
        alertController.addAction(artistNameAction(sortSubject: sortSubject))
        alertController.addAction(yearAction(sortSubject: sortSubject))
        alertController.addAction(albumAlertAction(sortSubject: sortSubject))
        alertController.addAction(cancelAction())
        
        return alertController
    }
    
    static func lengthAlertAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.length,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.length)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.length
        return action
    }
    
    static func albumAlertAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.album,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.album)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.album
        return action
    }
    
    static func genreAlertAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.genre,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.genre)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.genre
        return action
    }
    
    static func priceAlertAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.price,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.price)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.price
        return action
    }
    
    static func artistNameAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.artist,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.artist)
        }
        action.accessibilityLabel = Constants.Accessibility.SearchScreen.SortOptions.artist
        return action
    }
    
    static func yearAction(sortSubject: PublishSubject<SortOption>) -> UIAlertAction {
        let action = UIAlertAction(title: Constants.Translations.SortOptions.year,
                                   style: .default) { (_) in
                                    sortSubject.onNext(.year)
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
