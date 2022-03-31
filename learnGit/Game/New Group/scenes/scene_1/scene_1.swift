//
//  scene001.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import SpriteKit
import GameplayKit

class scene_1: SKScene, SKPhysicsContactDelegate{
    
    //let node1 = SKSpriteNode(color: .yellow, size: CGSize(width: 36, height: 36))
//    let node1 = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 36, height: 36), cornerRadius: 18)
    let ball_main = SKShapeNode(circleOfRadius: sizeOfBall)
    let node2 = SKSpriteNode(color: .green, size: CGSize(width: 567, height: 36))
//    let stick = SKShapeNode(rectOf: CGSize(width: 536, height: 16))
    
    let stick = SKSpriteNode(color: .green, size: CGSize(width: 536, height: 16))
    var ball_1: SKShapeNode?
    var ball_2: SKShapeNode?
    var ball_3: SKShapeNode?
    
    
    private var num3 : SKLabelNode?
    private var san : SKSpriteNode?
    private var canh_tren : SKSpriteNode?
    private var canh_trai : SKSpriteNode?
    private var canh_phai : SKSpriteNode?
    private var canh_duoi : SKSpriteNode?
    
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
        
    }
    
    func setUpHold(){
        let lui_hold: CGFloat = 26
        let hold_top_center = ball()
        hold_top_center.position = CGPoint(x: canh_tren!.position.x, y: canh_tren!.position.y)
        addChild(hold_top_center)
        let hold_top_right = ball(circleOfRadius: sizeOfHoldGoc/2)
        hold_top_right.position = CGPoint(x: canh_phai!.position.x - lui_hold, y: canh_tren!.position.y - lui_hold)
        addChild(hold_top_right)
        let hold_botom_right = ball(circleOfRadius: sizeOfHoldGoc/2)
        hold_botom_right.position = CGPoint(x: canh_phai!.position.x - lui_hold, y: canh_duoi!.position.y + lui_hold)
        addChild(hold_botom_right)
        
        
    }
    
    private func setUpForStick(){
        stick.position = CGPoint(x: 0, y: 0)
        stick.anchorPoint = CGPoint(x: 0, y: 0.5)
        stick.position = ball_main.position
//        stick.anchorPoint = ball_main.position
        //self.addChild(stick)
    }
    
    func changePosistionStick(){
        stick.position = ball_main.position
    }
    
    override func update(_ currentTime: TimeInterval) {
        //        print(currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //MARK: sự kiện click vào màn hình
        for touch in touches {
            let location=touch.location(in: self)
            print(location.x,location.y)
            
        }
        
        
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
