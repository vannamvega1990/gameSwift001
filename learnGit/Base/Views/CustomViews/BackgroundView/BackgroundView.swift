//
//  BackgroundView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    
    let bezierPath = UIBezierPath()
    //let data = [CGPoint(x: 60, y: 150), CGPoint(x: 140, y: 300),CGPoint(x: 230, y: 140), CGPoint(x: 310, y: 250), CGPoint(x: 390, y: 100), CGPoint(x: 490, y: 200), CGPoint(x: 580, y: 270),CGPoint(x: 650, y: 30) ]
    
    var data = Array<CGPoint>()
    

    /// An array of structs representing the segments of the pie chart
    var segments = [Segment]() {
        didSet {
            setNeedsDisplay() // re-draw view when the values get set
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func createPoints() {
        for point in data {
          let circleLayer = CAShapeLayer()
          circleLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
          circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
          circleLayer.fillColor = UIColor.red.cgColor
          circleLayer.position = point
          layer.addSublayer(circleLayer)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        //data = [CGPoint(x: 0, y: bounds.height), CGPoint(x: bounds.width/4, y: bounds.height - 56) , CGPoint(x: bounds.width*3/4, y: bounds.height), CGPoint(x: bounds.width, y: bounds.height - 96)]
        
        data = [CGPoint(x: 0, y: bounds.height), CGPoint(x: bounds.width/4, y: bounds.height - bounds.height/12) , CGPoint(x: bounds.width*3/4, y: bounds.height), CGPoint(x: bounds.width, y: bounds.height - bounds.height/5)]
        
        let config = BezierConfiguration()
        let controlPoints = config.configureControlPoints(data: data)
        
        
        //createPoints()
        
        let dx = bounds.width/3
        let dy = bounds.height/3
        let dy_below: CGFloat = 76
        
        
        
        
        
        for i in 0..<data.count {
            let point = data[i]
            if i == 0 {
                bezierPath.move(to: point)
            }else {
                let segment = controlPoints[i - 1]
                bezierPath.addCurve(to: point, controlPoint1: segment.firstControlPoint, controlPoint2: segment.secondControlPoint)
            }
        }
        
        //bezierPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - dy_below))
        bezierPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        bezierPath.addLine(to: CGPoint(x: dx, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: dy))
        bezierPath.addLine(to: data[0])
        bezierPath.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = 0
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0.0
//        animation.toValue = 1.0
//        animation.duration = 2.5
//
//        shapeLayer.add(animation, forKey: "drawKeyAnimation")


//        let ctx = UIGraphicsGetCurrentContext()
//        let radius = min(frame.size.width, frame.size.height) * 0.5
//        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
//        let valueCount = segments.reduce(0, {$0 + $1.value})
//        var startAngle = -CGFloat.pi * 0.5
//        ctx?.setFillColor(UIColor.orange.cgColor)
//        let dx = 36
//        let dy = 36
//        let dy_below: CGFloat = 76
//        ctx?.move(to: CGPoint(x: 0, y: dy))
//        ctx?.addLine(to: CGPoint(x: dx, y: 0))
//        ctx?.addLine(to: CGPoint(x: bounds.width, y: 0))
//        ctx?.addLine(to: CGPoint(x: bounds.width, y: bounds.height - dy_below))
//        ctx?.addCurve(to: CGPoint(x: bounds.width/2, y: bounds.height - 18), control1: CGPoint(x: bounds.width - 36, y: bounds.height - 12), control2: CGPoint(x: bounds.width - 56, y: bounds.height - 12))
//        //ctx?.addQuadCurve(to: CGPoint(x: bounds.width/2, y: bounds.height - 57), control: CGPoint(x: bounds.width - 26, y: bounds.height))
//        ctx?.addCurve(to: CGPoint(x: 0, y: bounds.height - 12), control1: CGPoint(x: ctx!.currentPointOfPath.x - 56, y: ctx!.currentPointOfPath.y - 56), control2: CGPoint(x: 18, y: bounds.height))
//        ctx?.fillPath()

    }
}

