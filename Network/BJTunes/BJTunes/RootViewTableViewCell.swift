//
//  RootViewTableViewCell.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

protocol RootViewTableViewCellDelegate {
    func pauseTapped(_ cell: RootViewTableViewCell)
    func resumeTapped(_ cell: RootViewTableViewCell)
    func cancelTapped(_ cell: RootViewTableViewCell)
    func downloadTapped(_ cell: RootViewTableViewCell)
}

class RootViewTableViewCell: UITableViewCell {
    var delegate: RootViewTableViewCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
        if pauseButton.titleLabel?.text == "Pause" {
            delegate?.pauseTapped(self)
        }
        else {
            delegate?.resumeTapped(self)
        }
    }
    
    @IBAction func cancelTapped(_ sender: AnyObject) {
        delegate?.cancelTapped(self)
    }
    
    @IBAction func downloadTapped(_ sender: AnyObject) {
        delegate?.downloadTapped(self)
    }
    
    func configure(track: Track, downloaded: Bool, download: Download?) {
        titleLabel.text = track.name
        artistLabel.text = track.artist

        // Download controls are Pause/Resume, Cancel buttons, progress info
        var showDownloadControls = false
        // Non-nil Download object means a download is in progress
        if let download = download {
          showDownloadControls = true
          let title = download.isDownloading ? "Pause" : "Resume"
          pauseButton.setTitle(title, for: .normal)
          progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
        }

        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        progressView.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        
        // If the track is already downloaded, enable cell selection and hide the Download button
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded || showDownloadControls
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
      progressView.progress = progress
      progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}
