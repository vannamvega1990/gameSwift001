//
//  TPToastView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//
import UIKit

class TPToastView: BaseView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var maxWidth: NSLayoutConstraint!
    @IBOutlet weak var minWidth: NSLayoutConstraint!
    @IBOutlet weak var topDistance: NSLayoutConstraint!
    
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
        //let topMargin = label.topConstraint
        //rootView.layer.cornerRadius = (label.bounds.size.height + 2*topDistance.constant)/2
    }

    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "TPToastView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        maxWidth.constant =  windowFix.bounds.width - 96   //sizeScreen.width - 96
        //configs()
    }
}
