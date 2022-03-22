//
//  FTBaseLabelUnderLine.swift
//  FinTech
//
//  Created by Tu Dao on 5/6/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseLabelUnderLine: UILabel {
    
    @IBInspectable var name: String{
        set{
            text = newValue
        }
        get{
            return text ?? ""
        }
    }
    
    //    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        print("touchesEnded")
    //        isHidden = false
    //    }
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //         print("touchesEnded")
    //        isHidden = true
    //    }
    //    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    //         print("touchesEnded")
    //        isHidden = false
    //    }
    
    @IBInspectable var showUnderLine: Bool{
        set{
            if newValue {
                cofig()
            }else{
                cofigNoUnderline()
            }
        }
        get{
            return true
        }
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        //text = "Đăng nhập với tài khoản khác?"
        cofig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //text = "Đăng nhập với tài khoản khác?"
        //cofig()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        
        print("tap working")
    }
    
    private func cofig(){
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: self.text ?? "", attributes: underlineAttribute)
        self.attributedText = underlineAttributedString
    }
    private func cofigNoUnderline(){
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: self.text ?? "", attributes: underlineAttribute)
        self.attributedText = underlineAttributedString
    }
}
