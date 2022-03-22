//
//  BaseGradientUIButton.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIButton {
    func applyGradient(colors: [CGColor]) -> CAGradientLayer {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        //gradientLayer.cornerRadius = self.frame.height/2

//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
//        self.contentVerticalAlignment = .center
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
//        self.titleLabel?.textColor = UIColor.white
        return gradientLayer
    }
}

@IBDesignable
class GradientButton: BaseButton {
    var gradientBG: CAGradientLayer?
    func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
    }
    @IBInspectable var color1: UIColor = UIColor.red
    @IBInspectable var color2: UIColor = UIColor.green
    override func layoutSubviews() {
        //layer.borderWidth = 5
        //layer.borderColor = UIColor.red.cgColor
        //applyGradient(colors: [CGColor(rg)])
        //let gradient = applyGradient(colors: [UIColorFromRGB(0x2B95CE).cgColor,UIColorFromRGB(0x2ECAD5).cgColor])
        let gradient = applyGradient(colors: [color1.cgColor,color2.cgColor])
        gradientBG = gradient
    }

}
