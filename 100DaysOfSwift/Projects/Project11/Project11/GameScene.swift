//
//  GameScene.swift
//  Project11
//
//  Created by Carlos David on 08/03/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import SpriteKit

@propertyWrapper
struct Constrained<Value: Comparable> {
    private var range: ClosedRange<Value>
    private var value: Value
    
    init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
        self.value = value
        self.range = range
    }
    
    var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = max(min(newValue, range.upperBound), range.lowerBound)
        }
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let mainFont = "Chalkduster"
    
    var scoreLabel: SKLabelNode!
    var ballsLabel: SKLabelNode!
    var clickHeight: CGFloat!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @Constrained(0...5)
    var ballsCounter = 0 {
        didSet {
            ballsLabel.text = "Balls: \(ballsCounter)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace // Ignore any alpha values
        background.zPosition = -1 // Draws the background behind everything else
        addChild(background)
        
        let frameSize = frame.size
        
        clickHeight = frameSize.height * 0.70
        let clickLine = SKSpriteNode(color: .cyan, size: CGSize(width: frameSize.width * 0.9, height: 2))
        clickLine.position = CGPoint(x: frameSize.width * 0.5, y: clickHeight)
        addChild(clickLine)
        
        scoreLabel = SKLabelNode(fontNamed: mainFont)
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 900, y: 700)
        addChild(scoreLabel)
        score = 0
        
        ballsLabel = SKLabelNode(fontNamed: mainFont)
        ballsLabel.horizontalAlignmentMode = .left
        ballsLabel.position = CGPoint(x: 500, y: 700)
        addChild(ballsLabel)
        ballsCounter = 5
        
        editLabel = SKLabelNode(fontNamed: mainFont)
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            if editingMode {
                // create a box
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1),
                                                      green: CGFloat.random(in: 0...1),
                                                      blue: CGFloat.random(in: 0...1),
                                                      alpha: 1),
                                       size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "box"
                addChild(box)
            } else if (location.y > clickHeight && ballsCounter > 0) {
                ballsCounter = ballsCounter - 1
                
                let ball = SKSpriteNode(imageNamed: Ball().fileName())
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                ball.position = location
                ball.name = Ball.name
                addChild(ball)
            }
        }
        
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballsCounter = ballsCounter + 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        } else if object.name == "box" {
            object.removeFromParent()
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == Ball.name {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == Ball.name {
            collision(between: nodeB, object: nodeA)
        }
    }
}
