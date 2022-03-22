//
//  EXExchangeChartViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class EXExchangeChartViewController: BaseViewControllers {

    let vTest = ExchangeChart(frame: CGRect(x: 16, y: 98, width: 268, height: 398))
    
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
        print("--------")
        vTest.changeStepX()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        
        vTest.rootView.backgroundColor = .lightGray
        addSubViews([vTest])
        
    }
    

}
