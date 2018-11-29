//
//  MediaPlayer.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import AVFoundation
import os.log

protocol MediaPlayerDelegate {
    func update()
    func startedPlaying()
}

class MediaPlayer {
    var playing: Bool = false
    var playList = [AVPlayerItem]()
    var currentIndex: Int = 0
    var delegate: MediaPlayerDelegate!
    var cachingData = false
    
    fileprivate var playerQueue: AVQueuePlayer?
    fileprivate var timeObserverToken: Any?
    
    // this is for the iTunes previews
    fileprivate static let trackEndTime: Double = 29.90
    
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let category = AVAudioSession.Category.playback
            try audioSession.setCategory(category, mode: .default, options: .mixWithOthers)
            try audioSession.setActive(true)
        }
        catch {
            os_log("Setting category to AVAudioSessionCategoryPlayback failed.", log: Log.player, type: .error)
        }
        
        playerQueue = AVQueuePlayer(items: playList)
    }
    
    // MARK: Public functions

    func addPlayList(list: [URL]) {
        self.playList.removeAll()
        
        for url in list {
            let item = AVPlayerItem(url: url)
            self.playList.append(item)
        }
    }
    
    func togglePlay() {
        
        if playing == true {
            playing = false
            playerQueue?.pause()
            removePeriodicTimeObserver()
            return
        }
        
        playFromCurrentIndex()
        
        //        playerQueue?.play()
        //        playing = true
        //
        //        playerQueue?.actionAtItemEnd = .advance
        //        addPeriodicTimeObserver()
    }
    
    func next() {
        playerQueue?.advanceToNextItem()
        currentIndex += 1
    }
    
    func previous() {
        if currentIndex > 0 {
            playFromCurrentIndex()
        }
    }
    
    // MARK: Private functions

    fileprivate func resetPlayerQueue() {
        if playing == true {
            playing = false
            playerQueue?.pause()
        }
        playerQueue?.removeAllItems()
        removePeriodicTimeObserver()
    }
    
    fileprivate func playFromCurrentIndex() {
        resetPlayerQueue()
        
        for index in currentIndex..<playList.count {
            let item = playList[index]
            self.playerQueue?.insert(item, after: nil)
        }
        
        playerQueue?.play()
        playing = true
        playerQueue?.actionAtItemEnd = .advance
        addPeriodicTimeObserver()
    }
    
    fileprivate func addPeriodicTimeObserver() {
        // Invoke callback every half second
        let interval = CMTime(seconds: 1.0,
                              preferredTimescale: CMTimeScale(NSEC_PER_MSEC))
        // Queue on which to invoke the callback
        let mainQueue = DispatchQueue.main
        // Add time observer
        timeObserverToken =
            playerQueue?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) {
                [weak self] time in
                // update player transport UI
                if let currentTime = self?.playerQueue?.currentTime() {
                    if self?.cachingData == true {
                        self?.cachingData = false
                        self?.delegate.startedPlaying()
                    }
                    
                    if currentTime.seconds > MediaPlayer.trackEndTime {
                        // we are ending the track.
                        // send a notification to the player.
                        
                        os_log("Track end.", log: Log.player, type: .info)
                        self?.next()
                        self?.delegate.update()
                    }
                }
        }
    }
    
    fileprivate func removePeriodicTimeObserver() {
        // If a time observer exists, remove it
        if let token = timeObserverToken {
            playerQueue?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    

    //    func play(from index: Int) {
    //        currentIndex = index
    //        playFromCurrentIndex()
    //    }
    
//    func play(url: URL) {
//        let playerItem = AVPlayerItem(url: url)
//
//        if playerQueue == nil {
//            playerQueue = AVQueuePlayer(playerItem: playerItem)
//        } else {
//
//            if playing == true {
//                playerQueue?.pause()
//            }
//
//            playerQueue?.replaceCurrentItem(with: playerItem)
//        }
//
//        playerQueue?.play()
//        playing = true
//        playerQueue?.actionAtItemEnd = .advance
//        addPeriodicTimeObserver()
//    }
}
