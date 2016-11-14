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

    let SPAWN_INTERVAL: TimeInterval = 1
    
    var addEnemyArray: [() -> ()] = []
    
    struct Sound {
        static let explosion = "explosion.wav"
    }
    
    let explodeSound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        configWorld()
        addBackground()
        
        let playerPosition = CGPoint(x: self.size.width / 2 , y: playerController.height / 2)
        playerController.config(position: playerPosition, parent: self, shootAction: nil, moveAction: nil)
//        playerController.view.run(SKAction.moveRightToLeft(position: playerPosition, rect: self.frame, duration: 3))
        addEnemyArray.append(addTopToBottomEnemy)
        addEnemyArray.append(addLeftToRightEnemy)
        addEnemyArray.append(addRightToLeftEnemy)
 
        Timer.scheduledTimer(timeInterval: SPAWN_INTERVAL, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
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
        // Randomly run 1 in 3 addEnemy functions
        addEnemyArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: addEnemyArray) as! [() -> ()]
        addEnemyArray[0]()
    }
    
    func addTopToBottomEnemy(){
        let enemyController = EnemyController()
        let enemyPositionX = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 20, highestValue: Int(self.size.width))
        let enemyPosition = CGPoint(x: enemyPositionX.nextInt(), y: self.size.height.ConvertToInt)
        let moveAction = SKAction.moveToBottom(position: enemyPosition, rect: self.frame, duration: 2.5)
        let shootAction = SKAction.moveToBottom(position: enemyPosition, rect: self.frame, duration: 2.3)
        enemyController.config(position: enemyPosition, parent: self, shootAction: shootAction, moveAction: moveAction)
    }
    
    func addLeftToRightEnemy(){
        let enemyController = EnemyController()
        let enemyPositionY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: Int(self.size.height * 0.30), highestValue: Int(self.size.height))
        let enemyPosY = enemyPositionY.nextInt()
        
        let moveAction = SKAction.moveLeftToRight(position: CGPoint(x: 0, y: enemyPosY), rect: self.frame, duration: 2.5)
        let shootAction = SKAction.moveToPlayer(playerPos: playerController.position, enemyPos: enemyController.position, rect: self.frame, duration: 2.3)
        enemyController.config(position: CGPoint(x: 0, y: enemyPosY), parent: self, shootAction: shootAction, moveAction: moveAction)
        enemyController.view.zRotation = CGFloat(40.degreesToRadians)
        
        print(playerController.position)
    }
    
    func addRightToLeftEnemy() {
        let enemyController = EnemyController()
        let enemyPositionY = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: Int(self.size.height * 0.30), highestValue: Int(self.size.height))
        let enemyPosY = enemyPositionY.nextInt()
        let enemyPosition = CGPoint(x: self.size.width.ConvertToInt, y: enemyPosY)
        let moveAction = SKAction.moveRightToLeft(position: enemyPosition, rect: self.frame, duration: 2.5)
        let shootAction = SKAction.moveToPlayer(playerPos: playerController.position, enemyPos: enemyController.position, rect: self.frame, duration: 2.3)
        enemyController.config(position: enemyPosition, parent: self, shootAction: shootAction, moveAction: moveAction)
        enemyController.view.zRotation = CGFloat(-40.degreesToRadians)

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

    override func update(_ currentTime: TimeInterval) {

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
