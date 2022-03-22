//
//  ListAssetView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class ListAssetView: BaseView {
    
   
    
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
       
    }
    
    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "ListAssetView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
    }
}
