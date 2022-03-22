//
//  BaseTabbarController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/3/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UITabBarController {
    func tabBarDissableTab(tab:Int){
        let arrayOfTabBarItems = self.tabBar.items
        
        if let barItems = arrayOfTabBarItems, barItems.count > 0 {
            let tabBarItem = barItems[tab]
            tabBarItem.isEnabled = false
        }
    }
    
    func tabBarEnable(tab:Int){
        let arrayOfTabBarItems = self.tabBar.items
        
        if let barItems = arrayOfTabBarItems, barItems.count > 0 {
            let tabBarItem = barItems[tab]
            tabBarItem.isEnabled = true
        }
    }
}

class BaseTabbarController: UITabBarController {

    // change offset of item -------------------------
    func changePositionOfItem(_ item: UITabBarItem, offsetY: CGFloat, offsetX: CGFloat ){
        item.titlePositionAdjustment = UIOffset(horizontal: offsetY, vertical: offsetX)
    }
    
    // add gradient for tabbar -----------------
    func setGradientForTabBar(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tabBar.bounds
        gradientLayer.colors = [UIColor(rgb: 0xFFFF39, alpha: 1).cgColor, UIColor(rgb: 0xFFFF39, alpha: 0.3).cgColor]
        //gradientLayer.colors = [UIColor.green.cgColor, UIColor.red.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBar.backgroundImage = image
        //tabBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
    
    // add background for tabbar -----------------
    func setBackgroundForTabBar(color: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tabBar.bounds
        gradientLayer.colors = [color.cgColor, color.cgColor]
        //gradientLayer.colors = [UIColor.green.cgColor, UIColor.red.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBar.backgroundImage = image
        //tabBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
    // add line -----------------
    func addLine(height: CGFloat, color: UIColor){
        let v = UIView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width, height: height)))
        v.backgroundColor = color
        tabBar.addSubview(v)
    }
    // custom shape for tabbar ------------------------
    func customShapeTabar(){
        tabBar.backgroundColor = .orange
        let data = [CGPoint(x: 0, y: 0), CGPoint(x: tabBar.bounds.width/2 - 35 - 16, y: 0) , CGPoint(x: tabBar.bounds.width/2, y: 45), CGPoint(x: tabBar.bounds.width/2 + 35 + 16, y: 0), CGPoint(x: tabBar.bounds.width, y: 0)]
        let config = BezierConfiguration()
        let controlPoints = config.configureControlPoints(data: data)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: .zero)
        bezierPath.addLine(to: CGPoint(x: tabBar.bounds.width/2 - 35 - 16, y: 0))
        bezierPath.addArc(withCenter: CGPoint(x: tabBar.bounds.width/2, y: 0), radius: 46, startAngle: -CGFloat.pi, endAngle: 0, clockwise: false)
        //bezierPath.addQuadCurve(to: CGPoint(x: tabBar.bounds.width/2 + 35 + 16, y: 0), controlPoint: CGPoint(x: tabBar.bounds.width/2, y: 80 + 16))
        bezierPath.addLine(to: data.last!)
        
        
        bezierPath.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBar.bounds.height))
        bezierPath.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        //bezierPath.addLine(to: CGPoint(x: 0, y: dy))
        bezierPath.addLine(to: data[0])
        bezierPath.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = 0
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.lineCap = .round
        tabBar.layer.mask = shapeLayer
        tabBar.clipsToBounds = true
    }
    
    // custom shape for tabbar ------------------------
    func customShapeTabar2(){
        
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = tabBar.bounds.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBar.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        path.close()
        
        
    }
}


@IBDesignable
class customShape2: UITabBar{
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.lineWidth = 0
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.lineCap = .round
        layer.mask = shapeLayer
    }
    func createPath() -> CGPath {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0)) // the beginning of the trough
        
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        
        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
}
