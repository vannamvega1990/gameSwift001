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
        self.canh_tren = self.childNode(withName: "canh_tren") as? SKSpriteNode
        if let canh_tren = self.canh_tren {
            //canh_tren.physicsBody=SKPhysicsBody(rectangleOf: canh_tren.frame.size)
            canh_tren.physicsBody?.isDynamic=false
            canh_tren.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh_trai = self.childNode(withName: "canh_trai") as? SKSpriteNode
        if let canh2 = self.canh_trai {
            canh2.physicsBody=SKPhysicsBody(rectangleOf: canh2.frame.size)
            canh2.physicsBody?.isDynamic=false
            canh2.color = .clear
            canh2.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh_phai = self.childNode(withName: "canh_phai") as? SKSpriteNode
        if let canh_phai = self.canh_phai {
            //canh_phai.physicsBody=SKPhysicsBody(rectangleOf: canh_phai.frame.size)
            canh_phai.color = .clear
            canh_phai.physicsBody?.isDynamic=false
            canh_phai.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        self.canh_duoi = self.childNode(withName: "canh_duoi") as? SKSpriteNode
        if let canh4 = self.canh_duoi {
            canh4.physicsBody=SKPhysicsBody(rectangleOf: canh4.frame.size)
            canh4.physicsBody?.isDynamic=false
            canh4.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        }
        
        let image = UIImage(named: "Subtract")
             let texture = SKTexture(image: image!)
            let player = SKSpriteNode(texture: texture)
        player.scale(to: CGSize(width: 667, height: 267))
        player.physicsBody = SKPhysicsBody(texture: player.texture!,
                                           size: player.frame.size)
        //player.physicsBody = SKPhysicsBody(edgeLoopFrom: player.frame)
        
        player.physicsBody?.isDynamic = false
             player.position = CGPoint(x: 0, y: 0)
             // 4
             addChild(player)
        
        ball_1 = ball(numberString: "1", color: .red)
        ball_1!.position = CGPoint(x: 190, y: 0)
        self.addChild(ball_1!)
        ball_2 = ball(numberString: "2", color: .orange)
        ball_2!.position = CGPoint(x: 90, y: 0)
        self.addChild(ball_2!)
        ball_3 = ball(numberString: "3", color: .green)
        ball_3!.position = CGPoint(x: 110, y: 0)
        self.addChild(ball_3!)
//        ball_main.fillColor = .yellow
//        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ,
//                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 46)]
//        let myAttrString = NSAttributedString(string: "3", attributes: myAttribute)
//        self.num3 = SKLabelNode(attributedText: myAttrString)
//        if let num3 = num3 {
//            ball_main.addChild(num3)
//            num3.position = CGPoint(x: 0, y: -num3.frame.size.height/2)
//        }
//        node1.physicsBody=SKPhysicsBody(rectangleOf: node1.size)
//        node1.physicsBody=SKPhysicsBody(circleOfRadius: node1.frame.size.width/2)
//        ball_main.physicsBody = SKPhysicsBody(circleOfRadius: 6*sizeOfBall / 2)
//        ball_main.physicsBody?.isDynamic = true
//        ball_main.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
//        ball_main.physicsBody!.mass = 0.6
//        ball_main.physicsBody!.affectedByGravity = false
//        ball_main.physicsBody?.friction = 1.6
//        node1.physicsBody?.isDynamic=false// if false thì ko rơi xuống
//        node1.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue // tạo nhóm cho note1 để xử lý chạm nhau
        
//        node2.position = CGPoint(x: 0, y: 0)
//        self.addChild(node2)
//        node2.physicsBody=SKPhysicsBody(rectangleOf: node2.size)
//        node2.physicsBody?.isDynamic=true
//        node2.physicsBody?.contactTestBitMask=vatThe.nhom2.rawValue
//
//        let node1 = SKShapeNode(circleOfRadius: 20)
//                node1.physicsBody = SKPhysicsBody(circleOfRadius: 20)
//                node1.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
//
//                let node2 = SKShapeNode(circleOfRadius: 2)
//                node2.physicsBody = SKPhysicsBody(circleOfRadius: 1)
//                node2.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0+19)
//                node2.physicsBody!.mass = node1.physicsBody!.mass * 0.2 //Set body2 mass as a ratio of body1 mass.
//
//                self.addChild(node1)
//                self.addChild(node2)
//
//        let joint = SKPhysicsJointFixed.joint(withBodyA: node1.physicsBody!, bodyB: node2.physicsBody!, anchor: node1.position)
//
//        self.physicsWorld.add(joint)

       // self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                //node1.physicsBody!.applyImpulse(CGVector(dx: -10, dy: 0))
        setUpForStick()
        
        //let noidung = SKShapeNode(rectOf: size)
        
        let path_phai = UIBezierPath()
        path_phai.move(to: CGPoint(x: canh_phai!.position.x - canh_phai!.size.width/2, y: -canh_phai!.size.height/2 + ngatGoc))
        path_phai.addLine(to: CGPoint(x: path_phai.currentPoint.x, y: canh_phai!.size.height/2 - ngatGoc))
        path_phai.addLine(to: CGPoint(x: path_phai.currentPoint.x + canh_phai!.size.width, y: path_phai.currentPoint.y + canh_phai!.size.width))
        path_phai.addLine(to: CGPoint(x: path_phai.currentPoint.x, y: -canh_phai!.size.height/2))
        path_phai.close()
        
        let path_tren = UIBezierPath()
        path_tren.move(to: CGPoint(x: canh_phai!.position.x - canh_phai!.size.width/2 - ngatGoc, y: canh_tren!.position.y  - canh_tren!.size.height/2))
        path_tren.addLine(to: CGPoint(x: path_tren.currentPoint.x + canh_tren!.size.height, y: path_tren.currentPoint.y + canh_tren!.size.height))
        path_tren.addLine(to: CGPoint(x: -canh_tren!.size.width/2, y: path_tren.currentPoint.y))
        path_tren.addLine(to: CGPoint(x: path_tren.currentPoint.x, y: path_tren.currentPoint.y - canh_tren!.size.height))
        path_tren.close()
       
        
        //path.addArc(withCenter: CGPoint(x: 0, y: path.currentPoint.y), radius: sizeOHold/2, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        //path.addLine(to: CGPoint(x: canh4!.position.x + canh4!.size.width/2, y: path.currentPoint.y))
        // segment 2: curve
//            path.addCurve(to: CGPoint(x: 0, y: 12), // ending point
//                controlPoint1: CGPoint(x: 2, y: 14),
//                controlPoint2: CGPoint(x: 0, y: 14))

            // segment 3: line
//            path.addLine(to: CGPoint(x: 160, y: 0))
        //path.addLine(to: CGPoint(x: 0, y: 0))
        
        let pathBao = UIBezierPath(roundedRect: CGRect(x: -san!.size.width/2, y: -san!.size.height/2, width: san!.size.width, height: san!.size.height), cornerRadius: 0)
        pathBao.append(path_phai)
        pathBao.usesEvenOddFillRule = true
        let path1 = path_phai.cgPath
        let noidung = SKShapeNode(path: path1)
        
        noidung.fillColor = .orange
        noidung.strokeColor = .green
        noidung.lineWidth = 1
        //noidung.physicsBody = SKPhysicsBody(
        noidung.position = CGPoint.zero
        //addChild(noidung)
        
        let shape_phai = SKShapeNode()
        //shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
        shape_phai.path = path1
//        shape.physicsBody = SKPhysicsBody(
        shape_phai.physicsBody = SKPhysicsBody(polygonFrom: path1)
        shape_phai.physicsBody?.isDynamic = false
        //shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape_phai.position = CGPoint(x: 0, y: 0)
        shape_phai.fillColor = UIColor.orange
        shape_phai.strokeColor = UIColor.blue
        shape_phai.lineWidth = 3
        addChild(shape_phai)
        
        let shape_tren = SKShapeNode()
        shape_tren.path = path_tren.cgPath
        shape_tren.physicsBody = SKPhysicsBody(polygonFrom: path_tren.cgPath)
        shape_tren.physicsBody?.isDynamic = false
        shape_tren.position = CGPoint(x: 0, y: 0)
        shape_tren.fillColor = UIColor.orange
        shape_tren.strokeColor = UIColor.blue
        shape_tren.lineWidth = 3
        addChild(shape_tren)
        
        
        
        setUpHold()
            
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
            //self.note1.position=location
            changePosistionStick()
            stick.zRotation = CGFloat.pi / 3
            
            // Di chuyển note1 theo vị trí click
            //MARK: Tạo vecter để di chuyển note, vector có hướng và độ lớn làm cho bay nhanh hay chậm
            
            //node1.physicsBody?.velocity=CGVector(dx: 120, dy: 526)
            let dx = location.x - ball_1!.position.x
            let dy = location.y - ball_1!.position.y
            //ball_1!.physicsBody?.applyImpulse(CGVector(dx: -526, dy: 60))
            ball_1!.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
            //node1.physicsBody?.applyImpulse(CGVector(dx: location.x, dy: location.y))
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
