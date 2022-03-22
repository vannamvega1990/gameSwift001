//
//  FTBaseAnimation.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BaseAnimation {

    var bezierPath = UIBezierPath()
    var layer = CALayer()
    
    // animation path, animation stroke -------------------------
    func animationPath(){
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = .none
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 2.5
        shapeLayer.add(animation, forKey: "drawKeyAnimation")
    }
    


}

extension UIView {
    // add Scale Animation (from, to: 0--> 1) ------------------------
    func addScaleAnimation (time: Double, from:Int,to:Int, key:String) -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 0.5)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = time
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        layer.add(scaleAnimation, forKey: key)
        return scaleAnimation
    }
    
    // add Scale Animation Key Frame (values = [0.8, 0.3, 3], keyTimes = [0, 0.2, 1]) ------------------------
    func addScaleAnimationKeyFrame (_ time: Double, _ values:[Int],_ keyTimes:[Int],_ autoreverses:Bool,_ repeatCount: Float, key:String) -> CAKeyframeAnimation {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.values = [0.8, 0.3, 3]
        scaleAnimation.keyTimes = [0, 0.2, 1]
        scaleAnimation.duration = time
        scaleAnimation.autoreverses = autoreverses
        scaleAnimation.repeatCount = repeatCount
        layer.add(scaleAnimation, forKey: key)
        return scaleAnimation
    }
    // move view on a path ----------------------
    func moveViewOnThePath(path:UIBezierPath, key:String){
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 15
        animation.repeatCount = 6
        animation.path = path.cgPath
        animation.calculationMode = CAAnimationCalculationMode.paced
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: key)
    }
    // add moving animation ---------------------
    func addMovingAniamation(startPoint: CGPoint,toPoint: CGPoint, key: String ){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 1
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: startPoint)
        animation.toValue = NSValue(cgPoint: toPoint)
        layer.add(animation, forKey: key)
    }
    // rotate animation uiview ----------------------
    func rotateAnimation(time:Double) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = time
        rotation.isCumulative = true
        rotation.repeatCount = .infinity // repeat vo cung
        //layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 1))
        layer.add(rotation, forKey: "rotationAnimation")
    }
    
//    func createOpacityAnimation() -> CAKeyframeAnimation {
//
//        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
//        opacityAnimation.duration = animationDuration
//        opacityAnimation.values = [0.4, 0.8, 0]
//        opacityAnimation.keyTimes = [0, 0.2, 1]
//
//
//        return opacityAnimation
//    }
    
    // simple animation have key frame --------------
    func addSimpleAnimation(time: TimeInterval, delay: TimeInterval, options: KeyframeAnimationOptions, action: (()->Void)?, completion: ((Bool)->Void)?){
        
        UIView.animateKeyframes(withDuration: time, delay: delay, options: options, animations: {
            action?()
        }) { (comple: Bool) in
            completion?(comple)
        }
    }
    
    // animation damping -------------
    func addDampingAnimation(time: TimeInterval = 1, delay: TimeInterval = 0, damping: CGFloat = 16, velocity: CGFloat = 16,options: UIView.AnimationOptions = .curveEaseIn , action: (()->Void)?, completion: ((Bool)->Void)? ){
        UIView.animate(withDuration: time, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
            action?()
        }, completion: { (comple: Bool) in
            completion?(comple)
        })
    }
}

extension CAGradientLayer {
    // add animation gradient, animation color and locations ---------------
    func addGradientAnimation(key: String){
        //let fromColor = [ UIColor.white.cgColor, UIColor.lightGray.cgColor,UIColor.gray.cgColor]
        //let toColors: [AnyObject] = [UIColor.gray.cgColor, UIColor.lightGray.cgColor, UIColor.white.cgColor]
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "locations")
        animation.duration = 1
        animation.autoreverses = true
        animation.fromValue = [0.0,0.2,1.0] //fromColor
        animation.toValue = [1,1,1.0] //toColors
        animation.repeatCount = .infinity
        add(animation, forKey:key)
    }
}
