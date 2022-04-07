//
//  scene001.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import SpriteKit
import GameplayKit

class scene_1: SKScene, SKPhysicsContactDelegate{
    
    var ball_main, ball_8, table, table_body, stick: SKSpriteNode!
    var ball_1, ball_2, ball_3, ball_4, ball_5, ball_6, ball_7: SKSpriteNode!
    var ball_9, ball_10, ball_11, ball_12, ball_13, ball_14, ball_15: SKSpriteNode!
    var timer: Timer?
    
    var ball_array: [SKSpriteNode] = [SKSpriteNode]()
    var flagBeginCheckAllNodeIsStanding: Bool = false {
        didSet {
//            if flagBeginCheckAllNodeIsStanding {
//                if checkAllNodeIsStanding() {
//                                print("------all node is standing")
//                    flagBeginCheckAllNodeIsStanding = true
//                            }else{
//                                print("------have a node is moving")
//                    flagBeginCheckAllNodeIsStanding = true
//                            }
//                
//            }
        }
    }
    
    
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
            self.ball_array.append(contentsOf: [self.ball_main, self.ball_1, self.ball_2, self.ball_3, self.ball_4, self.ball_5 , self.ball_6, self.ball_7, self.ball_8, self.ball_9,self.ball_10 , self.ball_11, self.ball_12, self.ball_13, self.ball_14, self.ball_15])
            for (key,each) in self.ball_array.enumerated() {
                let node = SKSpriteNode()
                
                each.physicsBody = SKPhysicsBody(circleOfRadius: each.frame.size.width / 2)
                let img_name = "ball_" + "\(key)"
                
                let image = UIImage(named: img_name)
                 let texture = SKTexture(image: image!)
                //let player = texture
                each.texture = texture
                each.physicsBody!.mass = 0.03
                each.anchorPoint = CGPoint(x:0.5, y: 0.5)
                each.physicsBody!.allowsRotation =  false
                each.physicsBody!.affectedByGravity = false
                each.physicsBody?.friction = 5.9
                
            }
        })
        stick.anchorPoint = CGPoint(x: 0, y: 0.5)
        showStick()
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
        stick = self.childNode(withName: "stick") as? SKSpriteNode
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
    var count: Int = 0
    override func update(_ currentTime: TimeInterval) {
        //        print(currentTime)
        count += 1
        
        if ball_1 != nil {
            //print(ball_1.physicsBody!.velocity)
            //print(sqrt(9))
            if ball_1.physicsBody!.isResting {
                //print("ball_1 is resting")
            }
            let lengMove = sqrt(ball_1.physicsBody!.velocity.dx * ball_1.physicsBody!.velocity.dx + ball_1.physicsBody!.velocity.dy * ball_1.physicsBody!.velocity.dy)
            //print(lengMove)
            if lengMove < 6 {
                //ball_1.physicsBody!.velocity = CGVector(dx:0,dy:0)
                //print("ball_1 is resting")
            }else{
                //print("ball_1 is running")
            }
            
            if flagBeginCheckAllNodeIsStanding {
                flagBeginCheckAllNodeIsStanding = false
                if !checkAllNodeIsStanding() {
                    //print("------have a node is moving")
                    flagBeginCheckAllNodeIsStanding = true
                    hideStick()
                }else{
                    //print("------have no node is moving")
                    //showStick()
                    flagBeginCheckAllNodeIsStanding = false
                }
            }
//        }
//        else{
//            print("------all node is standing")
//            flagBeginCheckAllNodeIsStanding = true
//            }
//        }
//        if flagBeginCheckAllNodeIsStanding {
//            flagBeginCheckAllNodeIsStanding = false
//            if checkAllNodeIsStanding() {
//                print("------all node is standing")
//            }else{
//                print("------have a node is moving")
//            }
        }
        
    }
    
    var flagCaculateGoc = false
    var allowTimer = true
    var touchBeginPosition: CGPoint = .init()
    
    @objc func handleTimer(){
        flagCaculateGoc = true
        print("----- timer")
    }
    
    var flagFirstTouch = true
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //MARK: sự kiện click vào màn hình
        for touch in touches {
            let location=touch.location(in: self)
            print(location.x,location.y)
            touchBeginPosition = location
            flagBeginCheckAllNodeIsStanding = true
            let dx = location.x - ball_main!.position.x
            let dy = location.y - ball_main!.position.y
            //ball_1!.physicsBody?.applyImpulse(CGVector(dx: -526, dy: 60))
            //ball_main!.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
            oldPoint = stick.position
            count1 += 1
            print(count1)
            
            let vector = MathUtity.createVector(rootPoint: ball_main.position, to: location)
            if flagFirstTouch, let goc = MathUtity.getDegreeOfVector(vector: vector) {
                var goc1 = MathUtity.gocDoixung(goc: goc)
                goc1 = MathUtity.reduceGocOver180(goc: goc1)
                stick.zRotation = goc1
                flagFirstTouch = false
            }
            if allowTimer {
                //allowTimer = false
                timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: true)
            }
            
            
//            if count1 == 1 {
//               stick.zRotation = .pi/3
//            }
//            else if count1 == 2 {
//               stick.zRotation = 0
//            }
//            else if count1 == 3 {
//               stick.zRotation = -.pi/3
//            }
//            else if count1 == 4 {
//                stick.zRotation = .pi + .pi/3
//            }
            
        }
    }

    var oldPoint: CGPoint  = .init()
    var count1: Int = 0
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        //print("touchesMoved")
        for touch in touches {
            let location=touch.location(in: self)
            if flagCaculateGoc {
                flagCaculateGoc = false
                let v1 = MathUtity.createVector(rootPoint: ball_main.position, to: touchBeginPosition)
                let v2 = MathUtity.createVector(rootPoint: ball_main.position, to: location)
                let goc = MathUtity.getDegree2Vector(fromVecter: v1, toVector: v2)
                if abs(goc) > MathUtity.DegreeToRadiant(goc: 1) {
                    print("------- chinh goc")
                    //var goc = MathUtity.getDegreeOfVector(vector: v2)
                    //goc = MathUtity.gocDoixung(goc: goc!)
                    //goc = MathUtity.reduceGocOver180(goc: goc!)
                    let goc = stick.zRotation + goc
                    let goc1 = MathUtity.reduceGocOver180(goc: goc)
                    stick.zRotation = goc1
                }else {
                    print("------ chinh luc")
                }
                touchBeginPosition = location
                //timer?.invalidate()
                //timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: false)
            }
//            let dx = location.x - oldPoint.x
//            let dy = location.y - oldPoint.y
//            oldPoint = location
//            print(location.x,location.y)
//            let newPosX = stick.position.x + dx
//            let newPosY = stick.position.y + dy
//            stick.position = CGPoint(x: newPosX, y: newPosY)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        //allowTimer = true
        //flagCaculateGoc = false
        timer?.invalidate()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        //allowTimer = true
        //flagCaculateGoc = false
        timer?.invalidate()
    }
}


extension scene_1 {
    func showStick(){
        stick.position = CGPoint(x: ball_main.position.x + ball_main.size.width/2 + 32 , y: ball_main.position.y)
        //stick.position = ball_main.position
        let p = stick.anchorPoint
        stick.anchorPoint = MathUtity.convertAnchorPont(point: ball_main.position, oldAnchopoint: p, objectFrame: stick.frame)
        stick.position = ball_main.position
        stick.isHidden = false
    }
    func hideStick(){
        stick.isHidden = true
    }
    func checkANodeIsStanding(node:SKSpriteNode) -> Bool {
        let lengMove = sqrt(node.physicsBody!.velocity.dx * node.physicsBody!.velocity.dx + node.physicsBody!.velocity.dy * node.physicsBody!.velocity.dy)
        print(lengMove)
        return lengMove < 6
    }
    
    func checkAllNodeIsStanding() -> Bool{
        var flagStanding: Bool = true
        for node in ball_array {
            //if node.physicsBody!.velocity != CGVector(dx: 0, dy: 0) {
            //if !node.physicsBody!.isResting {
            if !checkANodeIsStanding(node: node){
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
