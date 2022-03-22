//
//  OCRPreviewViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class OCRPreviewViewController: FTBaseViewController {

    init() {
        super.init(nibName: "OCRPreviewViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func btnNextPressed(_ sender: UIButton) {
        let vc = OCRScanViewController()
        //pushToViewController(vc, true)
        
        VegaFintecheKYC.shared.goToScanFrontView { (img: UIImage?) in
            print("----------123")
            self.showSimpleAlert(title: "tb", ms: "nhan đc img")
        }
    }


}






