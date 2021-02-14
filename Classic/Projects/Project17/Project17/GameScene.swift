//
//  GameScene.swift
//  Project17
//
//  Created by Carlos David on 13/2/21.
//

import SpriteKit

@propertyWrapper
struct MinValue<Value: Comparable> {
    private var minValue: Value
    private var value: Value

    init(wrappedValue value: Value, _ minValue: Value) {
        self.value = value
        self.minValue = minValue
    }

    var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = max(newValue, minValue)
        }
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!

    var gameOverLabel: SKLabelNode!
    var finalScoreLabel: SKLabelNode!

    let possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false

    @MinValue(0.1)
    var createEnemyRate = 1.0

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black

        starfield = SKEmitterNode(fileNamed: "starfield")
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1

        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0

        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        setDifficulty(timeInterval: createEnemyRate)
    }

    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }

        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50 ... 736))
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()

                if !isGameOver {
                    score += 1
                    if score.isMultiple(of: 20) {
                        createEnemyRate -= 0.1
                        setDifficulty(timeInterval: createEnemyRate)
                    }
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)

        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }

        player.position = location
    }

    func didBegin(_ contact: SKPhysicsContact) {
        destroyPlayer()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !isGameOver {
            destroyPlayer()
        }
    }

    func destroyPlayer() {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)

        player.removeFromParent()

        gameOver()
    }

    func gameOver() {
        isGameOver = true
        gameTimer?.invalidate()

        scoreLabel.isHidden = true

        gameOverLabel = SKLabelNode(fontNamed: "Marker Felt")
        gameOverLabel.fontSize = 96
        gameOverLabel.position = CGPoint(x: 512, y: 400)
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)

        finalScoreLabel = SKLabelNode(fontNamed: "Marker Felt")
        finalScoreLabel.fontSize = 64
        finalScoreLabel.position = CGPoint(x: 512, y: 300)
        finalScoreLabel.text = "Final Score: \(score)"
        finalScoreLabel.zPosition = 1
        addChild(finalScoreLabel)
    }

    func setDifficulty(timeInterval: TimeInterval) {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval,
                                         target: self,
                                         selector: #selector(createEnemy),
                                         userInfo: nil,
                                         repeats: true)
    }
}
