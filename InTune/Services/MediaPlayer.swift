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
    var player: AVPlayer?
    var timeObserverToken: Any?
    
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
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }

    func addPeriodicTimeObserver() {
        // Invoke callback every half second
        let interval = CMTime(seconds: 0.5,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        // Queue on which to invoke the callback
        let mainQueue = DispatchQueue.main
        // Add time observer
        timeObserverToken =
            player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) {
                [weak self] time in
                // update player transport UI

                let currentTime = self?.player?.currentTime()
                print("Current time: \(String(describing: currentTime))")
        }
    }
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        
        if player == nil {
            player = AVPlayer(playerItem: playerItem)
        } else {
            player?.replaceCurrentItem(with: playerItem)
        }
        
        player?.play()
    }
}
