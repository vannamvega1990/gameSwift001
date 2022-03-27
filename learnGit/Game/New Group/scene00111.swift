//
//  scene001.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import SpriteKit
import GameplayKit

class scene00111: SKScene, SKPhysicsContactDelegate{
    
    //let node1 = SKSpriteNode(color: .yellow, size: CGSize(width: 36, height: 36))
//    let node1 = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 36, height: 36), cornerRadius: 18)
    let ball_main = SKShapeNode(circleOfRadius: 26)
    let node2 = SKSpriteNode(color: .green, size: CGSize(width: 567, height: 36))
//    let stick = SKShapeNode(rectOf: CGSize(width: 536, height: 16))
    
    let stick = SKSpriteNode(color: .green, size: CGSize(width: 536, height: 16))
    
    
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
        
        
        ball_main.position = CGPoint(x: 0, y: 0)
        self.addChild(ball_main)
        ball_main.fillColor = .yellow
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]
        let myAttrString = NSAttributedString(string: "3", attributes: myAttribute)
        self.num3 = SKLabelNode(attributedText: myAttrString)
        if let num3 = num3 {
            ball_main.addChild(num3)
        }
//        node1.physicsBody=SKPhysicsBody(rectangleOf: node1.size)
//        node1.physicsBody=SKPhysicsBody(circleOfRadius: node1.frame.size.width/2)
        ball_main.physicsBody = SKPhysicsBody(circleOfRadius: 26)
        ball_main.physicsBody?.isDynamic = true
        ball_main.physicsBody?.contactTestBitMask=vatThe.nhom1.rawValue
        ball_main.physicsBody!.mass = 0.6
        ball_main.physicsBody!.affectedByGravity = false
        ball_main.physicsBody?.friction = 1.6
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
        
        //let noidung = SKShapeNode(rectOf: size)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: canh3!.position.x - canh3!.size.width/2, y: -canh3!.size.height/2))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: canh3!.size.height/2 - ngatCanh))
        path.addLine(to: CGPoint(x: path.currentPoint.x + ngatCanh, y: path.currentPoint.y + ngatCanh))
        path.addArc(withCenter: CGPoint(x: canh3!.position.x - ngatCanh/2, y: canh1!.position.y - ngatCanh/2), radius: sizeOHold/2, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: path.currentPoint.x - ngatCanh, y: canh1!.position.y - canh1!.size.height/2))
        path.addLine(to: CGPoint(x: sizeOHold/2 + ngatCanh/2, y: path.currentPoint.y ))
        path.addLine(to: CGPoint(x: sizeOHold/2, y: path.currentPoint.y + ngatCanh/2 ))
        path.addLine(to: CGPoint(x: path.currentPoint.x, y: path.currentPoint.y + ngatCanh * 1 ))
        path.addLine(to: CGPoint(x: canh3!.position.x + 96, y: path.currentPoint.y ))
        path.addLine(to: CGPoint(x: path.currentPoint.x + 96, y: -canh3!.size.height/2 ))
        //path.addArc(withCenter: CGPoint(x: 0, y: path.currentPoint.y), radius: sizeOHold/2, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        //path.addLine(to: CGPoint(x: canh4!.position.x + canh4!.size.width/2, y: path.currentPoint.y))
        // segment 2: curve
//            path.addCurve(to: CGPoint(x: 0, y: 12), // ending point
//                controlPoint1: CGPoint(x: 2, y: 14),
//                controlPoint2: CGPoint(x: 0, y: 14))

            // segment 3: line
//            path.addLine(to: CGPoint(x: 160, y: 0))
        //path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        let pathBao = UIBezierPath(roundedRect: CGRect(x: -san!.size.width/2, y: -san!.size.height/2, width: san!.size.width, height: san!.size.height), cornerRadius: 0)
        pathBao.append(path)
        pathBao.usesEvenOddFillRule = true
        let path1 = path.cgPath
        let noidung = SKShapeNode(path: path1)
        
        noidung.fillColor = .orange
        noidung.strokeColor = .green
        noidung.lineWidth = 1
        //noidung.physicsBody = SKPhysicsBody(
        noidung.position = CGPoint.zero
        //addChild(noidung)
        
        let shape = SKShapeNode()
        //shape.path = UIBezierPath(roundedRect: CGRect(x: -128, y: -128, width: 256, height: 256), cornerRadius: 64).cgPath
        shape.path = path1
//        shape.physicsBody = SKPhysicsBody(
        shape.physicsBody = SKPhysicsBody(polygonFrom: path1)
        shape.physicsBody?.isDynamic = false
        //shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.position = CGPoint(x: 0, y: 0)
        shape.fillColor = UIColor.orange
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 3
        addChild(shape)
            
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
            ball_main.physicsBody?.applyImpulse(CGVector(dx: 126, dy: 176))
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
