//
//  StreechLoginViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class StreechLoginViewController: FTBaseViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        subViewController = LoginViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //subViewController = StartViewController()
    }
}
