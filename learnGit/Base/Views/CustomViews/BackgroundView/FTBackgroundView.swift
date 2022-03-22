//
//  FTBackgroundView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBackgroundView: UIView {
    
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
            let backgroundView = BackgroundView()
            backgroundView.frame = bounds
            backgroundView.segments = [
                Segment(color: .red, value: 57),
                Segment(color: .blue, value: 30),
                Segment(color: .green, value: 25),
                Segment(color: .yellow, value: 40)
            ]
            addSubview(backgroundView)
        }
    
    private func cauhinh(){
        //backgroundColor = .red
    }
}
