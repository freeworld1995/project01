//
//  ExplosionController.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/19/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import SpriteKit

class ExplosionController: Controller {
    init() {
        super.init(view: View(imageNamed: "boom"))
    }
    
    override func configExplosion(position: CGPoint, parent: SKNode, explodeAction: SKAction?) {
        super.configExplosion(position: position, parent: parent, explodeAction: explodeAction)
        
        view.position = position
        view.zPosition = 3
        view.setScale(0)
        
        let scaleIn = SKAction.scale(to: 1, duration: 0.1)
        let faceOut = SKAction.fadeOut(withDuration: 0.1)
        let delete = SKAction.removeFromParent()
        
        let explosionSequence = SKAction.sequence([scaleIn, faceOut, delete])
        
        view.run(explosionSequence)

    }
}
