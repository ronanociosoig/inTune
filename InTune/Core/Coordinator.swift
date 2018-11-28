//
//  Coordinator.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import JGProgressHUD

class Coordinator {
    let window: UIWindow
    var dataProvider: DataProvider!
    var appController: AppController!
    var hud: JGProgressHUD?
    var presenter: SearchPresenter?
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.tintColor = Constants.Theme.tintColor
    }
    
    func start() {
        showSearch()
    }
    
    func showSearch() {
        let viewController = SearchWireframe.makeViewController()
        
        SearchWireframe.prepare(viewController: viewController,
                                actions: appController as SearchActions,
                                dataProvider: dataProvider as SearchDataProvider)
        
        presenter = viewController.presenter
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
    }
    
    func showSearchResults() {
        presenter?.dataReceived()
    }

    func showSongDetail() {
        let viewController = SongDetailWireframe.makeViewController()
        
        SongDetailWireframe.prepare(viewController: viewController,
                                    actions: appController as SongDetailActions,
                                    dataProvider: dataProvider as SongDetailDataProvider)
        
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        navigationController.pushViewController(viewController, animated: true)
        
        showMusicPlayer()
    }
    
    func showLoading() {
        
        guard let topViewController = window.rootViewController else { return }
        
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = Constants.Translations.loading
        hud?.show(in: topViewController.view)
    }
    
    func showMusicPlayer() {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        guard let musicPlayerView = MusicPlayerView.loadFromNib() else { return }
        
        let height = Constants.MusicPlayer.height
        let viewFrame = navigationController.view.frame
        let insets = navigationController.view.safeAreaInsets
        let frame = CGRect(origin: CGPoint(x: 0, y: viewFrame.size.height - height - insets.bottom), size: CGSize(width: viewFrame.size.width, height: height))
        musicPlayerView.frame = frame
        navigationController.view.addSubview(musicPlayerView)
    }
    
    func hideMusicPlayer() {
        
    }
    
    func dismissLoading() {
        hud?.dismiss(animated: true)
    }
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: Constants.Translations.ok,
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(okButton)
        
        guard let viewController = window.rootViewController else { return }
        
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }
}

extension Coordinator: DataLoaded {
    func dataReceived(errorMessage: String?) {
        DispatchQueue.main.async {
            self.dismissLoading()
            
            if let errorMessage = errorMessage {
                self.showAlert(with: errorMessage)
            } else {
                self.showSearchResults()
            }
        }
    }
}
