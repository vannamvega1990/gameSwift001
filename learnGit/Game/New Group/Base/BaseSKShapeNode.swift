//
//  BaseSKShapeNode.swift
//  learnGit
//
//  Created by THONG TRAN on 24/03/2022.
//

import UIKit
import SpriteKit
import GameplayKit

@IBDesignable
class BaseSKSpriteNode: SKSpriteNode {
    @IBInspectable var corn111111111erRadius: CGFloat = 0 {
        didSet {
            drawBorder(color: .red, width: 1)
//            self.roundCorners(topLeft: true, topRight: true, bottomLeft: false, bottomRight: false, radius: 5,parent: self.)
        }
    }
}
