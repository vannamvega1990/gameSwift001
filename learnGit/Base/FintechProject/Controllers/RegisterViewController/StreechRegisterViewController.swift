//
//  StreechRegisterViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class StreechRegisterViewController: FTBaseViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        subViewController = RegisterViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //subViewController = StartViewController()
    }
}
