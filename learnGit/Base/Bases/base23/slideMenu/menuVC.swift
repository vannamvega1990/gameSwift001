//
//  menuVC.swift
//  test001
//
//  Created by THONG TRAN on 19/03/2022.
//

import UIKit

class menuVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let btn = UIButton()
        btn.setTitle("btn", for: .normal)
        btn.frame = CGRect(x: 16, y: 96, width: 96, height: 35)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(touch), for: .touchUpInside)
    }
    func handletap(userInfo: [AnyHashable:Any]?){
        NotificationCenter.default.post(name: NSNotification.Name("hideMenu"), object: nil,userInfo: userInfo)
    }
    @objc func touch(){
        print(123)
        handletap(userInfo: nil)
    }
}


