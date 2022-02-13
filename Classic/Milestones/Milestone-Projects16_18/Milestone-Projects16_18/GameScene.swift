//
//  GameScene.swift
//  Milestone-Projects16_18
//
//  Created by Carlos Álvaro on 23/1/22.
//

import SpriteKit
import GameplayKit

@propertyWrapper
struct Score {
    private var score: Int

    public init(_ score: Int = 0) {
        self.score = score
    }

    var wrappedValue: Int {
        get { return score }
        set { score = max(newValue, 0) }
    }
}

class GameScene: SKScene {
    
    private var scoreLabel : SKLabelNode!
    @Score private var score {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        createBackground()
        createOverlay()
    }

    func createBackground() {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: 400, y: 300)
        background.blendMode = .replace // Ignore any alpha values
        background.zPosition = -1 // Draws the background behind everything else
        addChild(background)

        let grass = SKSpriteNode(imageNamed: "grass-trees")
        grass.position = CGPoint(x: 400, y: 300)
        grass.zPosition = 100
        addChild(grass)
    }

    func createOverlay() {
        let curtains = SKSpriteNode(imageNamed: "curtains")
        curtains.position = CGPoint(x: 400, y: 300)
        curtains.zPosition = 400
        addChild(curtains)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 680, y: 50)
        scoreLabel.zPosition = 500
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
    }
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
