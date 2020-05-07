//
//  Track.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class Track {
    let name: String
    let artist: String
    let previewURL: URL
    let index: Int
    var downloaded = false

    init(name: String, artist: String, previewURL: URL, index: Int) {
      self.name = name
      self.artist = artist
      self.previewURL = previewURL
      self.index = index
    }
}
