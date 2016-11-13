//
//  File.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/10/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint {
    func add(other: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + other.x, y: self.y + other.y)
    }
    
    func add(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
    func add(vector: CGVector) -> CGPoint{
        return CGPoint(x: self.x + vector.dx, y: self.y + vector.dy)
    }
    
    func distance(other: CGPoint) -> CGFloat {
        let dx = self.x - other.x
        let dy = self.y - other.y
        return CGFloat(sqrt(dx * dx + dy * dy))
    }
}

extension SKAction {
    
    static func moveToTop(position: CGPoint, rect: CGRect, duration: TimeInterval) -> SKAction {
        return SKAction.moveTo(y: rect.height, duration: duration)
    }
    
    static func moveToBottom(position: CGPoint,  rect: CGRect, duration: TimeInterval) -> SKAction {
        return SKAction.moveTo(y: 0, duration: duration)
    }}
