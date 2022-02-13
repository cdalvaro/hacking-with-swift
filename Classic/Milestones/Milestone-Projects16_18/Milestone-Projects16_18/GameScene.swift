//
//  GameScene.swift
//  Milestone-Projects16_18
//
//  Created by Carlos Álvaro on 23/1/22.
//

import GameplayKit
import SpriteKit

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
    private var scoreLabel: SKLabelNode!
    @Score private var score {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    private var bulletsSprite: SKSpriteNode!
    private var reloadLabel: SKLabelNode!

    private var bulletTextures = [
        SKTexture(imageNamed: "shots0"),
        SKTexture(imageNamed: "shots1"),
        SKTexture(imageNamed: "shots2"),
        SKTexture(imageNamed: "shots3")
    ]

    private var bulletsInClip = 3 {
        didSet {
            bulletsSprite.texture = bulletTextures[bulletsInClip]
        }
    }

    private var targetDelay = 0.8
    private var targetSpeed = 4.0
    private var targetCreated = 0

    private var isGameOver = false

    override func didMove(to view: SKView) {
        createBackground()
        createOverlay()
        createWater()

        levelUp()
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
        scoreLabel.position = CGPoint(x: 680, y: 60)
        scoreLabel.zPosition = 500
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)

        bulletsSprite = SKSpriteNode(imageNamed: "shots3")
        bulletsSprite.position = CGPoint(x: 170, y: 70)
        bulletsSprite.zPosition = 500
        addChild(bulletsSprite)

        reloadLabel = SKLabelNode(fontNamed: "Chalkduster")
        reloadLabel.horizontalAlignmentMode = .right
        reloadLabel.position = CGPoint(x: 350, y: 60)
        reloadLabel.zPosition = 500
        reloadLabel.text = "Reload"
        reloadLabel.name = "reload"
        addChild(reloadLabel)
    }

    func createWater() {
        func animate(_ node: SKNode, distance: CGFloat, duration: TimeInterval) {
            let movementUp = SKAction.moveBy(x: 0, y: distance, duration: duration)
            let movementDown = movementUp.reversed()
            let sequence = SKAction.sequence([movementUp, movementDown])
            let repeatForever = SKAction.repeatForever(sequence)
            node.run(repeatForever)
        }

        let waterBackground = SKSpriteNode(imageNamed: "water-bg")
        waterBackground.position = CGPoint(x: 400, y: 180)
        waterBackground.zPosition = 200
        addChild(waterBackground)

        let waterForeground = SKSpriteNode(imageNamed: "water-fg")
        waterForeground.position = CGPoint(x: 400, y: 120)
        waterForeground.zPosition = 300
        addChild(waterForeground)

        animate(waterBackground, distance: 8, duration: 1.3)
        animate(waterForeground, distance: 12, duration: 1)
    }

    func levelUp() {
        targetSpeed *= 0.99
        targetDelay *= 0.99
        targetCreated += 1

        if targetCreated < 100 {
            DispatchQueue.main.asyncAfter(deadline: .now() + targetDelay) { [unowned self] in
                self.createTarget()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                self.gameOver()
            }
        }
    }

    func gameOver() {
        isGameOver = true

        let gameOverTitle = SKSpriteNode(imageNamed: "game-over")
        gameOverTitle.alpha = 0
        gameOverTitle.setScale(2)

        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let scaleDown = SKAction.scale(to: 1, duration: 0.3)
        let group = SKAction.group([fadeIn, scaleDown])

        gameOverTitle.run(group)
        gameOverTitle.zPosition = 900
        addChild(gameOverTitle)
    }

    func createTarget() {
        let target = Target()

        let level = Int.random(in: 0 ... 2)
        var movingRight = true

        switch level {
        case 0:
            // in front of the grass
            target.zPosition = 150
            target.position.y = 280
            target.setScale(0.7)
        case 1:
            // in fron of the water background
            target.zPosition = 250
            target.position.y = 190
            target.setScale(0.85)
            movingRight = false
        default:
            // in front of the water foreground
            target.zPosition = 350
            target.position.y = 100
        }

        let move: SKAction
        if movingRight {
            target.position.x = 0
            move = SKAction.moveTo(x: 800, duration: targetSpeed)
        } else {
            target.position.x = 800
            target.xScale = -target.xScale
            move = SKAction.moveTo(x: 0, duration: targetSpeed)
        }

        let sequence = SKAction.sequence([move, SKAction.removeFromParent()])
        target.run(sequence)
        addChild(target)

        levelUp()
    }

    func shot(at location: CGPoint) {
        let hitNodes = nodes(at: location).filter { $0.name == "target" }

        guard let hitNode = hitNodes.first else { return }
        guard let parentNode = hitNode.parent as? Target else { return }

        parentNode.hit()
        score += 3
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver {
            if let newGame = SKScene(fileNamed: "GameScene") {
                let transition = SKTransition.doorway(withDuration: 1)
                view?.presentScene(newGame, transition: transition)
            }
        } else {
            for touch in touches {
                let location = touch.location(in: self)

                let hitNodes = nodes(at: location).filter { $0.name == "reload" }
                if !hitNodes.isEmpty {
                    run(SKAction.playSoundFileNamed("reload.wav", waitForCompletion: false))
                    bulletsInClip = 3
                    score -= 1
                    continue
                }

                if bulletsInClip > 0 {
                    run(SKAction.playSoundFileNamed("shot.wav", waitForCompletion: false))
                    bulletsInClip -= 1
                    shot(at: location)
                } else {
                    run(SKAction.playSoundFileNamed("empty.wav", waitForCompletion: false))

                    let setRed = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.3)
                    let restore = setRed.reversed()
                    let sequence = SKAction.sequence([setRed, restore])
                    reloadLabel.run(sequence)
                }
            }
        }
    }
}
