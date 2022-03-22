//
//  TPBaseButton.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPBaseButton: UIButton {
//    @IBInspectable var setBgColor2: Bool = false {
//        didSet {
//            if setBgColor2 {
//                let colors = [UIColor(rgb: 0xFAC75F, alpha: 1),
//                              UIColor(rgb: 0xE98117, alpha: 1)]
//                let locations: [NSNumber] = [0 , 1.0]
//                setGradientBackgroundForUIButton(colors: colors, locations: locations, isVertical: false)
//            }
//        }
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //backgroundColor = .red
        setGradientForButton()
//        let colors = [UIColor(rgb: 0xFAC75F, alpha: 1),
//                      UIColor(rgb: 0xE98117, alpha: 1)]
//        let locations: [NSNumber] = [0 , 1.0]
//        setGradientBackgroundForUIButton(colors: colors, locations: locations, isVertical: false)
    }
}
