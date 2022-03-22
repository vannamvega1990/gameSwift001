//
//  BaseUIProgressView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseUIProgressView: UIProgressView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
    
}

