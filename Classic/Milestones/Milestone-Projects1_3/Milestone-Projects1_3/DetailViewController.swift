//
//  DetailViewController.swift
//  Milestone-Projects1_3
//
//  Created by Carlos David on 16/05/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = imageName {
            self.title = title.count > 2 ? title.capitalized : title.uppercased()
        }
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = imageName {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        //  Sharing button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        let message = "This is the flag of \(title!)"
        
        let vc = UIActivityViewController(activityItems: [message, imageView.image!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
