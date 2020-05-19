//
//  RootViewController.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

struct RootViewControllerConstants {
    static let tableViewCellIdentifier = "RVCTableViewCellIdentifier"
}

class RootViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var items: [BJItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        APIManager.sharedManager.getItems {[weak self] items in
            self?.items = items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        APIManager.sharedManager.cancelAllOperations()
    }
}

//MARK: Table view data source
extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootViewControllerConstants.tableViewCellIdentifier, for: indexPath) as? RVCTableViewCell else {
            print("Unable to create RVCTableViewCell")
            return UITableViewCell()
        }
        let item = items[indexPath.row];
        cell.lblAnswer.text = "\(item.itemId)"
        return cell
    }
}

//MARK: Table view delegate
extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

