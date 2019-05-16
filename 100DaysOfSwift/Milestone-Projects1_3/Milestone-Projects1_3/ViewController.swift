//
//  ViewController.swift
//  Milestone-Projects1_3
//
//  Created by Carlos David on 19/04/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let pictureCellIdentifier = "Picture"
    private let detailViewControllerIdentifier = "DetailViewController"
    private var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        flags += [
            "estonia", "france", "germany",
            "ireland", "italy", "monaco",
            "nigeria", "poland", "russia",
            "spain", "uk", "us"
        ]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pictureCellIdentifier, for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as? DetailViewController {
            vc.imageName = flags[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

