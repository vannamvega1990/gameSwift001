//
//  EditAccountBankViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/18/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class EditAccountBankViewController: FTBaseViewController {

    init() {
        super.init(nibName: "EditAccountBankViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupKeyboardDismissRecognizer()
    }



}
