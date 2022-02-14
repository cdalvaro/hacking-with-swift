//
//  Target.swift
//  Milestone-Projects16_18
//
//  Created by Carlos Álvaro on 13/2/22.
//

import SpriteKit

class Target: SKNode {
    private var target: SKSpriteNode!
    private var stick: SKSpriteNode!

    init(scale: CGFloat) {
        super.init()
        setup(scale: scale)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(scale: CGFloat) {
        let stickType = Int.random(in: 0...2)
        let targetType = Int.random(in: 0...3)

        stick = SKSpriteNode(imageNamed: "stick\(stickType)")
        target = SKSpriteNode(imageNamed: "target\(targetType)")

        target.name = "target"
        target.position.y += 116
        target.xScale *= scale
        target.yScale *= scale

        addChild(stick)
        addChild(target)
    }

    func hit() {
        removeAllActions()
        target.name = nil

        let animationTime = 0.2
        target.run(SKAction.colorize(with: .black, colorBlendFactor: 1, duration: animationTime))
        stick.run(SKAction.colorize(with: .black, colorBlendFactor: 1, duration: animationTime))
        run(SKAction.fadeOut(withDuration: animationTime))
        run(SKAction.moveBy(x: 0, y: -30, duration: animationTime))
        run(SKAction.scaleX(by: 0.8, y: 0.7, duration: animationTime))
    }
}
