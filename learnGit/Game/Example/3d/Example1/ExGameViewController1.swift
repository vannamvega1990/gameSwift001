//
//  ExGameViewController1.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import UIKit
import QuartzCore
import SceneKit

class ExGameViewController1: UIViewController,SCNSceneRendererDelegate {
    
    var gameView:SCNView!
    var gameScene:SCNScene!
    var cameraNode:SCNNode!
    var targetCreationTime:TimeInterval=0
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        if time > targetCreationTime {
            createTarget()
            targetCreationTime=time+0.6
        }
        cleanUp()
    }
    
    func cleanUp(){
        for node in gameScene.rootNode.childNodes{
            if node.presentation.position.y < -2 {
                node.removeFromParentNode()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch=touches.first!
        let location=touch.location(in: gameView)
        let hitList=gameView.hitTest(location, options: nil)
        if let hitObject=hitList.first  {
            let node = hitObject.node
            if node.name=="friend" {
                node.removeFromParentNode()
                self.gameView.backgroundColor = .blue
            }else{
                node.removeFromParentNode()
                self.gameView.backgroundColor = .yellow
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initScene()
        initCamera()
        //createTarget()
    }
    
    func initView(){
        self.view.backgroundColor = .white
        //gameView=self.view as! SCNView
        gameView = SCNView(frame: view.bounds)
        view.addSubview(gameView)
        gameView.allowsCameraControl=true
        gameView.autoenablesDefaultLighting=true
        gameView.delegate=self
    }
    
    func createTarget(){
        let geometry=SCNPyramid(width: 1, height: 1, length: 1)
        let randomColor=arc4random_uniform(2)==0 ? UIColor.yellow : UIColor.red
        
        geometry.materials.first?.diffuse.contents=randomColor
        let geometryNode=SCNNode(geometry: geometry)
        geometryNode.physicsBody=SCNPhysicsBody(type: .dynamic, shape: nil)
        
        
        if randomColor == UIColor.red{
            geometryNode.name="enemy"
        }else{
            geometryNode.name="friend"
        }
        
        gameScene.rootNode.addChildNode(geometryNode)
        
        let randomDirection:Float=arc4random_uniform(2)==0 ? -1.0:1.0
        let force=SCNVector3(1, 15, 0)
        geometryNode.physicsBody?.applyForce(force, at: SCNVector3(x: 0.05, y: 0.05, z: 0.05), asImpulse: true)
        
    }
    
    func initScene(){
        gameScene=SCNScene()
        gameView.scene=gameScene
        gameView.isPlaying=true
    }
    
    func initCamera(){
        cameraNode=SCNNode()
        cameraNode.camera=SCNCamera()
        cameraNode.position=SCNVector3(0, 5, 10)
        
        gameScene.rootNode.addChildNode(cameraNode)
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
}


