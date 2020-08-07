//
//  ViewController.swift
//  Milestone-Projects7_9
//
//  Created by Carlos David on 08/02/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import UIKit

extension String {
    public subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    
    var currentWordLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var bagOfWords = [String]()
    var currentWord: String = ""
    
    var score = 0 {
        didSet {
            DispatchQueue.main.async {
                self.scoreLabel.text = "Score: \(self.score)"
            }
        }
    }
    
    var attempts = 10 {
        didSet {
            DispatchQueue.main.async {
                if (self.attempts == 0) {
                    let ac = UIAlertController(title: "Game over! 💀", message: "You are out of attempts", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Start again", style: .default, handler: self.startGame))
                    self.present(ac, animated: true)
                }
                
                self.attemptsLabel.text = "Attempts: \(self.attempts)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.textAlignment = .right
        attemptsLabel.textAlignment = .left
        
        currentWordLabel = UILabel()
        currentWordLabel.text = ""
        currentWordLabel.textAlignment = .center
        currentWordLabel.font = .systemFont(ofSize: 24)
        currentWordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentWordLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let sideSize = 60
        let numberOfRows = 6
        let numberOfColumns = 5
        
        NSLayoutConstraint.activate([
            currentWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWordLabel.centerYAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 75),
            currentWordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            buttonsView.widthAnchor.constraint(equalToConstant: CGFloat(sideSize * numberOfColumns)),
            buttonsView.heightAnchor.constraint(equalToConstant: CGFloat(sideSize * numberOfRows)),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: currentWordLabel.bottomAnchor, constant: 75)
        ])
        
        var character: Character = "A"
        let lastCharacter: Character = "Z"
        
        for row in 0 ..< numberOfRows where character <= lastCharacter {
            for column in 0 ..< numberOfColumns where character <= lastCharacter {
                
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                letterButton.setTitle("\(character)", for: .normal)
                character = nextCharacter(character)
                
                let frame = CGRect(x: sideSize * column, y: sideSize * row, width: sideSize, height: sideSize)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        startGame(action: nil)
    }
    
    func nextCharacter(_ character: Character) -> Character {
        var newCharacter = character
        if let lastCharacter = character.unicodeScalars.last {
            if let unicodeScalar = UnicodeScalar(lastCharacter.value + 1) {
                newCharacter = Character(unicodeScalar)
            }
        }
        
        return newCharacter
    }
    
    func startGame(action: UIAlertAction?) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.score = 0
            
            self.loadData(action: nil)
            self.loadLevel(action: nil)
        }
    }
    
    func loadData(action: UIAlertAction?) {
        bagOfWords.removeAll(keepingCapacity: true)
        if let wordsFileURL = Bundle.main.url(forResource: "Words", withExtension: "txt") {
            if let wordsContents = try? String(contentsOf: wordsFileURL) {
                bagOfWords = wordsContents.components(separatedBy: "\n").filter { !$0.isEmpty }
                bagOfWords.shuffle()
            }
        }
        
        if bagOfWords.isEmpty {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "Error loading data", message: "There was an error loading data from file", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: self.loadData))
                self.present(ac, animated: true)
            }
        }
    }
    
    func loadLevel(action: UIAlertAction?) {
        if bagOfWords.isEmpty {
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "You did it! 🎉", message: "There are no more words to guess. You are a champion!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Start again", style: .default, handler: self.startGame))
                self.present(ac, animated: true)
            }
            
            return
        }
        
        self.attempts = 10
        currentWord = bagOfWords.popLast()!
        
        let attributedText = getAttributedStringFrom(String(repeating: "_",
                                                            count: currentWord.count))
        
        DispatchQueue.main.async {
            self.currentWordLabel.attributedText = attributedText
            for letterButton in self.letterButtons {
                letterButton.isEnabled = true
                letterButton.tintColor = UIColor.systemBlue
            }
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        let selectedCharacter = sender.currentTitle![0]
        var disabledTitleColor: UIColor
        var displayedText = Array(currentWordLabel.text!)
        
        if currentWord.contains(selectedCharacter) {
            for (index, character) in currentWord.enumerated() {
                if character == selectedCharacter {
                    displayedText[index] = character
                }
            }
            
            disabledTitleColor = UIColor.systemGreen
        } else {
            disabledTitleColor = UIColor.systemRed
            attempts -= 1
        }
        
        DispatchQueue.main.async {
            if !displayedText.isEmpty {
                self.currentWordLabel.attributedText = self.getAttributedStringFrom(String(displayedText))
            }
            
            sender.isEnabled = false
            sender.setTitleColor(disabledTitleColor, for: .disabled)
            
            if !displayedText.contains("_") {
                self.score += 1
                let ac = UIAlertController(title: "Well done!", message: "You guessed this word! Will you be able to pass the next challenge?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go", style: .default, handler: self.loadLevel))
                self.present(ac, animated: true)
            }
        }
    }
    
    func getAttributedStringFrom(_ string: String) -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [NSAttributedString.Key.kern:CGFloat(10.0)])
    }
}
