//
//  MediaPlayer.swift
//  InTune
//
//  Created by Ronan on 27/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import AVFoundation

class MediaPlayer {
    // var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    var timeObserverToken: Any?
    var playing: Bool = false
    
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
    }
    
 
    func removePeriodicTimeObserver() {
        // If a time observer exists, remove it
        if let token = timeObserverToken {
            playerQueue?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }

    func addPeriodicTimeObserver() {
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

                let currentTime = self?.playerQueue?.currentTime()
                
                print("Current time: \(String(describing: currentTime?.seconds))")
        }
    }
    
    func play(list: [URL]) {
        var playList = [AVPlayerItem]()
        for url in list {
            let playerItem = AVPlayerItem(url: url)
            playList.append(playerItem)
        }
        
        if playerQueue != nil {
            playerQueue?.removeAllItems()
            playerQueue = nil
        }
        
        playerQueue = AVQueuePlayer(items: playList)
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
        
       // playerQueue?.insert(<#T##item: AVPlayerItem##AVPlayerItem#>, after: <#T##AVPlayerItem?#>)
        
        addPeriodicTimeObserver()
    }
}
