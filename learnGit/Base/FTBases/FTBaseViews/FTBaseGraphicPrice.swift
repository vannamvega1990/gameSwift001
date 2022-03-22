//
//  FTBaseGraphicPrice.swift
//  FinTech
//
//  Created by Tu Dao on 5/13/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseGraphicPrice: UIView {
    
   
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        backgroundColor = .red
//        let v = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        v.backgroundColor = .green
//        addSubview(v)
        let numberPoint = 8
        let shape = CAShapeLayer()
        //shape.fillColor = UIColor().colorWithHexString(hexString: "#FF5722", alpha: 0.03).cgColor
        shape.fillColor = UIColor(rgb: 0xFF5722, alpha: 0.03).cgColor
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 1
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 0, y: bounds.height))
        line.addLine(to: CGPoint(x: bounds.width/8, y: bounds.height/2))
        line.addLine(to: CGPoint(x: 2*bounds.width/8, y: bounds.height/3))
        line.addLine(to: CGPoint(x: 3*bounds.width/8, y: bounds.height/2))
        line.addLine(to: CGPoint(x: 4*bounds.width/8, y: bounds.height/6))
        line.addLine(to: CGPoint(x: 5*bounds.width/8, y: bounds.height/8))
        line.addLine(to: CGPoint(x: 6*bounds.width/8, y: bounds.height/2))
        line.addLine(to: CGPoint(x: 7*bounds.width/8, y: bounds.height/3))
        line.addLine(to: CGPoint(x: 8*bounds.width/8, y: bounds.height/2))
        
        line.addLine(to: CGPoint(x: 8*bounds.width/8, y: bounds.height))
        
        shape.path = line.cgPath
        layer.addSublayer(shape)
        
        
    }
    
    private func cauhinh(){
        //backgroundColor = .red
    }
}

