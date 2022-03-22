//
//  UIColor+Extension.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    // init color with hex , vd: UIColor(rgb: 0xFFFF39, alpha: 1) ----------
    convenience init(rgb: Int, alpha: CGFloat = 1) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alpha: alpha
        )
    }
}
