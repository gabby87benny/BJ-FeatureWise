//
//  QueryService.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import Foundation

class QueryService {
    typealias JSONDictionary = [String: Any]
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
        var response: JSONDictionary?
        tracks.removeAll()
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        }
        catch let parseError as NSError {
            self.errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        var index = 0
        
        for trackDict in array {
            if let trackDictionary = trackDict as? JSONDictionary,
              let previewURLString = trackDictionary["previewUrl"] as? String,
              let previewURL = URL(string: previewURLString),
              let name = trackDictionary["trackName"] as? String,
              let artist = trackDictionary["artistName"] as? String {
              tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
              index += 1
            } else {
              errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
