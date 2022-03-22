//
//  FakeSwipeViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class FakeSwipeViewController: UIViewController {

    @IBOutlet weak var pagetab: BasePageTab!
    init() {
        super.init(nibName: "FakeSwipeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var oldPointY:CGFloat = 0
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        oldPointY = pagetab.topConstraint!.constant
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureMoveAround(_:)))
        
        
        //self.view.addGestureRecognizer(swipeGesture)
        self.view.addGestureRecognizer(panGesture)
        
    }
    
    var oldPoint: CGPoint = .init()
    @objc func panGestureMoveAround(_ gesture: UIPanGestureRecognizer) {
        
        var locationOfBeganTap: CGPoint
        
        var locationOfEndTap: CGPoint
        
        
        if gesture.state == .changed {
            let newPoint = gesture.location(in: view)
            let dy = newPoint.y - oldPoint.y
            print("dy --------\(dy)")
            
            guard max(0, (250 - pagetab.topConstraint!.constant)/250) > 0 else {
                return
            }
            guard pagetab.topConstraint!.constant > 8 else {
                return
            }
            pagetab.topConstraint?.constant += (32*dy)/(3*pagetab.topConstraint!.constant)
                //- max(0, (250 - pagetab.topConstraint!.constant)/250)
            //oldPoint.y = newPoint.y
            print(oldPoint.y)
            oldPoint = newPoint
        }
        else if gesture.state == UIGestureRecognizer.State.began {
            oldPoint = gesture.location(in: view)
            locationOfBeganTap = gesture.location(in: view)
            print(locationOfBeganTap)

        } else if gesture.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
                self.pagetab.topConstraint!.constant = self.oldPointY
            } completion: { (flag) in
                
            }

            locationOfEndTap = gesture.location(in: view)
            print(locationOfEndTap)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagetab.heightConstraint?.constant = 46
        // Do any additional setup after loading the view.
    }


}

