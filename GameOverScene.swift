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
        
        
    }
}
