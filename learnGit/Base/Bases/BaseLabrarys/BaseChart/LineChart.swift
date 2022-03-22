//
//  LineChart.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//
import UIKit

@IBDesignable
class LineChart: UIStackView {
    
    @IBInspectable var spacingFix: CGFloat = 0 {
        didSet {
            spacing = spacingFix
        }
    }

    /// An array of structs representing the segments of the pie chart
    var segments: [Segment] = [Segment(color: .red, value: 10),
                               Segment(color: .green, value: 50),
                               Segment(color: .brown, value: 40)]{
        didSet {
            setNeedsDisplay() // re-draw view when the values get set
        }
    }

    private func setup(){
        axis  = .horizontal
        distribution  = .fill
        alignment = .center
        spacing = spacingFix
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        //backgroundColor = .brown
       
        
    }
    
    
    override func draw(_ rect: CGRect) {
        
//        let v = UIView()
//        v.backgroundColor = .red
//        let v2 = UIView()
//        v2.backgroundColor = .green
//        addArrangedSubview(v)
//        addArrangedSubview(v2)
//        v.setConstraintByCode(constraintArray: [
//            v.widthAnchor.constraint(equalToConstant: 98),
//            v.heightAnchor.constraint(equalToConstant: 12)
//        ])
//        
//        
//        
//        v2.setConstraintByCode(constraintArray: [
//            v2.widthAnchor.constraint(equalToConstant: 98),
//            v2.heightAnchor.constraint(equalToConstant: 12)
//        ])
        
        //self.addSubview(v)
//        let tong1 = segments.reduce(0.0) { (result, segment) -> CGFloat in
//            segment.value
//        }
        
        
        var total = segments.reduce(0.0, {(first: CGFloat, second: Segment) -> CGFloat in
            return first + second.value
        })
        let total2 = segments.reduce(0.0, {$0 + $1.value})
        
        for (key,each) in segments.enumerated() {
            let v = UIView()
            v.backgroundColor = each.color
            addArrangedSubview(v)
            
            
            var widthForEach:CGFloat?
            
            if key != segments.count-1{
                widthForEach = ((bounds.width - CGFloat((segments.count-1))*self.spacing)/total2) * each.value
                v.setConstraintByCode(constraintArray: [
                    v.widthAnchor.constraint(equalToConstant: widthForEach!),
                    v.heightAnchor.constraint(equalToConstant: bounds.height)
                ])
            }else{
                v.setConstraintByCode(constraintArray: [
                    v.heightAnchor.constraint(equalToConstant: bounds.height)
                ])
            }
            
        }

    }
}

