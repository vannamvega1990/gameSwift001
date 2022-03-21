//
//  ExGameViewController2.swift
//  learnGit
//
//  Created by tran dinh thong on 8/22/21.
//

import UIKit
import SpriteKit
import GameplayKit


class ExGameViewController2: UIViewController {
    
    var gameView:SKView?
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gameView = SKView(frame: view.bounds)
        view.addSubview(gameView!)
        
        //if let view = self.view as! SKView? { // dùng khi khởi tạo project là mặc định kiểu game
        if let view = self.gameView {
            
            // ------------ Load the SKScene from 'GameScene.sks'
            
            if let scene = SKScene(fileNamed: "GameScene2") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            
            // ------------ Load the SKScene from file'
            
//            let scene2 = GameScene2()
//            scene2.scaleMode = .aspectFill
//            view.presentScene(scene2)
            
            // ---------- setup something
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
