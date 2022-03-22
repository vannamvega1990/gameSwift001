//
//  StreechStartViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class StreechStartViewController: FTBaseViewController {

    init() {
        super.init(nibName: "StreechStartViewController", bundle: nil)
        subViewController = StartViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //subViewController = StartViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}
