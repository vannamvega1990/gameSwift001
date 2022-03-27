//
//  biDaViewController.swift
//  learnGit
//
//  Created by THONG TRAN on 21/03/2022.
//

import UIKit
import SpriteKit
import GameplayKit

let widthOfTableBall: CGFloat = 15 * 100
let heightOfTableBall: CGFloat = 8.5 * 100
let sizeOfTableBoder: CGFloat = 0.8 * 100
//let sizeOfBall: CGFloat = 0.4 * 100
let sizeOfBall: CGFloat = 0.4 * 100
let sizeOHold: CGFloat = 0.6 * 100 // duong kinh
let sizeOfHoldGoc: CGFloat = 0.8 * 100
let ngatCanh: CGFloat = 0.3 * 100
//let ngatGoc = 2 * sizeOfBall * sin(Double.pi/4)
let ngatGoc = 0.6 * 100 * sin(Double.pi/4)



class biDaViewController: FTBaseViewController {
    
    var gameView:SKView?
    let top: CGFloat = 56
    let bottom: CGFloat = 26
//W: 15cm
//Hei: 8.5 cm
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setBackgroundColor()
        
        gameView = SKView(frame: view.bounds.resizeAtCenter(offsetX: 16, offsetY: 16))
        let heightOfGameView = sizeScreen.height - (top + bottom)
//        let sacle: CGFloat = sizeScreen.width / sizeScreen.height
        let sacle: CGFloat = 15 / 8.5
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
            view1.showsPhysics = true
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
