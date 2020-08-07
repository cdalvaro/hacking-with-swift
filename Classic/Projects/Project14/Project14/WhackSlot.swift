//
//  WhackSlot.swift
//  Project14
//
//  Created by Carlos David on 05/08/2020.
//

import SpriteKit
import UIKit

class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
    
    var isVisible = false
    var isHit = false
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        showMud()
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) {
            [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        
        showMud()
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        
        let delay = SKAction.wait(forDuration: 0.25)
        
        if let smokeParticles = SKEmitterNode(fileNamed: "smokeParticles.sks") {
            smokeParticles.position = charNode.position
            charNode.addChild(smokeParticles)
        }
        
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run {
            [weak self] in self?.isVisible = false
        }
        
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
    
    func showMud() {
        if let smokeParticles = SKEmitterNode(fileNamed: "mudParticles.sks") {
            smokeParticles.position = CGPoint(x: 0, y: -15)
            smokeParticles.zPosition = 1
            addChild(smokeParticles)
        }
    }

}
