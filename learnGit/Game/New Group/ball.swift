//
//  ball.swift
//  learnGit
//
//  Created by THONG TRAN on 25/03/2022.
//

import SpriteKit
import GameplayKit

class ball: SKShapeNode {
    
//    override init() {
//        super.init()
//    }
//
//    convenience init(width: CGFloat, point: CGPoint) {
//        self.init()
//        self.init(circleOfRadius: width/2)
//        // Do stuff
//    }
    
        init(circleOfRadius: CGFloat = sizeOfBall / 2 , numberString: String, color: UIColor){
    
            super.init()
            self.fillColor = color
            let diameter = circleOfRadius * 2
            self.path = CGPath(ellipseIn: CGRect(origin: CGPoint(x: -diameter/2, y: -diameter/2), size: CGSize(width: diameter, height: diameter)), transform: nil)
    
            let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.black ,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)]
            let myAttrString = NSAttributedString(string: numberString, attributes: myAttribute)
            let num = SKLabelNode(attributedText: myAttrString)
            
            let ball_main = SKShapeNode(circleOfRadius: sizeOfBall / 4)
            ball_main.fillColor = .white
            addChild(ball_main)
            addChild(num)
            num.position = CGPoint(x: 0, y: -num.frame.size.height/2)
            //num.position = CGPoint(x: 0, y: 0)
            physicsBody = SKPhysicsBody(circleOfRadius: circleOfRadius)
            physicsBody?.isDynamic = true
            physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
            physicsBody!.mass = 0.6
            physicsBody!.affectedByGravity = false
            physicsBody?.friction = 1.6
    
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
