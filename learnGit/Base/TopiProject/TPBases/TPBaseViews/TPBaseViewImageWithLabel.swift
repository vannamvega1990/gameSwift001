//
//  TPBaseViewImageWithLabel.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPBaseViewImageWithLabel: FTBaseViewImageWithLabel {
    
    var gradient:CAGradientLayer?
    override func layoutSubviews() {
        super.layoutSubviews()
        if setBgColor2 {
            let colors = [UIColor(rgb: 0xFAC75F, alpha: 1),
                          UIColor(rgb: 0xE98117, alpha: 1)]
            let locations: [NSNumber] = [0 , 1.0]
            let gradientLayer = rootView.setGradientBackground(colors: colors, locations: locations, isVertical: false)
            gradient = gradientLayer
        }else{
            if gradient != nil {
                gradient!.removeFromSuperlayer()
                gradient = nil
            }
            
        }
    }
    @IBInspectable var setBgColor1: Bool = false {
        didSet {
            if setBgColor1 {
                rootView.backgroundColor = UIColor(rgb: 0x464B5B, alpha: 1)
            }
        }
    }
    
    @IBInspectable var setBgColor2: Bool = false
//    {
//        didSet {
//            if setBgColor2 {
//                let colors = [UIColor(rgb: 0xFAC75F, alpha: 1),
//                              UIColor(rgb: 0xE98117, alpha: 1)]
//                let locations: [NSNumber] = [0 , 1.0]
//                let gradientLayer = rootView.setGradientBackground(colors: colors, locations: locations, isVertical: false)
//                gradient = gradientLayer
//            }else{
//                if gradient != nil {
//                    gradient!.removeFromSuperlayer()
//                    gradient = nil
//                }
//
//            }
//        }
//    }
    
   

}

