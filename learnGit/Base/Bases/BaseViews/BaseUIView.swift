//
//  BaseView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseView: UIView {
    
    var object: Any?
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
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
    
    @IBInspectable var cornerTopRadius: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topLeft, .topRight], radius: cornerTopRadius)
        }
    }
    @IBInspectable var cornerLeftRadius: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topLeft, .bottomLeft ], radius: cornerLeftRadius)
        }
    }
    @IBInspectable var cornerRightRadius: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topRight, .bottomRight], radius: cornerRightRadius)
        }
    }
    @IBInspectable var cornerBottomRadius: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: cornerBottomRadius)
        }
    }
    @IBInspectable var corner: [CGFloat] = [0,0,0,0,0] {
        didSet {
            var corners: UIRectCorner = .init()
            if corner[0] == 1{
                corners.insert([.topLeft])
            }
            if corner[1] == 1{
                corners.insert([.topRight])
            }
            if corner[2] == 1{
                corners.insert([.bottomRight])
            }
            if corner[3] == 1{
                corners.insert([.bottomLeft])
            }
            roundCorners(corners: corners, radius: corner[4])
        }
    }
    @IBInspectable var roundTop1: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topLeft], radius: roundTop1)
        }
    }
    @IBInspectable var roundTop2: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topRight], radius: roundTop2)
        }
    }
    @IBInspectable var roundBotom1: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.bottomLeft], radius: roundBotom1)
        }
    }
    @IBInspectable var roundBotom2: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.bottomRight], radius: roundBotom2)
        }
    }
    @IBInspectable var isFakeUIButton: Bool = false {
        didSet {
            if isFakeUIButton {
                fakeUIButton()
            }
        }
    }
    @IBInspectable var createDashLine: UIColor = .clear {
        didSet {
            createDashLine(color: createDashLine)
        }
    }
    // round corner any ---------------------
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        clipsToBounds = true
    }
 
    // add tap gesture to uiview ----------------------
    var tapHanle: ((UITapGestureRecognizer)->Void)?
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
//    func addTapGesture1(selector: Selector?) -> UITapGestureRecognizer{
//        let tap = UITapGestureRecognizer(target: self, action: selector)
//        addGestureRecognizer(tap)
//        return tap
//    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        tapHanle?(sender)
    }
    
    // ----------------------
    var bgFake = UIView()
    var btnFake = UIButton()
    var actionFakeWhenTouchUp: (() -> Void)?
    func fakeUIButton(){
        bgFake.frame = bounds
        bgFake.backgroundColor = UIColor(white: 1, alpha: 0)
        addSubview(bgFake)
        let btn = UIButton(frame: bounds)
        //btn.backgroundColor = .red
        btnFake.frame = bounds
        addSubview(btnFake)
        //bringSubviewToFront(btn)
        btnFake.addTarget(self, action: #selector(fakeButtonTapDown), for: .touchDown)
        btnFake.addTarget(self, action: #selector(fakeButtonTapUp), for: .touchUpInside)
        btnFake.addTarget(self, action: #selector(fakeButtonTapUpOutside), for: .touchUpOutside)
        btnFake.addTarget(self, action: #selector(fakeButtonTapUpOutside), for: .touchCancel)
    }
    @objc func fakeButtonTapDown(){
        bgFake.backgroundColor = UIColor(white: 1, alpha: 0.6)
        print("123456")
        // actionFakeWhenTouchUp?()
    }
    @objc func fakeButtonTapUp(){
        bgFake.backgroundColor = UIColor(white: 1, alpha: 0)
        actionFakeWhenTouchUp?()
    }
    @objc func fakeButtonTapUpOutside(){
        bgFake.backgroundColor = UIColor(white: 1, alpha: 0)
    }

}



