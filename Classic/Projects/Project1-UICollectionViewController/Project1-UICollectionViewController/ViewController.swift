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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // This is a picture to load!
                pictures.append(item)
            }
        }
        
        pictures = pictures.sorted()
        
        // Sharing button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
        
        cell.imageView.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: detailViewIdentifier) as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
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
    
}
