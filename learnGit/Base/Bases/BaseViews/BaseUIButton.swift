//
//  BaseButton.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var rotate: CGFloat = 0.0 {
        didSet {
            transform = transform.rotated(by: rotate.degreesToRadians)
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var setTinColorNomal: UIColor = UIColor.white {
        didSet {
            if self.imageView != nil {
                //self.imageView?.setTintColor(color: setTinColorNomal)
                if let img = imageView!.image, let imgTinted = img.setTintColor(with: setTinColorNomal) {
                   setImage(imgTinted, for: .normal)
                }
            }
        }
    }
    
    @IBInspectable var setTinColorSelected: UIColor = UIColor.white {
        didSet {
            if self.imageView != nil {
                //self.imageView?.setTintColor(color: setTinColorSelected)
                if let img = imageView!.image, let imgTinted = img.setTintColor(with: setTinColorSelected) {
                   setImage(imgTinted, for: .normal)
                }
            }
        }
    }
    
    @IBInspectable var setShadow1: Bool = false {
        didSet{
            if setShadow1 {
                backgroundColor = UIColor.white
                // Shadow Color and Radius
                layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                layer.shadowOpacity = 1.0
                layer.shadowRadius = 5.0
                layer.masksToBounds = false
                layer.cornerRadius = 4.0
            }
        }
    }
        
    @IBInspectable var roundTop: Bool = false {
        didSet {
            if roundTop {
                roundCorners(corners: [.topLeft, .topRight], radius: cornerRadius)
            }
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}

