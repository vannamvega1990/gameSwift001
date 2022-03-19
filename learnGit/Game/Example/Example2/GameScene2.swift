//
//  GameScene2.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import SpriteKit
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate{
    
    let node1 = SKSpriteNode(color: .red, size: CGSize(width: 36, height: 36))
    let node2 = SKSpriteNode(color: .green, size: CGSize(width: 567, height: 36))
    
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
        
        node1.position = CGPoint(x: 0, y: 0)
        self.addChild(node1)
        node1.physicsBody=SKPhysicsBody(rectangleOf: node1.size)
        node1.physicsBody?.isDynamic=true// if false thì ko rơi xuống
        node1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue // tạo nhóm cho note1 để xử lý chạm nhau
        
        node2.position = CGPoint(x: 0, y: -190)
        self.addChild(node2)
        node2.physicsBody=SKPhysicsBody(rectangleOf: node2.size)
        node2.physicsBody?.isDynamic=false
        node2.physicsBody?.contactTestBitMask=vatThe.nhom2.rawValue
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
            
            node1.physicsBody?.velocity=CGVector(dx: 120, dy: 0)
            //node1.physicsBody?.applyImpulse(CGVector(dx: location.x, dy: location.y))
        }
        
        
    }
}
