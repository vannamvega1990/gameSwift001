//
//  BaseParams.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

// truyen tham so cho selector -------------------

class BaseParams: UIViewController {
    
    @objc func moveToNextTextField(sender: Timer) {
        if let data = sender.userInfo as? [String: Int] {
            print(data["index"] ?? "")
        }
    }
    
    @objc func btnParamTouch(sender: btnParam) {
        if let data = sender.object as? [String: Int] {
            print(data["index"] ?? "")
        }
    }
    @objc func viewParamTouch(sender: UITapGestureRecognizer) {
        if let v = sender.view as? viewParm {
            if let data = v.object as? [String: Int] {
                print(data["index"] ?? "")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .white
        
        let selector = #selector(self.moveToNextTextField(sender:))
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: ["index": 2], repeats: false)
        
        let btn = btnParam(frame: CGRect(x: 16, y: 98, width: 98, height: 98))
        btn.backgroundColor = .red
        btn.object = ["index": 12]
        view.addSubview(btn)
        let selector2 = #selector(self.btnParamTouch(sender:))
        btn.addTarget(self, action: selector2, for: .touchUpInside)
        
        let v = viewParm(frame: CGRect(x: 16, y: 398, width: 98, height: 98))
        v.backgroundColor = .red
        v.object = ["index": 32]
        view.addSubview(v)
        let selector3 = #selector(self.viewParamTouch(sender:))
        let tap = UITapGestureRecognizer(target: self, action: selector3)
        v.addGestureRecognizer(tap)
    }
}

class btnParam: UIButton {
    var object:Any?
}

class viewParm: UIView {
    var object: Any?
}

