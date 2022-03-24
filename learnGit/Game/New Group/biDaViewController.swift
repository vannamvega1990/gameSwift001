//
//  biDaViewController.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import UIKit
import SpriteKit
import GameplayKit


class biDaViewController: FTBaseViewController {
    
    var gameView:SKView?
    let top: CGFloat = 56
    let bottom: CGFloat = 26
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setBackgroundColor()
        
        gameView = SKView(frame: view.bounds.resizeAtCenter(offsetX: 16, offsetY: 16))
        let heightOfGameView = sizeScreen.height - (top + bottom)
        let sacle: CGFloat = sizeScreen.width / sizeScreen.height
        let width = heightOfGameView * sacle
        let xOffset: CGFloat = (sizeScreen.width - width) / 2
        gameView = SKView(frame: CGRect(x: xOffset, y: top, width: width , height: heightOfGameView))
        view.addSubview(gameView!)
        if let view1 = self.gameView {
            // ------------ Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "scene001") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view1.presentScene(scene)
            }
            // ---------- setup something
            view1.ignoresSiblingOrder = true
            view1.showsFPS = true
            view1.showsNodeCount = true
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
