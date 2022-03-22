//
//  ViewOptionRegister.swift
//  FinTech
//
//  Created by Tu Dao on 5/10/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewOptionRegister: FTBaseView {
    
    @IBOutlet weak var stack: UIStackView!

    override init(frame:CGRect){
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    var actionLoginWithGoole:(()->Void)?
    var actionLoginWithFacebook:(()->Void)?
    var actionLoginWithApple:(()->Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.subviews.forEach { (v:UIView) in
            if let v1 = v as? FTBaseViewImageWithLabel{
                v1.indexPath = IndexPath(row: 1, section: 1)
                v1.actionClosure = { indexPath in
                    self.goNext(index: v1.tag)
                }
            }
        }
    }
    func goNext(index: Int){
        if let currentVC = currentVC as? StartViewController {
            currentVC.removePopup()
            let regisWithPhoneNumberVC = StreechRegisterViewController()//RegisterViewController()
            let regisWithSocialVC = CompleteRegisterBySocialVC()
            let vc = index == 0 ? regisWithPhoneNumberVC : regisWithSocialVC
            
            if index == 0 {
                currentVC.pushToViewController(vc, true)
            }else if index == 3{
                actionLoginWithGoole?()
            }else if index == 2{
                actionLoginWithFacebook?()
            }else{
                actionLoginWithApple?()
            }
        }
    }
    private func config(){
        guard let view = self.FTloadViewFromNib(nibName: "ViewOptionRegister") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }

}
