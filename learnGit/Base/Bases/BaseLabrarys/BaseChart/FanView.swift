//
//  FanView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIView{
    var globalPoint :CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame :CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}

extension UIView {
    func setAnchorPoint1(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}

@IBDesignable
class CircleGraphView1: BaseView {
    let array:[Double] = [10,50,30,10] // phần trăm
    let arrayColor:[UIColor] = [.red,.orange,.white, .brown,.red,.orange,.white, .brown,.red,.orange,.white, .brown]
    override func layoutSubviews() {
        super.layoutSubviews()
        let arrayDegree: [Double] = array.map { (e) -> Double in
            e*360/100
        }
        
        let doArray: [Double] = [30, 45, 45, 80, 30, 45, 45, 40]
        var goc: Double = 0
        for i in 0...7{
            let sub = FanView()
            sub.backgroundColor = .clear
            sub.frame = CGRect(x: frame.origin.x, y: frame.origin.y + bounds.height/2 - bounds.height/2 , width: bounds.width/2, height: bounds.height/2)
                //CGRect(x: 0, y: 0, width: 98, height: 98)
            //frame: CGRect(origin: center.moveToPoint(dx: bounds.width/2, dy: center.y - hei), size: CGSize(width: bounds.width/2, height: hei))
            sub.fillColor = arrayColor[i]
            sub.degreeWant = doArray[i]
            //sub.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
            
            //let frame = sub.globalFrame!
            //sub.frame = frame
            superview?.addSubview(sub)
            //addSubview(sub)
            //sub.setAnchorPoint(anchorPoint: CGPoint(x: 0, y: 0))
            sub.setAnchorPoint1(CGPoint(x: 1, y: 1))
            //let alpha = arrayDegree[i].degreesToRadians
            //sub.transform = CGAffineTransform(rotationAngle: CGFloat(alpha))
            //sub.transform = CGAffineTransform(rotationAngle: (.pi/4) * CGFloat(i))
            if i >= 1 && i <= 3 {
                
                //if goc > 180 {
                    //goc = 0
                    //goc = goc - doArray[i-1]
                    //sub.transform = CGAffineTransform(rotationAngle:  -.pi/2)
                    //sub.transform = CGAffineTransform(rotationAngle: .pi + .pi/3)
                //}else {
                    goc = goc + doArray[i-1]
                    sub.transform = CGAffineTransform(rotationAngle:  CGFloat(goc.degreesToRadians))
                //}
                
            }
            else if i == 4 {
                goc = goc + doArray[3]
                //sub.transform = CGAffineTransform(rotationAngle: .pi + .pi/3)
                sub.transform = CGAffineTransform(rotationAngle:  CGFloat(goc.degreesToRadians))
            }
            else if i == 5 {
                goc = goc + doArray[4]
                //sub.transform = CGAffineTransform(rotationAngle: .pi + .pi/3)
                sub.transform = CGAffineTransform(rotationAngle:  CGFloat(goc.degreesToRadians))
            }
            else if i == 6 {
                goc = goc + doArray[5]
                //sub.transform = CGAffineTransform(rotationAngle: .pi + .pi/3)
                sub.transform = CGAffineTransform(rotationAngle:  CGFloat(goc.degreesToRadians))
            }
            else if i == 7 {
                goc = goc + doArray[6]
                //sub.transform = CGAffineTransform(rotationAngle: .pi + .pi/3)
                sub.transform = CGAffineTransform(rotationAngle:  CGFloat(goc.degreesToRadians))
            }
        }
        
        //sub.rotate(digree: CGFloat(45.degreesToRadians))
//        sub.rotateAnimation(time: 3)
        
//        let sub1 = FanView()
//        sub1.frame = bounds
//            //CGRect(x: 0, y: 0, width: 98, height: 98)
//        //frame: CGRect(origin: center.moveToPoint(dx: bounds.width/2, dy: center.y - hei), size: CGSize(width: bounds.width/2, height: hei))
//        sub1.fillColor = arrayColor[2]
//        sub1.degreeWant = 56
//        //sub.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
//        addSubview(sub1)
//        sub1.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
//        sub1.rotate(digree: CGFloat(56.degreesToRadians))
        
        //sub.rotate(digree: CGFloat(each.degreesToRadians))
        
//        for (key,each) in arrayDegree.enumerated() {
//            let goc: Double = each
//            let sin1 = sin(goc)
//            let hei = (bounds.width/2) * CGFloat(sin1)
//            let sub = FanView()
//            sub.frame = CGRect(x: 0, y: 0, width: 98, height: 98)
//            //frame: CGRect(origin: center.moveToPoint(dx: bounds.width/2, dy: center.y - hei), size: CGSize(width: bounds.width/2, height: hei))
//            sub.fillColor = arrayColor[key]
//            sub.degreeWant = each
//            sub.setAnchorPoint(anchorPoint: CGPoint(x: 1, y: 0))
//            sub.rotate(digree: CGFloat(each.degreesToRadians))
//            addSubview(sub)
//
//        }
    }
    
}

@IBDesignable
class FanView: UIView {
    
    var fillColor = UIColor.red
    var degreeWant: Double = 46
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius:CGFloat = 96
        let startAngle = CGFloat.pi/2
        let endAngle: CGFloat = 0
        let centerPoint = CGPoint(x: 36, y: 36)
        
        let strokeColor = UIColor.green
        let lineWidth: CGFloat = 6
        
        
        
        let bezierPath = UIBezierPath()
        
        let dx = radius*cos(startAngle)
        let dy = radius*sin(startAngle)
        let p = CGPoint(x: centerPoint.x + dx, y: centerPoint.y + dy)
        bezierPath.move(to: centerPoint)
        bezierPath.addLine(to: p)
        bezierPath.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        bezierPath.addLine(to: centerPoint)
        
        let bezierPath2 = UIBezierPath()
        bezierPath2.move(to: CGPoint(x: bounds.width, y: bounds.height))
        bezierPath2.addLine(to: bezierPath2.currentPoint.moveToPoint(dx: -bounds.width, dy: 0))
        bezierPath2.addArc(withCenter: CGPoint(x: bounds.width, y: bounds.height), radius: bounds.width, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + degreeWant).degreesToRadians), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath2.cgPath
            //UIBezierPath(rect: bounds).cgPath
            //bezierPath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        
        layer.addSublayer(shapeLayer)
        let text = UILabel()
        text.font = .systemFont(ofSize: 16)
        text.text = "20%"
        text.textColor = .white
        let yPos = bounds.width*CGFloat(sin(degreeWant.degreesToRadians))
        text.frame = CGRect(x: 18, y: bounds.height - yPos/2 - text.heightWrap/2, width: text.widthWrap, height: text.heightWrap)
        text.textAlignment = .center
        addSubview(text)
       // drawACorner(radius: 98, centerPoint: <#T##CGPoint#>, lineWidth: <#T##CGFloat#>, fillColor: <#T##UIColor#>, strokeColor: <#T##UIColor#>, startAngle:  .pi, endAngle: .pi)
        //drawACorner(radius: 76, centerPoint: center, lineWidth: 3, fillColor: .green, strokeColor: .orange, startAngle: CGFloat.pi/2, endAngle: 0)
    }

}
