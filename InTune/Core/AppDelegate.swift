//
//  AppDelegate.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appController = AppController()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        appController.start()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let category = AVAudioSession.Category.playback
            try audioSession.setCategory(category, mode: .default, options: .defaultToSpeaker)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        return true
    }
}

