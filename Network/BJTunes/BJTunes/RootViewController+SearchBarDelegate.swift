//
//  RootViewController+SearchBarDelegate.swift
//  BJTunes
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/7/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import Foundation
import UIKit

extension RootViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        if (!searchBar.text!.isEmpty) {
            queryService.getSearchResults(searchTerm: searchBar.text!) { (tracks, error) in
                if let tracks = tracks {
                    self.searchResults = tracks
                    self.tableView.reloadData()
                    self.tableView.setContentOffset(CGPoint.zero, animated: true)
                }
                
                if !error.isEmpty {
                    print("Search error: " + error)
                }
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
      return .topAttached
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapGestureRecognizer)
    }
}
