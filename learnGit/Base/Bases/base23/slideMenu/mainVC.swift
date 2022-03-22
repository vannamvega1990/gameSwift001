//
//  mainVC.swift
//  test001
//
//  Created by THONG TRAN on 19/03/2022.
//

import UIKit

class mainVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let btn = UIButton()
        btn.setTitle("btn", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.frame = CGRect(x: 16, y: 196, width: 96, height: 35)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(touch), for: .touchUpInside)
    }
    @objc func touch(){
        print(123)
        NotificationCenter.default.post(name: NSNotification.Name("openMenu"), object: nil)
    }
}

