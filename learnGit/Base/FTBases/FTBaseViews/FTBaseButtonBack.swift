//
//  FBBaseButtonBack.swift
//  FinTech
//
//  Created by Tu Dao on 5/11/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseButtonBack: UIButton {
    
    var actionBackClosure:(()->Void)?
    
    @IBInspectable var icon: UIImage = UIImage() {
        didSet {
            setImage(icon, for: .normal)
        }
    }
    
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
        //backgroundColor = .red
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        actionBackClosure?()
        if let vc = self.getParentViewController() as? FTBaseViewController {
            vc.popBackViewController(true)
        }
    }
    private func cauhinh(){
        //backgroundColor = .red
    }
}
