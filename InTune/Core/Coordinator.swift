//
//  Coordinator.swift
//  InTune
//
//  Created by Ronan on 23/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol ActivityView {
    func showLoading()
    func dismissLoading()
}

protocol Coordinating {
    var musicPlayerView: MusicPlayerView? { get set }
    var musicPlayerPresenter: MusicPlayerPresenter? { get set }
    var dataProvider: DataProvider? { get set }
    
    func start()
    
    func showLoading()
    func dismissLoading()
    
    func showSearch()
    func showSearchResults()
    func showSongDetail()
    func showMusicPlayer()
}

class Coordinator: ActivityView, Coordinating {
    let window: UIWindow
    var dataProvider: DataProvider?
    var appController: AppController
    var hud: JGProgressHUD?
    var presenter: SearchPresenting?
    var musicPlayerView: MusicPlayerView?
    var musicPlayerPresenter: MusicPlayerPresenter?
    
    init(appController: AppController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.tintColor = UIColor(named: Constants.Theme.tintColor)
        self.appController = appController
    }
    
    func start() {
        showSearch()
    }
    
    func showLoading() {
        showHud(with: Constants.Translations.loading)
    }
    
    private func showHud(with message: String) {
        
        guard let topViewController = window.rootViewController else { return }
        
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = message
        hud?.show(in: topViewController.view)
    }
    
    func dismissLoading() {
        hud?.dismiss(animated: true)
        hud = nil
    }
    
    func showSearch() {
        guard let dataProvider = dataProvider else { return }
        let viewController = SearchWireframe.makeViewController()
        
        SearchWireframe.prepare(viewController: viewController,
                                actions: appController as SearchActions,
                                dataProvider: dataProvider as SearchDataProvider)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        
        presenter = viewController.presenter
    }
    
    func showSearchResults() {
        presenter?.dataReceived()
    }

    func showSongDetail() {
        guard let dataProvider = dataProvider else { return }
        let viewController = SongDetailWireframe.makeViewController()
        
        SongDetailWireframe.prepare(viewController: viewController,
                                    actions: appController as SongDetailActions,
                                    dataProvider: dataProvider as SongDetailDataProvider)
        
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMusicPlayer() {
        guard let dataProvider = dataProvider else { return }
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        
        if let musicPlayerView = musicPlayerView {
            navigationController.view.addSubview(musicPlayerView)
            return
        }
        
        guard let musicPlayer = MusicPlayerView.loadFromNib() else { return }
        
        let height = Constants.MusicPlayer.height
        let viewFrame = navigationController.view.frame
        let insets = navigationController.view.safeAreaInsets
        let frame = CGRect(origin: CGPoint(x: 0, y: viewFrame.size.height - height - insets.bottom), size: CGSize(width: viewFrame.size.width, height: height))
        musicPlayer.frame = frame
        navigationController.view.addSubview(musicPlayer)
        
        musicPlayerPresenter =
            MusicPlayerPresenter(mediaPlayer: appController.mediaPlayer,
                                  musicPlayerView: musicPlayer,
                                  dataProvider: dataProvider)
        musicPlayer.presenter = musicPlayerPresenter
        musicPlayerView = musicPlayer
        appController.musicPlayerPresenter = musicPlayerPresenter
        musicPlayerPresenter?.activityView = self
    }
    
    func hideMusicPlayer() {
        if let musicPlayerView = musicPlayerView {
            musicPlayerView.removeFromSuperview()
        }
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

extension Coordinator: MediaPlayerDelegate {
    func preroll() {
        showLoading()
    }
    
    func update() {
        musicPlayerPresenter?.nextItem()
    }
    
    func startedPlaying() {
        dismissLoading()
    }
    
    
}
