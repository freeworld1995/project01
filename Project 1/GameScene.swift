//
//  GameScene.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/5/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let player = SKSpriteNode(imageNamed: "plane3")
    let background = SKSpriteNode(imageNamed: "background")
    let playerController = PlayerController()

    let TIMER_INTERVAL: TimeInterval = 0.5
    
    struct Sound {
        static let explosion = "explosion.wav"
    }
    
    let explodeSound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        configWorld()
        addBackground()
        
        let playerPosition = CGPoint(x: self.size.width / 2 , y: playerController.height / 2)
        playerController.config(position: playerPosition, parent: self)
        
        Timer.scheduledTimer(timeInterval: TIMER_INTERVAL, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
    }
    
    //MARK: Add functions
    
    func addPlayer() {
    }
    
    func addBackground() {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
    }
    
    func addEnemy() {
        let enemyController = EnemyController()
        let enemyPositionX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 20, highestValue: Int(self.size.width))
        enemyController.config(position: CGPoint(x: enemyPositionX.nextInt(), y: Int(self.size.height)), parent: self)
    }
    
    func configWorld() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    func explosion(at ExplodePos: CGPoint) {
        let explosion = SKSpriteNode(imageNamed: "boom")
        explosion.position = ExplodePos
        explosion.zPosition = 3
        explosion.setScale(0)
        self.addChild(explosion)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let faceOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([scaleIn, faceOut, delete])
        
        explosion.run(explosionSequence)
        
    }
    
    func runGameOver() {
        let gameOverScene = GameOverScene(size: self.size)
        gameOverScene.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fade(with: UIColor.red, duration: TimeInterval(1))
        self.view?.presentScene(gameOverScene, transition: sceneTransition)
    }
    
    //MARK: Action functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PLAYER_BULLET && secondBody.categoryBitMask == ENEMY
        {
            if secondBody.node != nil {
                explosion(at: secondBody.node!.position)
                self.run(explodeSound)
            }
            
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
        
        if firstBody.categoryBitMask == PLAYER_MASK && secondBody.categoryBitMask == ENEMY_BULLET {
            runGameOver()
        }
        
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            let movementVector = CGVector(dx: location.x - previousLocation.x, dy: location.y - previousLocation.y)
            
            playerController.move(vector: movementVector)
        }
    }
    

}
