//
//  PlayerBulletController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class PlayerBulletController: Controller {
    let duration: TimeInterval = 1.4
    let SPEED: CGFloat = 300
    init() {
        super.init(view: SKSpriteNode(texture: PLAYER_BULLET_TEXTURE))
        
        view.physicsBody = SKPhysicsBody(texture: view.texture!, size: view.size)
        view.physicsBody?.categoryBitMask = PLAYER_BULLET
        view.physicsBody?.contactTestBitMask = ENEMY
        view.physicsBody?.collisionBitMask = 0
        view.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        view.name = "player_bullet"

    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        let moveToTopAction = SKAction.moveToTop(position: self.position, rect: parent.frame, duration: duration)
        
        view.run(SKAction.sequence([moveToTopAction, SKAction.removeFromParent()]))
    }
}
