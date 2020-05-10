//
//  DetailedViewController.swift
//  Milestone-Projects10_12
//
//  Created by Carlos David on 09/05/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var image: String?
    var caption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = caption
        if let image = image {
            imageView.image = UIImage(contentsOfFile: image)
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
}
