////
////  GameScene.swift
////  Game1
////
////  Created by tran thong on 12/2/19.
////  Copyright © 2019 petter. All rights reserved.
////
//
//
////MARK: vide dướng dẫn : https://youtu.be/i27IYu8AuYI?list=PLzrVYRai0riTVD1_rsoqhXZJg3hnxQW89
//
//import SpriteKit
//import GameplayKit
//
//class GameScene: SKScene, SKPhysicsContactDelegate {
//    
//    //SKPhysicsContactDelegate để xử lý chạm nhau giữa các node
//    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    
//    var note1:SKSpriteNode!
//    var note3:SKSpriteNode!
//    var nenDat:SKSpriteNode!
//    
//    
//    // Tạo nhóm để xử lý chạm nhau giữa các
//    enum vatThe:UInt32{
//        case nhom1=1
//        case nhom2=2
//    }
//    
//    override func didMove(to view: SKView) {
//        
//        self.physicsWorld.contactDelegate=self // để xử lý chạm nhau
//        
//        
//        note1=SKSpriteNode(imageNamed: "bird.png")
//        note1.size=CGSize(width: 100, height: 100)
//        note1.position=CGPoint(x: 0, y: 0)
//        self.addChild(note1)
//        
//        nenDat=SKSpriteNode(color: .red, size: CGSize(width: self.frame.width, height: 50))
//        nenDat.position=CGPoint(x: 0, y: -self.frame.height/2)
//        self.addChild(nenDat)
//        
//        note3=SKSpriteNode(imageNamed: "bird1.jpeg")
//        note3.size=CGSize(width: 100, height: 100)
//        note3.position=CGPoint(x: note1.position.x - 300, y: note1.position.y)
//        self.addChild(note3)
//        
//        // Tạo lực hút
//        // Tao khung để bao nhân vật, có 3 loại khung: khung chử nhật, tròn, hình hỗn hợp.Rồi add lực hút cho note
//        note1.physicsBody=SKPhysicsBody(rectangleOf: note1.size)
//        note1.physicsBody?.isDynamic=true// if false thì ko rơi xuống
//        note1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue // tạo nhóm cho note1 để xử lý chạm nhau
//        
//        nenDat.physicsBody=SKPhysicsBody(rectangleOf: nenDat.size)
//        nenDat.physicsBody?.isDynamic=false
//        
//        note3.physicsBody=SKPhysicsBody(rectangleOf: note3.size)
//        note3.physicsBody?.contactTestBitMask=vatThe.nhom2.rawValue
//        
//    }
//    
//    //MARK: delegate xử lý chạm nhau giữa các node
//    
//    func didBegin(_ contact: SKPhysicsContact) {
//        let contactMask = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
//        switch contactMask {
//        case vatThe.nhom1.rawValue | vatThe.nhom2.rawValue:
//            
//            //MARK: tạo âm thanh
//            var no = SKAction.playSoundFileNamed("gun.mp3", waitForCompletion: true)
//            self.run(no)
//            //MARK: xoá node
//            note3.removeFromParent()
//            //MARK: chuyển sang màn hình khác
//            let mh3=manHinh3(size: self.size)
//            mh3.scaleMode = scaleMode
//            //tạo hiệu ứng di chuyển màn hình
//            let reveal = SKTransition.fade(withDuration: 3)
//            self.view?.presentScene(mh3, transition: reveal)
//        default:
//            return
//        }
//    }
//    
//    
//    //    func touchDown(atPoint pos : CGPoint) {
//    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//    //            n.position = pos
//    //            n.strokeColor = SKColor.green
//    //            self.addChild(n)
//    //        }
//    //    }
//    //
//    //    func touchMoved(toPoint pos : CGPoint) {
//    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//    //            n.position = pos
//    //            n.strokeColor = SKColor.blue
//    //            self.addChild(n)
//    //        }
//    //    }
//    //
//    //    func touchUp(atPoint pos : CGPoint) {
//    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//    //            n.position = pos
//    //            n.strokeColor = SKColor.red
//    //            self.addChild(n)
//    //        }
//    //    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        //MARK: sự kiện click vào màn hình
//        
//        for touch in touches {
//            let location=touch.location(in: self)
//            print(location.x,location.y)
//            //self.note1.position=location
//            
//            // Di chuyển note1 theo vị trí click
//            
//            //MARK: Tạo vecter để di chuyển note, vector có hướng và độ lớn làm cho bay nhanh hay chậm
//            
//            
//            note1.physicsBody?.velocity=CGVector(dx: 0, dy: 0)
//            note1.physicsBody?.applyImpulse(CGVector(dx: location.x, dy: location.y))
//        }
//        
//        
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
//    
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
//}
//
