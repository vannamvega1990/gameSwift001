//
//  TPFaceIDView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPFaceIDView: BaseView {

    var rootView = UIView()
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configs()
    }
    
    var actionCancel: (()->Void)?
    var actionOK: (()->Void)?
    
    @IBAction func btnOKPressed(_ sender: UIButton) {
        actionOK?()
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        actionCancel?()
    }
    
    private func configs(){
        guard let view = self.FTloadViewFromNib(nibName: "TPFaceIDView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
    }
    
}
