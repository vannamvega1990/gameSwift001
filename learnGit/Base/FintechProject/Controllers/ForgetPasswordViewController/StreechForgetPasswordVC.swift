//
//  StreechChangePasswordVC.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

import UIKit

class StreechForgetPasswordVC: FTBaseViewController {
    var phone = ""
    convenience init(mobile:String){
        //self.phone = mobile
        self.init()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        subViewController = ForgetPasswordViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //subViewController = StartViewController()
    }
}
