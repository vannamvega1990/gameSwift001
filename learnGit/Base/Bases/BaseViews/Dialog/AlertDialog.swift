//
//  AlertDialog.swift
//  eDong3
//
//  Created by iAm2r on 5/26/17.
//  Copyright © 2017 ECPay. All rights reserved.
//

import UIKit

class AlertDialog: UIView {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
    var closeBlock: (()->())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let objects = Bundle.main.loadNibNamed("AlertDialog", owner: self, options: nil)
        var view: UIView? = nil
        for object in objects! {
            if (object as AnyObject).isKind(of: UIView.self) {
                view = object as? UIView
                break
            }
        }
        
        if view != nil {
            view?.frame = frame
            addSubview(view!)
        }
        
        layer.cornerRadius = 4
        lbContent.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            layoutIfNeeded()
            let btnOkFrame = btnOk.frame
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: btnOkFrame.origin.y + btnOkFrame.height + 20)
            self.subviews[0].frame = CGRect(x: 0, y: 0, width: self.frame.width, height: btnOkFrame.origin.y + btnOkFrame.height + 20)
        }
    }
    
    @IBAction func buttonCloseTapped() {
        if closeBlock != nil {
            closeBlock!()
        }
    }
}
