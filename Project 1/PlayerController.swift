//
//  PlayerController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class PlayerController: Controller {
    
    var HP = 5
    
    init() {
        super.init(view: View(texture: PLAYER_TEXTURE))
    }
    
    override func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        super.config(position: position, parent: parent, shootAction: shootAction, moveAction: moveAction)
        self.parent = parent
        view.physicsBody = SKPhysicsBody(rectangleOf: view.size)
        view.physicsBody?.categoryBitMask = PLAYER_MASK
        view.physicsBody?.contactTestBitMask = ENEMY_BULLET | HEART
        view.physicsBody?.collisionBitMask = 0
        view.handleContact = { otherView in
            
            if otherView.physicsBody?.categoryBitMask == HEART {
                otherView.physicsBody?.categoryBitMask = 0
                if self.HP < 5 {
                    self.HP += 1
                    print("heal: \(self.HP)")
                } else {
                    self.HP = 5
                    print("heal: \(self.HP)")
                }
            }
            else if otherView.name == "enemy_bullet"  {
                self.HP -= 1
                print("damage: \(self.HP)")
                if self.HP <= 0 {
                    let gameOverScene = GameOverScene(size: parent.frame.size)
                    gameOverScene.scaleMode = parent.scene!.scaleMode
                    let sceneTransition = SKTransition.fade(with: UIColor.red, duration: TimeInterval(1))
                    parent.scene!.view!.presentScene(gameOverScene, transition: sceneTransition)
                }
            }
        }
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
