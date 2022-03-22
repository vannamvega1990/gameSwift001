//
//  CircleProgress.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/26/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class CircleProgress: UIView {
    
    private let progressLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        drawCircle()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(animation), userInfo: nil, repeats: true)
        
        //animateCircularProgress(duration: 0, toPosition: count)
    }
    var count: Float = 0.0
    @objc func animation(){
        count = count + 1
        print(count)
        showProgress(percent: count )
        //animateCircularProgress(duration: 0, toPosition: count)
        //progressLayer.strokeEnd += 0.1
    }
    
    fileprivate func drawCircle() {
        let centerPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        let radius = min(frame.size.width/2, frame.size.height/2)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let circlePath001 = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle:CGFloat((Double.pi * 3) / 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 6.0
        layer.addSublayer(shapeLayer)
        progressLayer.path = circlePath001.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 6
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.green.cgColor
        //UIColor(rgb: 0x009051).cgColor
        layer.addSublayer(progressLayer)
    }
    private func animateCircularProgress(duration: TimeInterval, toPosition value:CGFloat) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    func showProgress(percent: Float){
        progressLayer.strokeEnd = CGFloat((percent * 1.0) / 100)
    }
    
}
