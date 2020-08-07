//
//  ViewController.swift
//  Project1-GCD
//
//  Created by Carlos David on 17/03/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellIdentifier = "Picture"
    private let detailViewIdentifier = "Detail"
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items where item.hasPrefix("nssl") {
                // This is a picture to load!
                self.pictures.append(item)
            }
            
            self.pictures.sort()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Sharing button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageIndex = indexPath.row + 1
            vc.totalImageNumber = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let message = "Download Project 1 to get awesome pictures of great storms"
        
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
