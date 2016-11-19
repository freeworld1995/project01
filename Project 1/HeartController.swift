//
//  HeartController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/19/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class HeartController: Controller {
    
    init() {
        super.init(view: View(texture: HEART_TEXTURE))
        
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.categoryBitMask = HEART
        view.physicsBody?.contactTestBitMask = PLAYER_MASK
        view.physicsBody?.collisionBitMask = 0
        view.name = "heart"
        view.handleContact = { otherView in
            self.view.removeFromParent()
        }
        
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        
        let heartMovement = moveAction
        
        view.run(SKAction.sequence([heartMovement!, SKAction.removeFromParent()]))
    }
}
