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
}

class MediaPlayer {
    var playing: Bool = false
    
    var playList = [AVPlayerItem]()
    var currentIndex: Int = 0
    
    var delegate: MediaPlayerDelegate!
    
    fileprivate var playerQueue: AVQueuePlayer?
    fileprivate var timeObserverToken: Any?
    fileprivate static let trackEndTime: Double = 29.90
    
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let category = AVAudioSession.Category.playback
            try audioSession.setCategory(category, mode: .default, options: .mixWithOthers)
            try audioSession.setActive(true)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        playerQueue = AVQueuePlayer(items: playList)
    }
 
    fileprivate func removePeriodicTimeObserver() {
        // If a time observer exists, remove it
        if let token = timeObserverToken {
            playerQueue?.removeTimeObserver(token)
            timeObserverToken = nil
        }
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
                
                if let currentTime = self?.playerQueue?.currentTime(), currentTime.seconds > MediaPlayer.trackEndTime {
                    // we are ending the track.
                    // send a notification to the player.
                    
                    os_log("Track end.", log: Log.player, type: .info)
                    self?.next()
                    self?.delegate.update()
                }
        }
    }
    
    func next() {
        playerQueue?.advanceToNextItem()
    }
    
    func previous() {
        // TODO: remove all items, and add all items from the previous index.
    }
    
    func togglePlay() {
        
        if playing == true {
            playing = false
            playerQueue?.pause()
            removePeriodicTimeObserver()
            return
        }
        
        playerQueue?.play()
        playing = true
        
        playerQueue?.actionAtItemEnd = .advance
        
        addPeriodicTimeObserver()
    }
    
    func addPlayList(list: [URL]) {
        if playing == true {
            playing = false
            playerQueue?.pause()
        }
        playerQueue?.removeAllItems()
        
        for url in list {
            let avAsset = AVURLAsset(url: url)
            avAsset.loadValuesAsynchronously(forKeys: ["playable", "tracks", "duration"], completionHandler: {
                DispatchQueue.main.async {
                    let item = AVPlayerItem(asset: avAsset)
                    self.playList.append(item)
                    self.playerQueue?.insert(item, after: nil)
                }
            })
        }
    }
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        
        if playerQueue == nil {
            playerQueue = AVQueuePlayer(playerItem: playerItem)
        } else {
            
            if playing == true {
                playerQueue?.pause()
            }
            
            playerQueue?.replaceCurrentItem(with: playerItem)
        }
        
        playerQueue?.play()
        playing = true
        
        playerQueue?.actionAtItemEnd = .advance
        
        addPeriodicTimeObserver()
    }
}
