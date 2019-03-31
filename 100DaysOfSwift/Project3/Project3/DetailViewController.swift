//
//  DetailViewController.swift
//  Project3
//
//  Created by Carlos David on 22/03/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageIndex: Int?
    var totalImageNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = selectedImageIndex, let total = totalImageNumber {
            title = "Picture \(index) of \(total)"
        } else {
            title = selectedImage
        }
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
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
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        // This line is necessary for iPad -> Shows the controller bellow the right bar button
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
