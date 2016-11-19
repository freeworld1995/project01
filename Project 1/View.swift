//
//  View.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/18/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

typealias HandleContactType = (View) -> ()

class View: SKSpriteNode {
    var handleContact: HandleContactType!
}
