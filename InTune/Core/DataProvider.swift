//
//  DataProvider.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation
import os.log

protocol DataProviding {
    init(service: ServiceProvider)
    func search(term: String)
}

struct Log {
    static var data = OSLog(subsystem: "com.sonomos.InTune", category: "data")
    static var network = OSLog(subsystem: "com.sonomos.InTune", category: "network")
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
                self.dataLoaded?.dataReceived(errorMessage: nil)
            } catch {
                os_log("Error: %s", log: Log.data, type: .error, error.localizedDescription)
                self.dataLoaded?.dataReceived(errorMessage: error.localizedDescription)
            }
            
        }
    }
    
    func prepareSearchResults() {
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
}
