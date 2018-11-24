//
//  DataProvider.swift
//  InTune
//
//  Created by Ronan on 22/11/2018.
//  Copyright © 2018 Sonomos. All rights reserved.
//

import Foundation

protocol DataProviding {
    init(service: ServiceProvider)
    func search(term: String)
}

class DataProvider: DataProviding {
    let appData = AppData()
    
    let networkService: ServiceProvider
    
    required init(service: ServiceProvider) {
        self.networkService = service
    }
    
    func search(term: String) {
        let searchService = networkService.makeSearchiTunesService()
        
        appData.searchTerm = term
        
        searchService.load(term: term) { (data, errorMessage) in
            if let errorMessage = errorMessage {
                // write a test for this error message.
                print("Error message.\(errorMessage)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received.")
                //self.dataLoaded?.dataReceived(errorMessage: "Error: No data received.")
                return
            }
            
            do {
                let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
                self.appData.results = serverResponse.results
                
                
            } catch {
                print("Error: \(error)")
                print(Constants.Translations.Error.jsonDecodingError)
            }
            
        }
    }
}
