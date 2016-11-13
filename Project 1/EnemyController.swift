//
//  EnemyController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class EnemyController: Controller {
    
    let duration: TimeInterval = 3
    
    init() {
        ENEMY_TEXTURE =  GKRandomSource.sharedRandom().arrayByShufflingObjects(in: ENEMY_TEXTURE) as! [SKTexture]
        super.init(view: SKSpriteNode(texture: ENEMY_TEXTURE[0]))
        
    }
    
    override func config(position: CGPoint, parent: SKNode) {
        super.config(position: position, parent: parent)
        self.parent = parent
        view.physicsBody = SKPhysicsBody(texture: view.texture!, size: view.size)
        view.physicsBody?.categoryBitMask = ENEMY
        view.physicsBody?.contactTestBitMask = PLAYER_BULLET
        view.physicsBody?.collisionBitMask = 0
        configMove()
        configShoot()
    }
    
    func configMove() {
        let moveToBottomAction = SKAction.moveToBottom(position: self.position, rect: parent.frame, duration: duration)
        
        self.view.run(SKAction.sequence([moveToBottomAction, SKAction.removeFromParent()]))
    }
    
    func configShoot() -> Void{
        let shootAction = SKAction.run { 
            let enemyBulletController = EnemyBulletController()
            let startPosition = CGPoint(x: self.position.x, y: self.position.y - (self.height + enemyBulletController.height) / 2)
            enemyBulletController.config(position: startPosition, parent: self.parent)
        }
        
        let shootWithDelayAction = SKAction.sequence([shootAction, SKAction.wait(forDuration: TimeInterval(2))])
        self.view.run(SKAction.repeatForever(shootWithDelayAction))
    }
}
