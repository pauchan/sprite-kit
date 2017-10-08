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
    let background = SKSpriteNode(imageNamed: "background")


    override func didMove(to view: SKView) {

        background.position = CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0)
        background.size = frame.size
        background.zPosition = -1.0
        addChild(background)
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
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
        monster.position = CGPoint(x: size.width + monster.size.width / 2, y: size.height * 0.4)
        addChild(monster)
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: size.height * 0.4) , duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let fightAtlas = SKTextureAtlas(named: "Warrior_fighting")
        let textures = fightAtlas.textureNames.sorted().map {
            fightAtlas.textureNamed($0)
        }
        player.run(SKAction.animate(with: textures, timePerFrame: 0.1))
    }

}
