//
//  MessageView1.swift
//  Download98
//
//  Created by Eric Petter on 3/5/21.
//  Copyright © 2021 petter. All rights reserved.
//

import UIKit

class MessageView1: UIView {
    

    @IBOutlet weak var infoLabel: UILabel!
    
   
    override init(frame rec:CGRect){
        super.init(frame:rec)
        //commonInit()
        let _ = loadViewFromNib()
    }
    
    required init?(coder v:NSCoder){
        super.init(coder:v)
        //commonInit()
        let _ = loadViewFromNib()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func didAddSubview(_ subview: UIView) {
        //self.txtOld = self.textfild.text
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "MessageView1", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        view.layer.cornerRadius = 8
        addSubview(view)
        return view
        
    }

}

