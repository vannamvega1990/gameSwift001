//
//  UIView+Extension.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UIView {
    // retrieves all constraints that mention the view
    func getAllConstraints() -> [NSLayoutConstraint] {
        // array will contain self and all superviews
        var views = [self]
        // get all superviews
        var view = self
        while let superview = view.superview {
            views.append(superview)
            view = superview
        }
        // transform views to constraints and filter only those
        // constraints that include the view itself
        return views.flatMap({ $0.constraints }).filter { constraint in
            return constraint.firstItem as? UIView == self ||
                constraint.secondItem as? UIView == self
        }
    }
    
    // retrieves all constraints that mention the view
    func getAllConstraintsCustom(viewArray:[UIView]) -> [NSLayoutConstraint] {
        // array will contain self and all superviews
        var views = [self]
        var view = self
        views.append(contentsOf: viewArray)
        while let superview = view.superview {
            views.append(superview)
            view = superview
        }
        return views.flatMap({ $0.constraints }).filter { constraint in
            return constraint.firstItem as? UIView == self ||
                constraint.secondItem as? UIView == self
        }
    }
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var centerYConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .centerY && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var topConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .top && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var bottomConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .bottom && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    var leftConstraint: NSLayoutConstraint? {
        get {
            return getAllConstraints().first(where: {
                $0.firstAttribute == .left && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}

extension UIView
{
    // Copy a uiview --------------------------------
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
    // set mark --------------------
    func setMark(shape:CAShapeLayer){
        layer.mask = shape
        clipsToBounds = true
    }
    // add shadow view ------------------------------
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.orange.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    // set anchor point --------------
    func setAnchorPointFix(_ point: CGPoint) { // chuan
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
    func setAnchorPoint(anchorPoint:CGPoint){
        layer.anchorPoint = anchorPoint
    }
    // contranint by code ----------------
    func setConstraintByCode(constraintArray:[NSLayoutConstraint]){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintArray)
    }
    // scale uiview -------------------
    func scale(scaleX: CGFloat, scaleY: CGFloat){
        //transform = CGAffineTransformScale(CGAffineTransformIdentity, 2, 2);
        transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
    }
    // move views to other position ----------------------
    func moveToPoint(translationX: CGFloat, translationY: CGFloat){
        transform = CGAffineTransform(translationX: translationX, y: translationY)
    }
    // rotate view -------------------------
    func rotate(digree: CGFloat){
        transform = CGAffineTransform(rotationAngle: digree)
    }
    
    // draw points, vẽ các điểm cho trước lên view ------------------
    func drawPoints(_ points: [CGPoint], _ colorPoint: UIColor = .red, _ sizePoint: CGFloat = 10) {
        for point in points {
            let circleLayer = CAShapeLayer()
            circleLayer.bounds = CGRect(x: 0, y: 0, width: sizePoint, height: sizePoint)
            circleLayer.path = UIBezierPath(ovalIn: circleLayer.bounds).cgPath
            circleLayer.fillColor = colorPoint.cgColor  //UIColor.red.cgColor
            circleLayer.position = point
            layer.addSublayer(circleLayer)
        }
    }
    // draw a path via poins, vẽ đường thẳng đi qua các điểm cho trước --------------
    func drawPathViaPoints(_ points: [CGPoint], lineWidth: CGFloat, lineColor:UIColor, _ showPoint:Bool = true) -> (CAShapeLayer, UIBezierPath) {
        if showPoint{
            drawPoints(points)
        }
        let bezierPath = UIBezierPath()
        for i in 0..<points.count {
            let point = points[i]
            if i == 0 {
                bezierPath.move(to: point)
            }else {
                bezierPath.addLine(to: points[i])
            }
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        return (shapeLayer, bezierPath)
    }
    
    // draw a shape via poins, vẽ hình đi qua các điểm cho trước --------------
    func drawShapeViaPoints(_ points: [CGPoint], lineWidth: CGFloat, lineColor:UIColor, fillColor:UIColor, _ showPoint:Bool = true, _ settingMark: Bool = false) -> (CAShapeLayer, UIBezierPath) {
        if showPoint{
            drawPoints(points)
        }
        let bezierPath = UIBezierPath()
        for i in 0..<points.count {
            let point = points[i]
            if i == 0 {
                bezierPath.move(to: point)
            }else {
                bezierPath.addLine(to: points[i])
            }
        }
        bezierPath.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineCap = .round
        //layer.addSublayer(shapeLayer)
        if settingMark {
            setMark(shape: shapeLayer)
            clipsToBounds = true
        }else{
            layer.addSublayer(shapeLayer)
        }
        return (shapeLayer, bezierPath)
    }
    
    // draw a shape via poins, vẽ hình đi qua các điểm cho trước và set mark --------------
    func drawShapeViaPointsAndMark(_ points: [CGPoint], lineWidth: CGFloat, lineColor:UIColor, fillColor:UIColor, _ showPoint:Bool = true){
        let _ = drawShapeViaPoints(points, lineWidth: lineWidth, lineColor: lineColor, fillColor:fillColor, showPoint, true)
        let _ = drawShapeViaPoints(points, lineWidth: lineWidth, lineColor: lineColor, fillColor:fillColor, showPoint, false)
    }
    
    // draw a circle, vẽ vòng tròn, đường tròn ---------------------
    func drawAnCircle(radius:CGFloat, centerPoint:CGPoint, lineWidth:CGFloat, fillColor:UIColor,
                      strokeColor: UIColor, settingMark: Bool = false) -> (CAShapeLayer, UIBezierPath){
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth        
        
        //layer.addSublayer(shapeLayer)
        
        if settingMark {
            setMark(shape: shapeLayer)
            clipsToBounds = true
        }else{
            layer.addSublayer(shapeLayer)
        }
        return (shapeLayer, circlePath)
    }
    
    // draw a fan, vẽ góc quạt, vẽ 1 góc đơn vị là pi -------------------------
    func drawACorner(radius:CGFloat, centerPoint:CGPoint, lineWidth:CGFloat, fillColor:UIColor,
                     strokeColor: UIColor,startAngle: CGFloat, endAngle: CGFloat ) -> (CAShapeLayer, UIBezierPath){
        let bezierPath = UIBezierPath()
        let dx = radius*cos(startAngle)
        let dy = radius*sin(startAngle)
        let p = CGPoint(x: centerPoint.x + dx, y: centerPoint.y + dy)
        bezierPath.move(to: centerPoint)
        bezierPath.addLine(to: p)
        bezierPath.addArc(withCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        bezierPath.addLine(to: centerPoint)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        layer.addSublayer(shapeLayer)
        return (shapeLayer, bezierPath)
    }
    
    // draw a rectange, vẽ hình vuông, vẽ hình chữ nhật ---------------------
    func drawARectange(roundedRect:CGRect, cornerRadius:CGFloat, lineWidth:CGFloat, fillColor:UIColor, strokeColor: UIColor, dash:[NSNumber] = [2,3], settingMark: Bool = false) -> (CAShapeLayer, UIBezierPath) {
        let rectangepath = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        //let  dashes: [ CGFloat ] = [ 16.0, 32.0 ]
        //rectangepath.setLineDash(dashes, count: dashes.count, phase: 0.0)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = rectangepath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = dash   //  [2,3]
        if settingMark {
            setMark(shape: shapeLayer)
            clipsToBounds = true
        }else{
            layer.addSublayer(shapeLayer)
        }
        return (shapeLayer, rectangepath)
    }
    
    // add a dash line ---------------------
    func createDashLine(color: UIColor) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = bounds.height
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: bounds.height/2),
                                CGPoint(x: bounds.width, y: bounds.height/2),
                                ])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    // draw a rectange, vẽ hình tam giác ---------------------
    func drawATriangle(poit1:CGPoint, poit2:CGPoint, poit3:CGPoint, lineWidth:CGFloat, fillColor:UIColor, strokeColor: UIColor, enable: Bool = true) -> (CAShapeLayer, UIBezierPath) {
        let path = UIBezierPath()
        path.move(to: poit1)
        path.addLine(to: poit2)
        path.addLine(to: poit3)
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        layer.addSublayer(shapeLayer)
        return (shapeLayer, path)
    }
    
    // add gradient to view, location [0.0 --> 1.0] --------------------------
    func setGradientBackground(colors: [UIColor], locations: [NSNumber], isVertical: Bool) -> CAGradientLayer {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let colorArray = colors.map { (color) -> CGColor in
            return color.cgColor
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.colors = colorArray
        gradientLayer.locations = locations//[0.0, 1.0]
        if isVertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }        
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at:0)
        return gradientLayer
    }
    
    // add circle gradient to view, location [0.0 --> 1.0] --------------------------
    func setGradientCircleBackground(colors: [UIColor], locations: [NSNumber], isVertical: Bool) {
        let g = CAGradientLayer()
        g.type = .radial
        let colorArray = colors.map { (color) -> CGColor in
            return color.cgColor
        }
        g.colors = colorArray
        g.locations = locations
        g.startPoint = CGPoint(x: 0.5, y: 0.5)
        g.endPoint = CGPoint(x: 1, y: 1)
        g.frame = bounds
        layer.insertSublayer(g, at:0)
    }
    
    // add view to full screen, add to window, add to all screen ---------------
    func addToAllScreen()  {
        //let window = UIApplication.shared.keyWindow!
        //self.frame = window.bounds
        windowFix.addSubview(self)
    }
    
    // set boder and shadow stander for uiview------------------
    func setBoderAndShadowStander(){
        //let view = UIView(frame: CGRect(x: 50, y: 0, width: 60, height: 60))
        layer.cornerRadius  = 15
        backgroundColor     = UIColor.white
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset  = CGSize.zero
        layer.shadowRadius  = 5
    }
    
    // add tap gesture ------------------------
    func addTapGesture(action: Selector?) -> UITapGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        if self is UIImageView {
           isUserInteractionEnabled = true
        }
        addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer
    }
    
    // add pan gesture ------------------------
    func addPanGesture(action: Selector?) -> UIPanGestureRecognizer {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: action)
        if self is UIImageView {
           isUserInteractionEnabled = true
        }
        addGestureRecognizer(panGestureRecognizer)
        return panGestureRecognizer
    }
    
    // add swipe gesture ------------------------
    func addSwipeGesture(action: Selector?) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: action)
        if self is UIImageView {
           isUserInteractionEnabled = true
        }
        addGestureRecognizer(swipeGestureRecognizer)
        return swipeGestureRecognizer
    }
    // remove gesture ------------------------
    func removeGesture(gesture: UIGestureRecognizer){
        removeGestureRecognizer(gesture)
    }
    
    
    
}


