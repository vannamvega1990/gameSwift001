//
//  ExchangeChart.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TestStackView: UIStackView {
    func setup(){
                axis  = .horizontal
        distribution  = .fillEqually
                //alignment = .center
                spacing = 16
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let v1 = UIView()
        v1.backgroundColor = .green
        let v2 = UILabel()
        v2.text = "123"
        v2.textColor = .green
        
        addArrangedSubview(v1)
        addArrangedSubview(v2)
//        v1.setConstraintByCode(constraintArray: [
//            //v1.widthAnchor.constraint(equalToConstant: 16),
//            v1.heightAnchor.constraint(equalToConstant: bounds.height),
//        ])
//        v2.setConstraintByCode(constraintArray: [
//            //v2.widthAnchor.constraint(equalToConstant: 16),
//            v2.heightAnchor.constraint(equalToConstant: bounds.height),
//        ])
    }
}

@IBDesignable
class ExchangeChart: UIView {
    
    @IBOutlet weak var scrollY: UIScrollView!
    @IBOutlet weak var scrollX: UIScrollView!
    @IBOutlet weak var btn: UIButton!
   var rootView = UIView()
    
    var maxValueY = 120
    var stepY = 12
    var stepX = 16
    func changeStepX(){
        stepX += 2
        let vTongX = scrollX.subviews.first!
        vTongX.layer.sublayers?.forEach({ (layer) in
            if layer != vTongX.layer {
                layer.removeFromSuperlayer()
            }
            
        })
        
        
    }
    func addLineX(){
        let vTongX = scrollX.subviews.first!
        vTongX.backgroundColor = .white
        let pathY = UIBezierPath()
        pathY.move(to: CGPoint(x: 0, y: vTongX.bounds.height/2))
        pathY.addLine(to: CGPoint(x: vTongX.bounds.width, y: vTongX.bounds.height/2))
        let layerY = CAShapeLayer()
        layerY.path = pathY.cgPath
        layerY.fillColor = UIColor.clear.cgColor
        layerY.lineWidth = 1
        layerY.strokeColor = UIColor.red.cgColor
        vTongX.layer.insertSublayer(layerY, at: 0)
    }
    
    func addValueToX(){
        let vTongX = scrollX.subviews.first!
        vTongX.backgroundColor = .white
        
        let stackV = TestStackView(frame: CGRect(x: 0, y: 0, width: 126, height: 98))
        stackV.backgroundColor = .brown
//        stackV.axis = .horizontal
//        stackV.alignment  = .center
//        stackV.spacing = 6
//        stackV.distribution = .fillEqually
        
//        let v1 = UIView()
//        v1.backgroundColor = .green
//        let v2 = UILabel()
//        v2.text = "123"
//        v2.textColor = .green
        //v1.frame = CGRect(x: 0, y: 0, width: 16, height: stackV.bounds.height)
//        axis  = .horizontal
//        distribution  = .fill
//        alignment = .center
//        spacing = spacingFix
        
        
        vTongX.addSubview(stackV)
        
//        stackV.addArrangedSubview(v1)
//        stackV.addArrangedSubview(v2)
//        v1.setConstraintByCode(constraintArray: [
//            //v1.widthAnchor.constraint(equalToConstant: 16),
//            v1.heightAnchor.constraint(equalToConstant: 16),
//        ])
//        v2.setConstraintByCode(constraintArray: [
//            //v2.widthAnchor.constraint(equalToConstant: 16),
//            v2.heightAnchor.constraint(equalToConstant: 16),
//        ])
        //v1.setContentHuggingPriority(.defaultLow, for: .vertical)
//        for i in 1...98 {
//            let pathY = UIBezierPath()
//            pathY.move(to: CGPoint(x: CGFloat(stepX*i), y: vTongX.bounds.height/2 - 3))
//            pathY.addLine(to: CGPoint(x: CGFloat(stepX*i), y: vTongX.bounds.height/2 + 3))
//            let layerY = CAShapeLayer()
//            layerY.path = pathY.cgPath
//            layerY.fillColor = UIColor.clear.cgColor
//            layerY.lineWidth = 1
//            layerY.strokeColor = UIColor.red.cgColor
//            vTongX.layer.addSublayer(layerY)
//            let lb = UILabel()
//            lb.text = "\(i)"
//            lb.font = .systemFont(ofSize: 10)
//            lb.textColor = .red
//            lb.frame = CGRect(x: CGFloat(stepX*i), y: vTongX.bounds.height/2  + 5, width: lb.widthWrap, height: lb.heightWrap)
//            vTongX.addSubview(lb)
//        }
    }
    
    func addLineY(){
        let vTong = scrollY.subviews.first!
        let pathY = UIBezierPath()
        pathY.move(to: CGPoint(x: vTong.bounds.width/2, y: vTong.bounds.height))
        pathY.addLine(to: CGPoint(x: vTong.bounds.width/2, y: 0))
        let layerY = CAShapeLayer()
        layerY.path = pathY.cgPath
        layerY.fillColor = UIColor.clear.cgColor
        layerY.lineWidth = 1
        layerY.strokeColor = UIColor.red.cgColor
        vTong.layer.insertSublayer(layerY, at: 0)
    }
    
    func addValueToY(){
        let vTong = scrollY.subviews.first!
        vTong.backgroundColor = .white
        for i in 1...98 {
            let pathY = UIBezierPath()
            pathY.move(to: CGPoint(x: vTong.bounds.width/2 - 3, y: vTong.bounds.height - CGFloat(16*i)))
            pathY.addLine(to: CGPoint(x: vTong.bounds.width/2 + 3, y: vTong.bounds.height - CGFloat(16*i)))
            let layerY = CAShapeLayer()
            layerY.path = pathY.cgPath
            layerY.fillColor = UIColor.clear.cgColor
            layerY.lineWidth = 1
            layerY.strokeColor = UIColor.red.cgColor
            vTong.layer.addSublayer(layerY)
            let lb = UILabel()
            lb.text = "\(i)"
            lb.font = .systemFont(ofSize: 10)
            lb.textColor = .red
            lb.frame = CGRect(x: 0, y: vTong.bounds.height - CGFloat(16*i), width: lb.widthWrap, height: lb.heightWrap)
            vTong.addSubview(lb)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        addLineY()
        addValueToY()
        addLineX()
        addValueToX()
        
        
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configs()
    }
    
    func setTitle(title: String){
       
    }
    
    private func configs(){
        guard let view = self.FTloadViewFromNib(nibName: "ExchangeChart") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
    }

}

