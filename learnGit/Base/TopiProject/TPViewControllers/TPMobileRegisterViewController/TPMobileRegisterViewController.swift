//
//  TPMobileRegisterViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPMobileRegisterViewController: TPBaseViewController {
    
    var mobile = ""
    @IBOutlet weak var tpLissenView: TPLissenView!
    @IBOutlet weak var tfPassword: TPBaseTextField!
    @IBOutlet weak var tfName: TPBaseTextField!
    @IBOutlet weak var tfPhone: TPBaseTextField!
    @IBOutlet weak var tfEmail: TPBaseTextField!
    
    init() {
        super.init(nibName: "TPMobileRegisterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tpLissenView.btnNext.indexPath = IndexPath(row: 1, section: 1)
        tpLissenView.btnNext.actionClosure = { indexPath in
            self.goNext()
        }
    }
    
    @IBAction func btnEyePressed(_ sender: UIButton) {
        let isSecu = tfPassword.isSecureTextEntry
        tfPassword.isSecureTextEntry = !isSecu
        let imgName = !tfPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    func goNext(){
        let check = checkValidInput()
        if !check.0 {
        }else{
            Commons.showLoading(view)
            mobile = tfPhone.text!
            let password = tfPassword.text!
            let full_name = tfName.text!
            let email = tfEmail.text
            let device = "ios"
            TPNetworkManager.shared.requestRegister(mobile: mobile, password: password, full_name: full_name, email: email, device: device, coordbust)
        }
    }
}

extension TPMobileRegisterViewController {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                }
            }
            return
        }
        guard let data = data else {
            Commons.hideLoading(self.view)
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Server không phản hồi", inView: self.view, didFinishDismiss: nil)
            return
        }
        //let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                let vc = TPOTPViewController()
                vc.mobile = mobile
                vc.typeNext = .fromMobileRegister
                self.pushToViewController(vc, true)
            }
        }
    }
}


extension TPMobileRegisterViewController {
    func checkValidInput()->(Bool, String){
        let stringFullname = tfName.text
        let stringMobile = tfPhone.text
        let stringEmail = tfEmail.text
        let stringPassword = tfPassword.text
        
        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfName,tfPhone, tfPassword], sms: ["🔴 Họ tên không được để trống","🔴 Số điện thoại không được để trống", "🔴 Mật khẩu không được để trống"])
        if !check {
            return (false,"Textfild đang để trống.")
        }
        if stringFullname!.count < 3 {
            tfName.borderColor = .red
            showErrorBelowUITextfild(tf: tfName, sms: "🔴 Họ tên phải lớn hơn 3 ký tự.")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        if stringFullname!.count > 150 {
            tfName.borderColor = .red
            showErrorBelowUITextfild(tf: tfName, sms: "🔴 Họ tên không quá 150 ký tự.")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        if stringMobile!.count < 6 {
            tfPhone.borderColor = .red
            showErrorBelowUITextfild(tf: tfPhone, sms: "🔴 Số điện thoại phải lớn hơn 6 ký tự.")
            return (false,"Số điện thoại phải lớn hơn 6 ký tự.")
        }
        if !Commons.stringIsNilOrEmpty(str: stringEmail) && stringEmail!.count < 6 {
            tfEmail.borderColor = .red
            showErrorBelowUITextfild(tf: tfEmail, sms: "🔴 Email phải lớn hơn 6 ký tự.")
            return (false,"Email phải lớn hơn 6 ký tự.")
        }
        if stringPassword!.count < 6 {
            tfPassword.borderColor = .red
            //showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải lớn hơn 6 ký tự.")
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không đúng.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if stringPassword!.count > 30 {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không quá 30 ký tự.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if !stringPassword!.checkSpecialCharacter() {
            tfPassword.borderColor = .red
            //showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không đúng.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringPassword!.checkBigCharacter() {
            tfPassword.borderColor = .red
            //showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự in hoa.")
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không đúng.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringPassword!.checkHaveNumber() {
            tfPassword.borderColor = .red
            //showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 chữ số.")
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không đúng.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !Commons.stringIsNilOrEmpty(str: stringEmail) && !BaseCommons.checkEmail(str: stringEmail!){
            tfEmail.borderColor = .red
            showErrorBelowUITextfild(tf: tfEmail, sms: "🔴 Email không đúng định dạng.")
            return (false,"Email không đúng định dạng.")
        }
        return (true,"ok")
    }
}
