//
//  TPRegisterStatementVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit



class TPRegisterStatementVC: TPBaseViewController {
    
    
    enum TypeNext {
        case goCreateNewPassword
        case other
        case defult
    }
    var typeNext: TypeNext = .defult
    
    @IBOutlet weak var tfEmail: TPBaseTextFieldWithLabel!
    @IBOutlet weak var btnRegister: TPBaseViewImageWithLabel!
    
    init() {
        super.init(nibName: "TPRegisterStatementVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func coordbustBase(_ data: Data?, _ respawn: URLResponse?, _ errur: Error?) {
        super.coordbustTPBase(data, respawn, errur)
        if code! != 0 {
            Commons.showDialogAlert(title: "THÔNG BÁO", content: self.sms!, inView: self.view, didFinishDismiss: nil)
        }else{
            Commons.showDialogAlert(title: "THÔNG BÁO", content: self.sms!, inView: self.view, didFinishDismiss: {
                status_is_register_statement_temp = true
                TPCakeDefaults.shared.status_is_register_statement = true
                self.popBackViewController(true)
            })
        }
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.disableIQKeyboard()
        btnRegister.indexPath = .init()
        btnRegister.actionClosure = {
            [weak self ] indexPath in
            guard let selfWeak = self else {
                return
            }
            if Commons.stringIsNilOrEmpty(str: selfWeak.tfEmail.text) {
                Commons.showDialogJK("Bạn chưa có email")
                return
            }
            if !selfWeak.tfEmail.text!.checkEmail(){
                Commons.showDialogJK("Email ko đúng định dạng")
                return
            }
            if status_verify_email {
                
                guard let access_token = TPCakeDefaults.shared.access_token else {
                    return
                }
                Commons.showLoading(selfWeak.view)
                TPNetworkManager.shared.requestRegisterStatement(access_token, selfWeak.coordbustBase)
            }else{
                Commons.showDialogConfirm(title: "ĐĂNG KÝ SAO KÊ", content: "Email chưa được xác thực", titleButton: "Xác thực") {
                    let vc = TPVerifyEmailVC()
                    vc.email = selfWeak.tfEmail.text
                    selfWeak.pushToViewController(vc, true)
                }
            }
        }
    
//        tfEmail.addCustomTPToolBar(title: "Đăng ký nhận sao kê", action: {
//            [weak self ]  in
//            guard let selfWeak = self else {
//                return
//            }
//            if Commons.stringIsNilOrEmpty(str: selfWeak.tfEmail.text) {
//                Commons.showDialogJK("Bạn chưa có email")
//                return
//            }
//            if !selfWeak.tfEmail.text!.checkEmail(){
//                Commons.showDialogJK("Email ko đúng định dạng")
//                return
//            }
//            if status_verify_email {
//                
//                guard let access_token = TPCakeDefaults.shared.access_token else {
//                    return
//                }
//                Commons.showLoading(selfWeak.view)
//                TPNetworkManager.shared.requestRegisterStatement(access_token, selfWeak.coordbustBase)
//            }else{
//                Commons.showDialogConfirm(title: "ĐĂNG KÝ SAO KÊ", content: "Email chưa được xác thực", titleButton: "Xác thực") {
//                    let vc = TPVerifyEmailVC()
//                    vc.email = selfWeak.tfEmail.text
//                    selfWeak.pushToViewController(vc, true)
//                }
//            }
//        })
        
        
        tfEmail.text = emailTemp//TPCakeDefaults.shared.email
        //if let isVerifyEmail = TPCakeDefaults.shared.isVerifyEmail {
            tfEmail.isEnabled = !status_verify_email
        //}
        //btnRegister.isHidden = tfEmail.isEnabled
        btnRegister.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AppDelegate.enableIQKeyboard()
    }
    
    
}


