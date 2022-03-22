//
//  FearView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class FearView: BaseView {
    
   
    
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
        rootView.backgroundColor = .clear
        let v1 = UIView()
        v1.backgroundColor = .red
        v1.frame = bounds
        addSubview(v1)
 
        xulyView(v1: v1, cgColors: [UIColor.red.cgColor,UIColor.red.cgColor])
        
        let v2 = UIView()
        v2.backgroundColor = .red
        v2.frame = bounds
        addSubview(v2)
 
        xulyView(v1: v2, cgColors: [UIColor.red.cgColor,
                                    UIColor(rgb: 0xFAC65E).cgColor])
        v2.setAnchorPoint1(CGPoint(x: 1, y: 1))
        v2.transform = CGAffineTransform(rotationAngle:  CGFloat(45.degreesToRadians))
        
        let v3 = UIView()
        v3.backgroundColor = .red
        v3.frame = bounds
        addSubview(v3)
 
        xulyView(v1: v3, cgColors: [UIColor(rgb: 0xFAC65E).cgColor,
                                    UIColor(rgb: 0x289B3C).cgColor])
        v3.setAnchorPoint1(CGPoint(x: 1, y: 1))
        v3.transform = CGAffineTransform(rotationAngle:  CGFloat(90.degreesToRadians))
        
        let v4 = UIView()
        v4.backgroundColor = .red
        v4.frame = bounds
        addSubview(v4)
 
        xulyView(v1: v4, cgColors: [UIColor(rgb: 0x289B3C).cgColor,
                                    UIColor(rgb: 0x289B3C).cgColor])
        v4.setAnchorPoint1(CGPoint(x: 1, y: 1))
        v4.transform = CGAffineTransform(rotationAngle:  CGFloat(135.degreesToRadians))
       
       
    }
    
    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "FearView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
    }
    
    func xulyView(v1:UIView, cgColors:[CGColor]){
        let alpha:Double = 6.0
        let beta: Double = (180.0 - 3*alpha)/4 + 3.7
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = cgColors
            //[UIColor.red.cgColor,UIColor.green.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.25, y: 0.5)
        
        gradientLayer.frame = v1.bounds
        v1.layer.insertSublayer(gradientLayer, at:0)
        
        let pathOut = UIBezierPath()
        pathOut.move(to: CGPoint(x: v1.bounds.maxX, y: v1.bounds.maxY))
        pathOut.addLine(to: CGPoint(x: 0, y: v1.bounds.maxY))
        //pathOut.addArc(withCenter: CGPoint(x: bounds.maxX, y: bounds.maxY), radius: bounds.maxY, startAngle: 0, endAngle: .pi/2, clockwise: false)
        
        pathOut.addArc(withCenter: CGPoint(x: v1.bounds.width, y: v1.bounds.height), radius: v1.bounds.width, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + beta).degreesToRadians), clockwise: true)
        pathOut.addLine(to: CGPoint(x: v1.bounds.maxX, y: v1.bounds.maxY))
        pathOut.fill()
        pathOut.close()
        
        let pathIn = UIBezierPath()
        pathIn.move(to: CGPoint(x: v1.bounds.maxX, y: v1.bounds.maxY))
        pathIn.addLine(to: CGPoint(x: 16, y: v1.bounds.maxY))
        //pathIn.addArc(withCenter: CGPoint(x: bounds.maxX, y: bounds.maxY), radius: bounds.maxY - 6, startAngle: 0, endAngle: .pi/2, clockwise: true)
        pathIn.addArc(withCenter: CGPoint(x: v1.bounds.width, y: bounds.height), radius: v1.bounds.width-8, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + beta).degreesToRadians), clockwise: true)
        pathIn.addLine(to: CGPoint(x: v1.bounds.maxX, y: v1.bounds.maxY))
        pathIn.fill()
        pathIn.close()
        
        pathIn.append(pathOut)
        pathIn.usesEvenOddFillRule = true
        
        //        /design path in layer
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = pathIn.cgPath
        shapeLayer3.fillRule = .evenOdd
        shapeLayer3.strokeColor = UIColor.brown.cgColor
        shapeLayer3.fillColor = UIColor.brown.cgColor
        shapeLayer3.lineWidth = 0
        
        v1.layer.mask = shapeLayer3
        
    }
}

