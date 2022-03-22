//
//  TestViewController5.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import ObjectiveC


class TestViewController5: BaseViewControllers {

    @IBOutlet weak var pagetab: BasePageTab!
    init() {
        super.init(nibName: "TestViewController5", bundle: nil)
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
        
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        //btn.frame = CGRect(x: 189, y: 196, width: 98, height: 46)
        view.addSubview(btn)
        btn.setConstraintByCode(constraintArray: [
            btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            btn.topAnchor.constraint(equalTo: view.topAnchor, constant: 98)
        ])
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
        
        UIView.animate(withDuration: 1) {
            btn.frame.origin.y = 0
        }
        
        let viewSke = BaseSkeletonView()
        viewSke.frame = CGRect(x: 98, y: 98, width: 189, height: 98)
        viewSke.backgroundColor  = .red
        let lb = UILabel()
        lb.backgroundColor = .green
        lb.frame = viewSke.bounds.resizeAtCenter(offsetX: 16, offsetY: 16)
        viewSke.addSubview(lb)
        viewSke.setLoading(true)
        //viewSke.rectWithTwoPoints
        //viewSke.setLoading(true)
        view.addSubview(viewSke)
        
        print(btn.leftConstraint)
    }
    @objc func xuly(){
        //showListPopup(dataArrayName: ["123","456])
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 398))
        v.backgroundColor = .red
        //showPopupBootom(viewWantPop: v, height: v.bounds.height, lef: 0, right: 0)
        //showPopupCenter(viewWantPop: v, height: v.bounds.height, lef: 0, right: 0)
        //showPopupSukoBottom(viewWantPop: v, lef: 0, right: 0, height: v.bounds.height)
        
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 196))
        v2.backgroundColor = .green
        
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 98, height: 46)
        v2.addSubview(btn)
        btn.addTarget(self, action: #selector(xuly2), for: .touchUpInside)
        
        let v3 = TestView(frame: CGRect(x: 0, y: 0, width: 0, height: 196))
        v3.label.text = "typeAnimationtyp"
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            //self.showPopupSukoBottom(viewWantPop: v2 , isBg: false, lef: 10, right: 90, height: v2.bounds.height)
            //self.showPopupSukoCenter(viewWantPop: v2, typeAnimation: .Opacity , isBg: true, lef: 10, right: 90, height: v2.bounds.height)
            //self.showPopupSukoBottom(viewWantPop: v2, typeAnimation: .Move , isBg: true, lef: 10, right: 90, height: v2.bounds.height)
            
            self.showPopupSukoBottom(viewWantPop: v3, typeAnimation: .Move , isBg: true, lef: 0, right: 0, height: nil)
            
            //self.showListPopup2(dataArrayName: ["123", "noi dung"])
        }
        
    }
    
    @objc func xuly2(){
        hidePopupSuko(typeAnimation: .Opacity, complete: {
            
        })
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
