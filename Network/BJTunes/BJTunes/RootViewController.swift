//
//  RootViewController.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class RootViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults: [Track] = []
    let queryService = QueryService()
    let downloadService = DownloadService()
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "bgSessionConfiguration")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
      }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        var recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return recognizer
    }()
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func localFilePath(url: URL) -> URL {
        return documentsDirectory.appendingPathComponent(url.lastPathComponent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView()
        downloadService.downloadsSession = downloadsSession
    }

    func playDownload(_ track: Track) {
        let playerVC = AVPlayerViewController()
        playerVC.entersFullScreenWhenPlaybackBegins = true
        playerVC.exitsFullScreenWhenPlaybackEnds = true
        present(playerVC, animated: true, completion: nil)
        let url = localFilePath(url: track.previewURL)
        let player = AVPlayer(url: url)
        playerVC.player = player
        player.play()
    }
    
    func reload(_ row: Int) {
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as? RootViewTableViewCell else {
            print("something wrong")
            return UITableViewCell()
        }
        cell.delegate = self
        let track = searchResults[indexPath.row]
        cell.configure(track: track, downloaded: track.downloaded, download: downloadService.activeDownloads[track.previewURL])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 62.0
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = searchResults[indexPath.row]
        if track.downloaded {
            playDownload(track)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RootViewController: RootViewTableViewCellDelegate {
    func pauseTapped(_ cell: RootViewTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = searchResults[indexPath.row]
            downloadService.pauseDownload(track)
            reload(indexPath.row)
        }
    }
    
    func resumeTapped(_ cell: RootViewTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = searchResults[indexPath.row]
            downloadService.resumeDownload(track)
            reload(indexPath.row)
        }
    }
    
    func cancelTapped(_ cell: RootViewTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = searchResults[indexPath.row]
            downloadService.cancelDownload(track)
            reload(indexPath.row)
        }
    }
    
    func downloadTapped(_ cell: RootViewTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = searchResults[indexPath.row]
            downloadService.startDownload(track)
            reload(indexPath.row)
        }
    }
}
