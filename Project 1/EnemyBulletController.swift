//
//  EnemyBulletController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class EnemyBulletController: Controller {
    
    let duration: TimeInterval = 2.2
    
    init() {
        super.init(view: View(texture: ENEMY_BULLET_TEXTURE))
        
        view.physicsBody = SKPhysicsBody(texture: view.texture!, size: view.size)
        view.physicsBody?.categoryBitMask = ENEMY_BULLET
        view.physicsBody?.contactTestBitMask = PLAYER_MASK
        view.physicsBody?.collisionBitMask = 0
        view.name = "enemy_bullet"
        view.handleContact = { otherView in
            self.view.removeFromParent()
        }
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        
        let bulletMovement = shootAction
//            SKAction.moveToBottom(position: self.position, rect: parent.frame, duration: duration)
        
        view.run(SKAction.sequence([bulletMovement!, SKAction.removeFromParent()]))
    }
}
