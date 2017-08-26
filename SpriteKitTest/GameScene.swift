//
//  GameScene.swift
//  SpriteKitTest
//
//  Created by pawel-rusin on 2017/08/26.
//  Copyright © 2017 pawel-rusin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    let player = SKSpriteNode(imageNamed: "Warrior_idle")

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(addMonster),
            SKAction.wait(forDuration: 3.0)
            ])))
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    func addMonster() {
        let monster = SKSpriteNode(imageNamed: "Orc_walking")
        let actualY = random(min: monster.size.height / 2, max: size.height - monster.size.height / 2)
        monster.position = CGPoint(x: size.width + monster.size.width / 2, y: actualY)
        addChild(monster)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY) , duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //guard let touch = touches.first else { return }
        //let touchLocation = touch.location(in: self)
        player.run()

    }

}
