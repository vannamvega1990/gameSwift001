//
//  UIButton+Extensions.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIButton {
    
    // add gradient for button -----------------
    func setGradientForButton(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(image, for: .normal)
    }
    
    func setGradientBackgroundForUIButton(colors: [UIColor], locations: [NSNumber], isVertical: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        if isVertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        gradientLayer.locations = locations//[0.0, 1.0]
        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(image, for: .normal)
    }
}
