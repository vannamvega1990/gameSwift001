//
//  TestView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 6/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TestView: BaseView {
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }

    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "TestView") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }
}


