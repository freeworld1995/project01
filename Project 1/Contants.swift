//
//  Contants.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/10/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

let WALL = UInt32(1 << 0)
let PLAYER_MASK = UInt32(1 << 1)
let PLAYER_BULLET = UInt32(1 << 2)
let ENEMY = UInt32(1 << 3)
let ENEMY_BULLET = UInt32(1 << 4)

let PLAYER_BULLET_TEXTURE = SKTexture(imageNamed: "bullet")
let ENEMY_BULLET_TEXTURE = SKTexture(imageNamed: "enemy_bullet")
let PLAYER_TEXTURE = SKTexture(imageNamed: "plane3")
var ENEMY_TEXTURE = [enemy1, enemy2, enemy3]

let enemy1 = SKTexture(imageNamed: "enemy1")
let enemy2 = SKTexture(imageNamed: "enemy2")
let enemy3 = SKTexture(imageNamed: "enemy3")
