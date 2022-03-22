//
//  TPDiscriptionKYCViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIView {
   func roundCorners1(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

class TPDiscriptionKYCViewController: TPBaseViewController {

    var frontImg: UIImage?
    var backImg: UIImage?
    var faceImg: [UIImage]?
    
    @IBOutlet weak var btnOCR: TPBaseViewImageWithLabel!
    @IBOutlet weak var viewToko: BaseView!
    
    init() {
        super.init(nibName: "TPDiscriptionKYCViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewToko.roundCorners1(corners: [.topLeft, .topRight], radius: 16)
        viewToko.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewToko.cornerTopRadius = 16
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnOCR.indexPath = IndexPath(row: 1, section: 1)
        btnOCR.actionClosure = { indexPath in
            self.goNext()
        }
    }
    
    func goNext() {
        let scanVC = TPOCRScanViewController()
        //scanVC.isFront = true
        //scanVC.frontCallBack = self
        scanVC.frontCallBack = {
            print("123")
        }
        scanVC.onDoneBlock = { result in
            if self.frontImg != nil {
                //completion(self.frontImg)
            }
        }
        pushToViewController(scanVC, true)
    }


}
