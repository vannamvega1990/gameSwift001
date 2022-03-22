//
//  CustomDashedView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/11/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

@IBDesignable
class CustomDashedView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0

    var dashBorder: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

// view as a dash line ---------------------
@IBDesignable
class CustomDashLineView: UIView {
    @IBInspectable var dashColor1: UIColor = .gray
    @IBInspectable var dashLength: CGFloat = 10
    @IBInspectable var betweenDashesSpace: CGFloat = 6
    override func layoutSubviews() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.strokeColor = dashColor1.cgColor
        shapeLayer.lineWidth = bounds.height
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: bounds.height/2),
                                CGPoint(x: bounds.width, y: bounds.height/2),
                                ])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
