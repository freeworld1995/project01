//
//  GameDifficult.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/6/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import Foundation

class GameDifficult {
    let enemySpeed: Int
    let lives: Int
    let health: Int
    
    init(enemySpeed: Int, lives: Int, health: Int) {
        self.enemySpeed = enemySpeed
        self.lives = lives
        self.health = health
    }
}
