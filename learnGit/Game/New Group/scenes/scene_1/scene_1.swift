//
//  scene001.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import SpriteKit
import GameplayKit

class scene_1: SKScene, SKPhysicsContactDelegate{
    
    var ball_main, ball_8, table, table_body: SKSpriteNode!
    var ball_1, ball_2, ball_3, ball_4, ball_5, ball_6, ball_7: SKSpriteNode!
    var ball_9, ball_10, ball_11, ball_12, ball_13, ball_14, ball_15: SKSpriteNode!
    
    var ball_array: [SKSpriteNode] = [SKSpriteNode]()
    
    
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
    
    override func didMove(to view: SKView)
    {
        getObjects(callbak: {
//            self.ball_array.append(contentsOf: [self.ball_main, self.ball_1, self.ball_2, self.ball_3, self.ball_4, self.ball_5 , self.ball_6, self.ball_7, self.ball_8, self.ball_9,self.ball_10 , self.ball_11, self.ball_12, self.ball_13, self.ball_14, self.ball_15])
//            for (key,each) in self.ball_array.enumerated() {
//                each.physicsBody = SKPhysicsBody(circleOfRadius: each.frame.size.width / 2)
//                let img_name = "ball_" + "\(key)"
//                
//                let image = UIImage(named: img_name)
//                 let texture = SKTexture(image: image!)
//                //let player = texture
//                each.texture = texture
//                each.physicsBody!.mass = 0.03
//                each.physicsBody!.allowsRotation =  false
//                each.physicsBody!.affectedByGravity = false
//                each.physicsBody?.friction = 5.9
//                
//            }
        })
    }
    
    func getObjects(callbak:@escaping ()->Void){
        ball_main = self.childNode(withName: "ball_0") as? SKSpriteNode
        table = self.childNode(withName: "table") as? SKSpriteNode
        ball_1 = self.childNode(withName: "ball_1") as? SKSpriteNode
        ball_2 = self.childNode(withName: "ball_2") as? SKSpriteNode
        ball_3 = self.childNode(withName: "ball_3") as? SKSpriteNode
        ball_4 = self.childNode(withName: "ball_4") as? SKSpriteNode
        ball_5 = self.childNode(withName: "ball_5") as? SKSpriteNode
        ball_6 = self.childNode(withName: "ball_6") as? SKSpriteNode
        ball_7 = self.childNode(withName: "ball_7") as? SKSpriteNode
        ball_8 = self.childNode(withName: "ball_8") as? SKSpriteNode
        ball_9 = self.childNode(withName: "ball_9") as? SKSpriteNode
        ball_10 = self.childNode(withName: "ball_10") as? SKSpriteNode
        ball_11 = self.childNode(withName: "ball_11") as? SKSpriteNode
        ball_12 = self.childNode(withName: "ball_12") as? SKSpriteNode
        ball_13 = self.childNode(withName: "ball_13") as? SKSpriteNode
        ball_14 = self.childNode(withName: "ball_14") as? SKSpriteNode
        ball_15 = self.childNode(withName: "ball_15") as? SKSpriteNode
        callbak()
        table_body = self.childNode(withName: "table_body") as? SKSpriteNode
        table_body.physicsBody = SKPhysicsBody(texture: table_body.texture!, size: table_body.frame.size)
        table_body.physicsBody?.isDynamic = false
        
    }
    
    func setUpHold(){
        
        
    }
    
    private func setUpForStick(){
        
    }
    
    func changePosistionStick(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //        print(currentTime)
        if checkAllNodeIsStanding() {
            print("------all node is standing")
        }else{
            print("------have a node is moving")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //MARK: sự kiện click vào màn hình
        for touch in touches {
            let location=touch.location(in: self)
            print(location.x,location.y)
            let dx = location.x - ball_main!.position.x
            let dy = location.y - ball_main!.position.y
            //ball_1!.physicsBody?.applyImpulse(CGVector(dx: -526, dy: 60))
            ball_main!.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
            
        }
        
        
    }
}


extension scene_1 {
    func checkAllNodeIsStanding() -> Bool{
        var flagStanding: Bool = true
        for node in ball_array {
            if node.physicsBody!.velocity.dx != 0 && node.physicsBody!.velocity.dy != 0 {
                flagStanding = false
                break
            }
        }
        return flagStanding
    }
}



//override func viewDidLoad() {
//    super.viewDidLoad()
//    let viewVoice = UIView()
//    viewVoice.frame = CGRect(x: 200, y: 200, width: 60, height: 60)
//    viewVoice.backgroundColor = UIColor.red
//    self.view.addSubview(viewVoice)
//    let imgVoice = UIImageView()
//    viewVoice.addSubview(imgVoice)
//    imgVoice.frame = viewVoice.bounds
//    imgVoice.image = UIImage()
//    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
//    viewVoice.addGestureRecognizer(panGesture)
//
//}
//
//@objc func pan(_ pan: UIPanGestureRecognizer) {
//
//    if pan.state == .began || pan.state == .changed {
//
//        let translation = pan.translation(in: self.view)
//        // note: 'view' is optional and need to be unwrapped
//        pan.view!.center = CGPoint(x: pan.view!.center.x + translation.x, y: pan.view!.center.y + translation.y)
//        pan.setTranslation(CGPoint.zero, in: self.view)
//
//        print("=============")
//    }
//}
