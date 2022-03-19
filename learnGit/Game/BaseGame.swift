//
//  BaseGame.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import Foundation
import SpriteKit
import GameplayKit

extension SKScene {
    
}

enum vatThe:UInt32{
    case nhom1=1
    case nhom2=2
}

class BaseGame: SKScene {
    func createNodeColor(){
        let node1 = SKSpriteNode(color: .red, size: CGSize(width: 98, height: 98))
        node1.position = CGPoint(x: 0, y: 0)
        //self.addChild(node1)
    }
    func createNodeImage(){
        let note1=SKSpriteNode(imageNamed: "bird.png")
        note1.size=CGSize(width: 100, height: 100)
        note1.position=CGPoint(x: 0, y: 0)
        //self.addChild(note1)
    }
    func testTaoLucHut(){
        // Tạo lực hút
        // Tao khung để bao nhân vật, có 3 loại khung: khung chử nhật, tròn, hình hỗn hợp.Rồi add lực hút cho note
        let note1=SKSpriteNode(imageNamed: "bird.png")
        note1.physicsBody=SKPhysicsBody(rectangleOf: note1.size)
        note1.physicsBody?.isDynamic=true// if false thì ko rơi xuống
        note1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue // tạo nhóm cho note1 để xử lý chạm nhau
    }
    // play Sound ---------
    func playSound(){
        //MARK: tạo âm thanh
        let no = SKAction.playSoundFileNamed("gun.mp3", waitForCompletion: true)
        self.run(no)
    }
    
    // remove Node ---------
    func removeNode(){
        //MARK: xoá node
        let node1=SKSpriteNode(imageNamed: "bird.png")
        node1.removeFromParent()
    }
    
    func moveToNewScene(){
        //MARK: chuyển sang màn hình khác
        //let mh3=manHinh3(size: self.size)
        let mh3=SKScene()
        mh3.scaleMode = scaleMode
        //tạo hiệu ứng di chuyển màn hình
        let reveal = SKTransition.fade(withDuration: 3)
        self.view?.presentScene(mh3, transition: reveal)
    }
    
    func diChuyenDeu(){
        let node1=SKSpriteNode(imageNamed: "bird.png")
        node1.physicsBody?.velocity=CGVector(dx: 120, dy: 0)
    }
    func taoLucDay(){
        let node1=SKSpriteNode(imageNamed: "bird.png")
        node1.physicsBody?.applyImpulse(CGVector(dx: 6, dy: 6))
    }
}
