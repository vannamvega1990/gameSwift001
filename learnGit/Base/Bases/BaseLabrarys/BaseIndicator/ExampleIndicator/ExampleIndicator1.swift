//
//  ExampleIndicator1.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class ExampleIndicator1: UIViewController {
    
    let spinner = Spinner(frame: CGRect(x: 16, y: 98, width: 98, height: 98))

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.spinner.stopAnimating()
    }
    @objc func xuly(){
        print("123-----------")
        self.spinner.startAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.spinner.Style = .None
        self.spinner.enableInnerLayer = true
        
        self.spinner.startAnimating() // spinner starts animating
        //self.spinner.stopAnimating()  // spinner stops animating
        self.spinner.hidesWhenStopped = true// spinner hides when stopped
        
        self.spinner.outerStrokeColor = UIColor.red
        self.spinner.innerStrokeColor = UIColor.green
        self.spinner.labelTextColor = UIColor.gray
        self.spinner.labelText = "Loading"
        
        let btn = UIButton(frame: CGRect(x: 16, y: 378, width: 198, height: 98))
        btn.backgroundColor = .red
        btn.setTitle("noi dung", for: .normal)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
        view.addSubview(btn)
        view.addSubview(spinner)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    


}
