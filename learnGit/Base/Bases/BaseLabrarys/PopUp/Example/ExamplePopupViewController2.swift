//
//  ExamplePopupViewController2.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class ExamplePopupViewController2: BaseViewControllers {

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

        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        btn.frame = CGRect(x: 189, y: 196, width: 98, height: 46)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
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
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            //self.showPopupSukoBottom(viewWantPop: v2 , isBg: false, lef: 10, right: 90, height: v2.bounds.height)
            //self.showPopupSukoCenter(viewWantPop: v2, typeAnimation: .Opacity , isBg: true, lef: 10, right: 90, height: v2.bounds.height)
            //self.showPopupSukoBottom(viewWantPop: v2, typeAnimation: .Move , isBg: true, lef: 10, right: 90, height: v2.bounds.height)
            
            self.showListPopup2(dataArrayName: ["123", "noi dung"])
        }
        
    }
    
    @objc func xuly2(){
        hidePopupSuko(typeAnimation: .Opacity, complete: {
            
        })
    }
    


}



