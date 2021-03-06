//
//  Controller.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/12/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class Controller {
    let view: View
    var parent: SKNode!
    var shootAction: SKAction?
    var moveAction: SKAction?
    
    init(view: View) {
        self.view = view
    }
    
    func config(position: CGPoint, parent: SKNode, shootAction: SKAction?, moveAction: SKAction?) {
        self.view.position = position
        self.parent = parent
        self.shootAction = shootAction
        self.moveAction = moveAction
        parent.addChild(self.view)
    }
    
    func configExplosion(position: CGPoint, parent: SKNode, explodeAction: SKAction?) {
        self.parent = parent
        parent.addChild(self.view)
    }
    
    var width: CGFloat {
        get {
            return self.view.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.view.size.height
        }
    }
    
    var position: CGPoint {
        get {
            return self.view.position
        }
    }
}
