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
    func preroll()
    func startedPlaying()
}

protocol MediaPlaying {
    var playing: Bool { get set }
    var currentIndex: Int { get set }
    
    func addPlayList(list: [URL])
    func togglePlay()
    func next()
    func previous()
}

class MediaPlayer: MediaPlaying {
    var playing: Bool = false
    var playList = [AVPlayerItem]()
    var currentIndex: Int = 0
    var delegate: MediaPlayerDelegate!
    var logEnable = false
    
    fileprivate var cachingData = false
    fileprivate var playerQueue: AVQueuePlayer?
    fileprivate var timeObserverToken: Any?
    
    // this is for the iTunes previews
    fileprivate static let iTunesPreviewDuration: Double = 29.95
    
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
        playerQueue?.actionAtItemEnd = .advance
    }
    
    // MARK: Public functions

    func addPlayList(list: [URL]) {
        self.playList.removeAll()
        
        for url in list {
            let item = AVPlayerItem(url: url)
            self.playList.append(item)
        }
        
        os_log("AddPlayList, count: %d", log: Log.player, type: .info, list.count)
        
        cachingData = true
    }
    
    func togglePlay() {
        os_log("TogglePlay", log: Log.player, type: .info)
        if playing == true {
            playing = false
            playerQueue?.pause()
            removePeriodicTimeObserver()
            return
        }
        
        playFromCurrentIndex()
        
        if cachingData == true {
            delegate.preroll()
        }
    }
    
    func next() {
        os_log("Next", log: Log.player, type: .info)
        if playing == true {
            playerQueue?.pause()
        }
        
        resetCurrentPlayerItem()
        playerQueue?.advanceToNextItem()
        currentIndex += 1
        playerQueue?.play()
        playing = true
    }
    
    func previous() {
        os_log("Previous", log: Log.player, type: .info)
        
        if playing == true {
            playerQueue?.pause()
        }
        if currentIndex > 0 {
            currentIndex -= 1
            playFromCurrentIndex()
        }
    }
    
    // MARK: Private functions

    fileprivate func resetPlayerQueue() {
        os_log("ResetPlayerQueue", log: Log.player, type: .info)
        if playing == true {
            playing = false
            playerQueue?.pause()
        }
        playerQueue?.removeAllItems()
        removePeriodicTimeObserver()
    }
    
    fileprivate func playFromCurrentIndex() {
        os_log("PlayFromCurrentIndex: %d", log: Log.player, type: .info, currentIndex)
        resetPlayerQueue()
        
        for index in currentIndex..<playList.count {
            let item = playList[index]
            self.playerQueue?.insert(item, after: nil)
        }
        
        resetCurrentPlayerItem()
        playerQueue?.play()
        
        playing = true
        addPeriodicTimeObserver()
        
        guard let duration = playerQueue?.currentItem?.duration.seconds else { return }
        
        if duration == Double.nan {
            os_log("Unknown track duration", log: Log.player, type: .info)
        } else {
            os_log("Starting track with duration: %f", log: Log.player, type: .info, duration)
        }
    }
    
    fileprivate func resetCurrentPlayerItem() {
        playerQueue?.currentItem?.seek(to: CMTime.zero, completionHandler: nil)
    }
    
    fileprivate func addPeriodicTimeObserver() {
        os_log("AddPeriodicTimeObserver", log: Log.player, type: .info)
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
                        os_log("Caching done", log: Log.player, type: .info)
                    }
                    
                    guard var duration = self?.playerQueue?.currentItem?.duration.seconds else { return }
                
                    if duration == Double.nan {
                        duration = MediaPlayer.iTunesPreviewDuration
                    }
                    
                    if duration - currentTime.seconds < 1 {
                        // we are ending the track.
                        // send a notification to the player.
                        
                        os_log("Track end", log: Log.player, type: .info)
                        self?.next()
                        self?.delegate.update()
                    }
                }
        }
    }
    
    fileprivate func removePeriodicTimeObserver() {
        // If a time observer exists, remove it
        if let token = timeObserverToken {
            os_log("RemovePeriodicTimeObserver", log: Log.player, type: .info)
            playerQueue?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
}

