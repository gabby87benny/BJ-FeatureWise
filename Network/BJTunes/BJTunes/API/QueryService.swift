//
//  QueryService.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import Foundation

class QueryService {
    
    typealias QueryResult = ([Track]?, String) -> ()
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var tracks: [Track] = []
    var errorMessage = ""
    
    func getSearchResults(searchTerm: String, completion: @escaping QueryResult) {
        dataTask?.cancel()
        if var urlComps = URLComponents(string: "https://itunes.apple.com/search") {
            urlComps.query = "media=music&entity=song&term=\(searchTerm)"
            guard let url = urlComps.url else {
                return
            }
            dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
                defer {
                    self.dataTask = nil
                }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.updateSearchResults(data)
                    DispatchQueue.main.async {
                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
        }
        dataTask?.resume()
    }
    
    fileprivate func updateSearchResults(_ data: Data) {
        
    }
}
