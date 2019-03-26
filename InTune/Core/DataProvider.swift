//
//  DataProvider.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import os.log

struct Log {
    static var general = OSLog(subsystem: "com.sonomos.InTune", category: "general")
    static var data = OSLog(subsystem: "com.sonomos.InTune", category: "data")
    static var network = OSLog(subsystem: "com.sonomos.InTune", category: "network")
    static var player = OSLog(subsystem: "com.sonomos.InTune", category: "AVPlayer")
}

protocol DataProviding: class {
    func search(term: String)
    func sort(option: SortOption)
    func parseResults(results: [Result]) -> [SearchResult]
    func result(at index: Int) -> Result?
}

class DataProvider: DataProviding {
    let appData = AppData()
    var dataLoaded: DataLoaded?
    let networkService: ServiceProvider

    required init(service: ServiceProvider) {
        self.networkService = service
    }
    
    func search(term: String) {
        let searchService = networkService.makeSearchiTunesService()
        
        // If the search is the same as the last one performed, dismiss the HUD and return
        if term == appData.searchTerm {
            self.dataLoaded?.dataReceived(errorMessage: nil)
            return
        }
        
        appData.searchTerm = term
        appData.results.removeAll()
        appData.searchResults.removeAll()
        appData.selectedIndex = 0
        
        searchService.load(term: term) { (data, errorMessage) in
            if let errorMessage = errorMessage {
                os_log("Error message: %s", log: Log.network, type: .error, errorMessage)
                self.dataLoaded?.dataReceived(errorMessage: errorMessage)
                return
            }
            
            guard let data = data else {
                os_log("Error message: %s", log: Log.network, type: .error, Constants.Translations.Error.noDataError)
                self.dataLoaded?.dataReceived(errorMessage: Constants.Translations.Error.noDataError)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let serverResponse = try decoder.decode(ServerResponse.self, from: data)
                self.appData.results = serverResponse.results
                
                if serverResponse.resultCount == 0 {
                    self.dataLoaded?.dataReceived(errorMessage: Constants.Translations.Error.noResultsFound)
                    return
                }
                
                self.prepareSearchResults()
                self.sort(option: self.appData.currentSortOption)
                self.dataLoaded?.dataReceived(errorMessage: nil)
            } catch {
                os_log("Error: %s", log: Log.data, type: .error, error.localizedDescription)
                self.dataLoaded?.dataReceived(errorMessage: error.localizedDescription)
            }
        }
    }
    
    fileprivate func prepareSearchResults() {
        let results = appData.results
        appData.searchResults = parseResults(results: results)
    }
    
    func parseResults(results: [Result]) -> [SearchResult] {
        var searchResults = [SearchResult]()
        let parser = ResultParser()
        
        for result in results {
            let searchResult = parser.parse(result: result)
            searchResults.append(searchResult)
        }
        return searchResults
    }
    
    func sort(option: SortOption) {
        appData.sort(option: option)
    }
    
    func result(at index: Int) -> Result? {
        if appData.searchResults.count > index {
            let searchResult = appData.searchResults[index]
            let identifier = searchResult.identifier
            
            let filterOutput = appData.results.filter {$0.trackID == identifier}
            
            guard let firstResult = filterOutput.first else { return nil }
            return firstResult
        }
        return nil
    }
}
