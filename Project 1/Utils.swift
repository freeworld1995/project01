//
//  File.swift
//  Project 1
//
//  Created by Jimmy Hoang on 11/10/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import GameplayKit
import SpriteKit
import CoreGraphics

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
    }
    
    static func moveLeftToRight(position: CGPoint, rect: CGRect, duration: TimeInterval) -> SKAction {
        let dy = position.y - 120
        var destination: CGPoint
        if dy > 0 {
             destination = CGPoint(x: rect.width, y: position.y - 120)
        } else {
            destination = CGPoint(x: rect.width, y: 0)
        }
        return SKAction.move(to: destination, duration: duration)
    }
    
    static func moveRightToLeft(position: CGPoint, rect: CGRect, duration: TimeInterval) -> SKAction {
        let dy = position.y - 120
        var destination: CGPoint
        if dy > 0 {
            destination = CGPoint(x: 0, y: position.y - 120)
        } else {
            destination = CGPoint(x: 0, y: 0)
        }
        return SKAction.move(to: destination, duration: duration)

    }
    
    static func moveToPlayer(playerPos: CGPoint, enemyPos: CGPoint, rect: CGRect, duration: TimeInterval) -> SKAction {
        let dx = playerPos.x - enemyPos.x
        let dy =  playerPos.y - enemyPos.y
        
//        let dxOffset = rect.size.width - playerPos.x
//        let dyOffset = rect.size.width - playerPos.y
//        let offset = sqrt(dxOffset * dxOffset + dyOffset * dyOffset)
        
        let destination = CGPoint(x: dx, y: dy)
        return SKAction.move(to: destination, duration: duration)
    }
    
    static func moveToPath(position: CGPoint,  rect: CGRect, duration: TimeInterval) -> SKAction {
//        let path = CGMutablePath()
////        path.addCurve(to: CGPoint(x: 400, y: 568), control1: CGPoint(x: 0, y: 400), control2: CGPoint(x: 320, y: 0))
//        path.move(to: CGPoint(x: 0, y: 568))
//        path.addLines(between: [CGPoint(x: 200, y: 568), CGPoint(x: 100, y: 0)])
//        path.add
        
        let bezier = UIBezierPath(rect: CGRect(x: 70, y: -300, width: 100, height: 100))
        return SKAction.follow(bezier.cgPath, asOffset: true, orientToPath: false, duration: duration)
   
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}

extension CGFloat {
    var ConvertToInt: Int { return Int(self) }
}
