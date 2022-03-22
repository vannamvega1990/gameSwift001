//
//  BaseUIImageView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseUIImageView: UIImageView {
    
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
    
    @IBInspectable var backgroundColor1: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor = backgroundColor1
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
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var setTintColor: UIColor = UIColor.white {
        didSet {
            image = image?.withRenderingMode(.alwaysTemplate)
            tintColor = setTintColor
        }
    }
    
    @IBInspectable var roundCircle:Bool = false {
        didSet{
            if roundCircle {
                let _ = drawAnCircle(radius:min(bounds.width/2 - 0, bounds.height/2 - 0), centerPoint:CGPoint(x: bounds.midX, y: bounds.midY), lineWidth:0, fillColor:.red,
                                     strokeColor: .yellow, settingMark: true)
                addBorder()
            }
        }
    }
    
    func addBorder(){
        let frame = self.frame.resizeAtCenter(offsetX: 16, offsetY: 16)
        let v1 = BaseView(frame: frame)
        v1.backgroundColor = UIColor.red
        v1.setGradientCircleBackground(colors: [.red,.green,.yellow], locations: [0.0,0.6, 1.0], isVertical: false)
        if let superV = self.superview{
            superV.addSubview(v1)
        }
        v1.drawAnCircle(radius:min(v1.bounds.width/2 - 3, v1.bounds.height/2 - 3), centerPoint:CGPoint(x: v1.bounds.midX, y: v1.bounds.midY), lineWidth:6, fillColor:.clear,
                        strokeColor: .yellow, settingMark: true)
    }
    
    func addViews(views: [UIView]){
        for each in views {
            layer.addSublayer(each.layer)
        }
    }
    
    
    
}


