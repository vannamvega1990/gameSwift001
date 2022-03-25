//
//  ExtensionSKShapeNode.swift
//  learnGit
//
//  Created by THONG TRAN on 24/03/2022.
//

import UIKit
import SpriteKit
import GameplayKit

extension SKSpriteNode {
    func drawBorder(color: UIColor, width: CGFloat) {
//        let shapeNode = SKShapeNode(rect: frame)
        let shapeNode = SKShapeNode(circleOfRadius: frame.size.width/2)
        shapeNode.fillColor = color
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}

extension SKShapeNode {
    func roundCorners(topLeft:Bool,topRight:Bool,bottomLeft:Bool,bottomRight:Bool,radius: CGFloat,parent: SKNode){
        let newNode = SKShapeNode(rect: self.frame)
        newNode.fillColor = self.fillColor
        newNode.lineWidth = self.lineWidth
        newNode.position = self.position
        newNode.name = self.name
        self.removeFromParent()
        parent.addChild(newNode)
        var corners = UIRectCorner()
        if topLeft { corners = corners.union(.bottomLeft) }
        if topRight { corners = corners.union(.bottomRight) }
        if bottomLeft { corners = corners.union(.topLeft) }
        if bottomRight { corners = corners.union(.topRight) }
        newNode.path = UIBezierPath(roundedRect: CGRect(x: -(newNode.frame.width / 2),y:-(newNode.frame.height / 2),width: newNode.frame.width, height: newNode.frame.height),byRoundingCorners: corners, cornerRadii: CGSize(width:radius,height:radius)).cgPath
    }
}
