//
//  biDaViewController.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import UIKit
import SpriteKit
import GameplayKit


class biDaViewController: UIViewController {
    
    var gameView:SKView?
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        gameView = SKView(frame: view.bounds.resizeAtCenter(offsetX: 16, offsetY: 16))
        view.addSubview(gameView!)
        if let view = self.gameView {
            // ------------ Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "scene001") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
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
