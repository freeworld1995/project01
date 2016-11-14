//
//  GameOverScene.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(color: SKColor.black, size: self.size)
        background.size = self.size
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2 , y: self.size.height / 2)
        self.addChild(background)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Sunset")
        gameOverLabel.fontSize = 60
        gameOverLabel.text = "Game Over"
        gameOverLabel.color = UIColor.yellow
        gameOverLabel.zPosition = 1
        gameOverLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.85)
        self.addChild(gameOverLabel)
        
        let fuckImage = SKSpriteNode(imageNamed: "fuck")
        fuckImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        fuckImage.setScale(0.7)
        fuckImage.zPosition = 1
        self.addChild(fuckImage)
        
        let replay = SKLabelNode(fontNamed: "Sunset")
        replay.name = "replay"
        replay.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.20)
        replay.fontSize = 40
        replay.text = "Replay ?"
        replay.color = SKColor.yellow
        replay.zPosition = 1
        self.addChild(replay)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let touchPos = touch.location(in: self)
            let tappedNode = atPoint(touchPos)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "replay" {
                tappedNode.alpha = 0.5
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.doorsOpenVertical(withDuration: 0.4)
                self.view?.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
        }
    }
}
