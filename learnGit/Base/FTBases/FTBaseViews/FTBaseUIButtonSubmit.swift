//
//  FTBaseUIButtonSubmit.swift
//  FinTech
//
//  Created by Tu Dao on 5/6/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseUIButtonSubmit: UIButton {
    
    @IBInspectable var name: String{
        set{
            setTitle(newValue, for: .normal)
        }
        get{
            return ""
        }
    }
    
    @IBInspectable var radius: CGFloat{
        set{
            //textfield.clipsToBounds = true
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var defultColor: Bool{
        set{
            if newValue {
                backgroundColor = UIColor.orange
            }
        }
        get{
            return true
        }
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        //text = "Đăng nhập với tài khoản khác?"
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //text = "Đăng nhập với tài khoản khác?"
        //cofig()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //cofig()
    }
    
    
}

