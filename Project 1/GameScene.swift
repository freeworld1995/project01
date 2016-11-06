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
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    let player = SKSpriteNode(imageNamed: "plane3")
    let background = SKSpriteNode(imageNamed: "background")
    let enemiesName = ["enemy1", "enemy2", "enemy3"]
    

    let PLAYER_SPEED = 150.0
    let BULLET_SPEED: TimeInterval = 2
    let ENEMY_SPEED: TimeInterval = 2.7
    let TIMER_INTERVAL: TimeInterval = 0.3
    
    let playerCategory: UInt32 = 0x1 << 1
    let sceneCategory: UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {
        let idealScreenSize = CGRect(x: -(player.size.width / 2), y: 0, width: self.frame.width + player.size.width, height: self.frame.height)
        let sceneBody = SKPhysicsBody(edgeLoopFrom: idealScreenSize)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = sceneCategory
        self.physicsBody?.contactTestBitMask = playerCategory
        addBackground()
        addPlayer()
        Timer.scheduledTimer(timeInterval: TIMER_INTERVAL, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        print(self.size.height)
    }
    
    //MARK: Add functions
    
    func addPlayer() {
        let shootAction = SKAction.run ({
            self.addBullet(bulletImage: "bullet", parentSprite: self.player, reverseDirection: 1)
        }) // closure
        
        let shootActionWithDelay = SKAction.sequence([shootAction, SKAction.wait(forDuration: 0.3)])
        let shootActionForever = SKAction.repeatForever(shootActionWithDelay)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = sceneCategory
        player.physicsBody?.allowsRotation = false
        player.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        player.position = CGPoint(x: self.size.width / 2, y: player.size.height / 2)
        player.run(shootActionForever)
        
        self.addChild(player)

    }
    
    func addBackground() {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        self.addChild(background)
    }
    
    func addBullet(bulletImage: String, parentSprite: SKSpriteNode, reverseDirection: CGFloat) {
        let bullet = SKSpriteNode(imageNamed: bulletImage)
        bullet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bullet.position = CGPoint(x: parentSprite.position.x, y: parentSprite.position.y + (bullet.size.height + player.size.height) / 2 * reverseDirection)
        let bulletMoveForward = SKAction.moveTo(y: self.size.height * reverseDirection, duration: BULLET_SPEED)

        let bulletFinal = SKAction.sequence([bulletMoveForward,SKAction.removeFromParent()])
        bullet.run(bulletFinal)
        self.addChild(bullet)
    }
    
    func addEnemy() {
        if #available(iOS 9.0, *) {
            let enemiesSpriteDistribution = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 0, highestValue: enemiesName.count - 1)
            
            let enemy = SKSpriteNode(imageNamed: enemiesName[enemiesSpriteDistribution.nextInt()])
            enemy.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let enemyPosition = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 20, highestValue: 568)
            enemy.position = CGPoint(x: enemyPosition.nextInt(), y: 568)
            let enemyMoveForwardAC = SKAction.moveTo(y: -(self.size.height), duration: ENEMY_SPEED)
            let enemyFinalAC = SKAction.sequence([enemyMoveForwardAC, SKAction.removeFromParent()])
            enemy.run(enemyFinalAC)
            
            let shootAction = SKAction.run ({
                self.addBullet(bulletImage: "enemy_bullet", parentSprite: enemy, reverseDirection: -1)
            })
            let shootActionWithDelay = SKAction.sequence([shootAction, SKAction.wait(forDuration: 0.8)])
            let shootActionForever = SKAction.repeatForever(shootActionWithDelay)
            enemy.run(shootActionForever)
            self.addChild(enemy)
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: Action functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == sceneCategory) {
            if #available(iOS 9.0, *) {
                player.run(SKAction.stop())
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            let vector = CGVector(dx: touchPoint.x - previousPosition.x, dy: touchPoint.y - previousPosition.y)
            
            let dx = touchPoint.x - player.position.x
            let dy = touchPoint.y - player.position.y
            let distance = sqrt(dx * dx + dy * dy)
            let time = Double(distance) / PLAYER_SPEED
            player.run(SKAction.move(by: vector, duration: 0.5))
//            SKAction.move(to: touchPoint, duration: time)
//            SKAction.move(by: vector, duration: <#T##TimeInterval#>)
//            player.run(SKAction.rotate(byAngle: CGFloat(M_PI*2), duration: 2))
            
        }

    }
    

}
