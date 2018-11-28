//
//  MediaPlayerDataProvider.swift
//  InTune
//
//  Created by Ronan on 28/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import os.log

protocol MediaPlayerDataProvider {
    func mediaUrls(from index: Int) -> [URL]
}

extension DataProvider: MediaPlayerDataProvider {
    func mediaUrls(from index: Int) -> [URL] {
        var urls: [URL] = []
        let searchResults = appData.searchResults
        
        for resultIndex in index..<searchResults.count {
            let searchResult = searchResults[resultIndex]
            if let url = URL(string: searchResult.previewURL) {
                urls.append(url)
            } else {
                os_log("Invalid URL for media file for track named: %s with ID: %d", log: Log.player, type: .error, searchResult.trackName, searchResult.identifier)
            }
        }
        return urls
    }
}
