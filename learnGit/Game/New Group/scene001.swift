//
//  scene001.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import SpriteKit
import GameplayKit

class scene001: SKScene, SKPhysicsContactDelegate{
    
    //let node1 = SKSpriteNode(color: .yellow, size: CGSize(width: 36, height: 36))
//    let node1 = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 36, height: 36), cornerRadius: 18)
    let node1 = SKShapeNode(circleOfRadius: 26)
    let node2 = SKSpriteNode(color: .green, size: CGSize(width: 567, height: 36))
    let stick = SKShapeNode(rectOf: CGSize(width: 536, height: 116))
    
    
    private var num3 : SKLabelNode?
    private var san : SKSpriteNode?
    private var canh1 : SKSpriteNode?
    private var canh2 : SKSpriteNode?
    private var canh3 : SKSpriteNode?
    private var canh4 : SKSpriteNode?
    
    // -------- xu lý va chạm -------------
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
        switch contactMask {
        case vatThe.nhom1.rawValue | vatThe.nhom2.rawValue:
            print("va cham")
            break
        default:
            return
        }
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .white
        self.physicsWorld.contactDelegate=self // để xử lý chạm nhau
        
        self.san = self.childNode(withName: "san") as? SKSpriteNode
        if let san = self.san {
//            san.physicsBody=SKPhysicsBody(rectangleOf: san.frame.size)
//            san.physicsBody?.isDynamic=false
            san.physicsBody?.affectedByGravity = false
            san.physicsBody?.friction = 1.6
            san.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh1 = self.childNode(withName: "canh1") as? SKSpriteNode
        if let canh1 = self.canh1 {
            canh1.physicsBody=SKPhysicsBody(rectangleOf: canh1.frame.size)
            canh1.physicsBody?.isDynamic=false
            canh1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh2 = self.childNode(withName: "canh2") as? SKSpriteNode
        if let canh2 = self.canh2 {
            canh2.physicsBody=SKPhysicsBody(rectangleOf: canh2.frame.size)
            canh2.physicsBody?.isDynamic=false
            canh2.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh3 = self.childNode(withName: "canh3") as? SKSpriteNode
        if let canh3 = self.canh3 {
            canh3.physicsBody=SKPhysicsBody(rectangleOf: canh3.frame.size)
            canh3.physicsBody?.isDynamic=false
            canh3.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh4 = self.childNode(withName: "canh4") as? SKSpriteNode
        if let canh4 = self.canh4 {
            canh4.physicsBody=SKPhysicsBody(rectangleOf: canh4.frame.size)
            canh4.physicsBody?.isDynamic=false
            canh4.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        
        
        node1.position = CGPoint(x: 0, y: 60)
        self.addChild(node1)
        node1.fillColor = .yellow
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]
        let myAttrString = NSAttributedString(string: "3", attributes: myAttribute)
        self.num3 = SKLabelNode(attributedText: myAttrString)
        if let num3 = num3 {
            node1.addChild(num3)
        }
//        node1.physicsBody=SKPhysicsBody(rectangleOf: node1.size)
//        node1.physicsBody=SKPhysicsBody(circleOfRadius: node1.frame.size.width/2)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 26)
        node1.physicsBody!.mass = 0.6
        node1.physicsBody!.affectedByGravity = false
        node1.physicsBody?.friction = 1.6
//        node1.physicsBody?.isDynamic=false// if false thì ko rơi xuống
//        node1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue // tạo nhóm cho note1 để xử lý chạm nhau
        
        node2.position = CGPoint(x: 0, y: 0)
        self.addChild(node2)
        node2.physicsBody=SKPhysicsBody(rectangleOf: node2.size)
        node2.physicsBody?.isDynamic=true
        node2.physicsBody?.contactTestBitMask=vatThe.nhom2.rawValue
        
        let node1 = SKShapeNode(circleOfRadius: 20)
                node1.physicsBody = SKPhysicsBody(circleOfRadius: 20)
                node1.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)

                let node2 = SKShapeNode(circleOfRadius: 2)
                node2.physicsBody = SKPhysicsBody(circleOfRadius: 1)
                node2.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0+19)
                node2.physicsBody!.mass = node1.physicsBody!.mass * 0.2 //Set body2 mass as a ratio of body1 mass.

                self.addChild(node1)
                self.addChild(node2)

        let joint = SKPhysicsJointFixed.joint(withBodyA: node1.physicsBody!, bodyB: node2.physicsBody!, anchor: node1.position)

        self.physicsWorld.add(joint)

        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                node1.physicsBody!.applyImpulse(CGVector(dx: -10, dy: 0))
        setUpForStick()
            
    }
    
    private func setUpForStick(){
        stick.fillColor = .red
        stick.position = CGPoint(x: 0, y: 0)
        stick.zRotation = CGFloat.pi / 3
    }
    
    override func update(_ currentTime: TimeInterval) {
        //        print(currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //MARK: sự kiện click vào màn hình
        for touch in touches {
            let location=touch.location(in: self)
            print(location.x,location.y)
            //self.note1.position=location
            
            // Di chuyển note1 theo vị trí click
            //MARK: Tạo vecter để di chuyển note, vector có hướng và độ lớn làm cho bay nhanh hay chậm
            
//            node1.physicsBody?.velocity=CGVector(dx: 120, dy: 526)
            node1.physicsBody?.applyImpulse(CGVector(dx: 96, dy: -176))
            //node1.physicsBody?.applyImpulse(CGVector(dx: location.x, dy: location.y))
        }
        
        
    }
}

