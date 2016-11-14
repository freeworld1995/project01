//
//  PlayerController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class PlayerController: Controller {
    
    init() {
        super.init(view: SKSpriteNode(texture: PLAYER_TEXTURE))
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        view.physicsBody = SKPhysicsBody(texture: view.texture!, size: view.size)
        view.physicsBody?.categoryBitMask = PLAYER_MASK
        view.physicsBody?.contactTestBitMask = ENEMY_BULLET
        view.physicsBody?.collisionBitMask = 0
        self.configConstraints()
        self.configShoot()
    }
    
    func configConstraints() {
        // Constraints
        let xRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.width)
        let yRange = SKRange(lowerLimit: 0, upperLimit: parent.frame.height)
        view.constraints = [SKConstraint.positionX(xRange, y: yRange)]
    }
    
    func configShoot() {
        let shootAction = SKAction.run {
            let bulletController = PlayerBulletController()
            let startPosition = CGPoint(x: self.position.x, y: self.position.y + 0.5 * (self.height + bulletController.height))
            
            bulletController.config(position: startPosition, parent: self.parent, shootAction: nil, moveAction: nil)
        }
        
        let shootWithDelayAction = SKAction.sequence([shootAction, SKAction.wait(forDuration: TimeInterval(0.5))])
        view.run(SKAction.repeatForever(shootWithDelayAction))
    }
    
    func move(vector: CGVector) {
        view.position = view.position.add(vector: vector)
    }
}
