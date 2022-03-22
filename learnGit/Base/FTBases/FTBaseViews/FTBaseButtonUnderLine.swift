//
//  FTBaseButtonUnderLine.swift
//  FinTech
//
//  Created by Tu Dao on 5/11/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseButtonUnderLine: UIButton {
    
    @IBInspectable var showUnderLine: Bool = false{
        didSet{
            //backgroundColor = .red
            //            NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:@"The Quick Brown Fox"];
            //
            //            [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
            //
            //            [button setAttributedTitle:commentString forState:UIControlStateNormal];
            let txt = titleLabel?.text
            let commentString = NSMutableAttributedString(string: txt ?? "")
            commentString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue], range: NSRange(location: 0,length: commentString.length))
            setAttributedTitle(commentString, for: UIControl.State.normal)
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}

