//
//  ViewController.swift
//  Project18
//
//  Created by Carlos David on 15/2/21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("I'm inside the viewDidLoad() method.")

        print("Some message", terminator: " | ")

        print(1, 2, 3, 4, 5, separator: "-")

        assert(1 == 1, "Maths Failure! 1")
        assert(1 == 2, "Maths Failure! 2")
    }
}
