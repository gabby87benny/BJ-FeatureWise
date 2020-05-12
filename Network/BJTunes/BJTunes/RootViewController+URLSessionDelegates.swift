//
//  RootViewController+URLSessionDelegates.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/12/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import Foundation
import UIKit

extension RootViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceUrl = downloadTask.originalRequest?.url else { return }
        let destinationUrl = localFilePath(url: sourceUrl)
        let download = downloadService.activeDownloads[sourceUrl]
        downloadService.activeDownloads[sourceUrl] = nil
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: sourceUrl)
        
        do {
            try fileManager.copyItem(at: location, to: destinationUrl)
            download?.track.downloaded = true
        } catch let error {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        
        if let index = download?.track.index {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.originalRequest?.url , let download = downloadService.activeDownloads[url] else { return }
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        DispatchQueue.main.async {
            if let trackCell = self.tableView.cellForRow(at: IndexPath(row: download.track.index, section: 0)) as? RootViewTableViewCell {
                trackCell.updateDisplay(progress: download.progress, totalSize: totalSize)
            }
        }
    }
}

extension RootViewController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
}
