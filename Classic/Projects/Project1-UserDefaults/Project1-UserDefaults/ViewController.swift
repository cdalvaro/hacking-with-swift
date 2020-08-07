//
//  ViewController.swift
//  Project1-UICollectionViewController
//
//  Created by Carlos David on 17/03/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private let cellIdentifier = "Picture"
    private let detailViewIdentifier = "Detail"
    var pictures = [String]()
    var viewsCounter = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // Load views data from UserDefaults
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "viewsCounter") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                viewsCounter = try jsonDecoder.decode([String: Int].self, from: data)
            } catch {
                print("Unable to load views counter")
            }
        }
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load!
                pictures.append(item)
                
                // Initialize counter for picture
                if !viewsCounter.keys.contains(item) {
                    viewsCounter[item] = 0
                }
            }
        }
        
        pictures = pictures.sorted()
        
        // Sharing button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to deque PictureCell")
        }
        
        let picture = pictures[indexPath.item]
        cell.imageName.text = picture
        cell.imageView.image = UIImage(named: picture)
        
        // Show views counter info
        let timesViewed = viewsCounter[picture]!
        cell.timesViewed.text = "\(timesViewed) " + (timesViewed == 1 ? "time" : "times") + " viewed"
        
        cell.imageView.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as? DetailViewController {
            
            // Save views counter information with UserDefaults
            let pictureName = pictures[indexPath.item]
            viewsCounter[pictureName]! += 1
            saveViewsCounter()
            
            vc.selectedImage = pictureName
            vc.selectedImageIndex = indexPath.item + 1
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
    
    func saveViewsCounter() {
        let jsonEncoder = JSONEncoder()
        if let data = try? jsonEncoder.encode(viewsCounter) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "viewsCounter")
        } else {
            print("Unable to save views counter.")
        }
    }
    
}
