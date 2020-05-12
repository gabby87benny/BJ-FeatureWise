//
//  DownloadService.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/12/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import Foundation

class DownloadService {
    var downloadsSession: URLSession!
    var activeDownloads: [URL: Download] = [:]

    func startDownload(_ track: Track) {
        let download = Download(track: track)
        download.task = downloadsSession.downloadTask(with: track.previewURL)
        download.task!.resume()
        download.isDownloading = true
        activeDownloads[download.track.previewURL] = download
    }

    func pauseDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if download.isDownloading {
            download.task?.cancel(byProducingResumeData: { data in
                download.resumeData = data
            })
            download.isDownloading = false
        }
    }

    func resumeDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        }
        else {
            download.task = downloadsSession.downloadTask(with: download.track.previewURL)
        }
        download.task!.resume()
        download.isDownloading = true
    }

    func cancelDownload(_ track: Track) {
        if let download = activeDownloads[track.previewURL] {
            download.task?.cancel()
            activeDownloads[download.track.previewURL] = nil
        }
    }
}

