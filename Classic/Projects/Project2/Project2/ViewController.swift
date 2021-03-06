//
//  ViewController.swift
//  Project2
//
//  Created by Carlos David on 26/03/2019.
//  Copyright © 2019 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsCounter = 0
    let questionsLimit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += [
            "estonia", "france", "germany",
            "ireland", "italy", "monaco",
            "nigeria", "poland", "russia",
            "spain", "uk", "us"
        ]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(_ action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "\(countries[correctAnswer].uppercased()) - Score: \(score)"
    }
    
    func resetGame(_ action: UIAlertAction!) {
        score = 0
        questionsCounter = 0
        askQuestion(action)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        questionsCounter += 1
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            message = "Your score is \(score)"
            score += 1
        } else {
            title = "Wrong!"
            message = "That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac: UIAlertController!
        
        if questionsCounter == questionsLimit {
            ac = UIAlertController(title: "Your final score is \(score)",
                message: "You have answered \(questionsCounter) questions",
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: resetGame))
        } else {
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        
        present(ac, animated: true)
    }
    
    @IBAction func showScore(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Your score is \(score)!",
            message: "You have answered \(questionsCounter) of \(questionsLimit) questions",
            preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
}

