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

    let PLAYER_SPEED = 150.0
    let BULLET_SPEED = 300.0
    
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
        
        print(idealScreenSize)
    }
    
    func addPlayer() {
        let shootAction = SKAction.run(addBullet)
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
    
    func addBullet() {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bullet.position = CGPoint(x: player.position.x, y: player.position.y + (bullet.size.height + player.size.height) / 2)
        let bulletAction = SKAction.moveTo(y: self.size.height, duration: Double(self.size.height - bullet.position.y) / BULLET_SPEED)
        let bulletFinal = SKAction.sequence([bulletAction,SKAction.removeFromParent()])
        bullet.run(bulletFinal)
        self.addChild(bullet)
    }
    
    func addEnemy() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
        
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
        
        if (contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == sceneCategory) {
            if #available(iOS 9.0, *) {
                player.run(SKAction.stop())
                let contactPoint = contact.contactPoint
                print("Contact Point: \(contactPoint)")
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
