//
//  TPConfirmView.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPConfirmView: UIView {
    
    @IBOutlet weak var btnNext: TPBaseViewImageWithLabel!
    var rootView = UIView()
    
    func setTitle(title: String){
        btnNext.txtTitle = title
    }
    @IBInspectable var setTitle: String = "" {
        didSet {
            btnNext.txtTitle = setTitle
        }
    }
    @IBInspectable var setBackground: UIColor = UIColor.white {
        didSet {
            rootView.backgroundColor = setBackground
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        configs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configs()
    }
    
    private func configs(){
        guard let view = self.FTloadViewFromNib(nibName: "TPConfirmView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
    }
    
}

