//
//  DetailViewController.swift
//  Project1
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
