//
//  UITextField+Extension.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UITextField {
    // add custom toolbar ---------------------
    func addCustomToolBar(_ toolbar: UIView?){
        if let toolbar = toolbar {
            inputAccessoryView = toolbar
        }else{
            let toolbar1 = UIView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 96)))
            toolbar1.backgroundColor = .red
            inputAccessoryView = toolbar1
        }
    }
}
