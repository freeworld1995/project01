//
//  EnemyBulletController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class EnemyBulletController: Controller {
    
    let duration: TimeInterval = 1.7
    let SPEED: CGFloat = 300
    
    init() {
        super.init(view: SKSpriteNode(texture: ENEMY_BULLET_TEXTURE))
        
        view.physicsBody = SKPhysicsBody(texture: view.texture!, size: view.size)
        view.physicsBody?.categoryBitMask = ENEMY_BULLET
        view.physicsBody?.contactTestBitMask = PLAYER_MASK
        view.physicsBody?.collisionBitMask = 0
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        
        let moveToBottom = SKAction.moveToBottom(position: self.position, rect: parent.frame, duration: duration)
        
        view.run(SKAction.sequence([moveToBottom, SKAction.removeFromParent()]))
    }
}
