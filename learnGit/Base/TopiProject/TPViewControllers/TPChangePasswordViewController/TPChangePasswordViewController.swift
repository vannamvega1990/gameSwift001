//
//  TPChangePasswordViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPChangePasswordViewController: TPBaseViewController {

    @IBOutlet weak var tfPasswold: TPBaseTextField!
    @IBOutlet weak var tfNewPasswold: TPBaseTextField!
    @IBOutlet weak var tfReNewPasswold: TPBaseTextField!
    @IBOutlet weak var confirmView: TPConfirmView!
    
    init() {
        super.init(nibName: "TPChangePasswordViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changePassword(){
        let check = checkValidInput()
        if !check.0 {
        }else{
            if let access_token = TPCakeDefaults.shared.access_token {
                let password = tfPasswold.text!
                let newPassword = tfNewPasswold.text!
                Commons.showLoading(view)
                TPNetworkManager.shared.requestChangePassword(access_token,password,newPassword,coordbust)
            }
        }
    }
    
    @IBAction func btnEyePressed1(_ sender: UIButton) {
        let isSecu = tfPasswold.isSecureTextEntry
        tfPasswold.isSecureTextEntry = !isSecu
        let imgName = !tfPasswold.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    @IBAction func btnEyePressed2(_ sender: UIButton) {
        let isSecu = tfNewPasswold.isSecureTextEntry
        tfNewPasswold.isSecureTextEntry = !isSecu
        let imgName = !tfNewPasswold.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    @IBAction func btnEyePressed3(_ sender: UIButton) {
        let isSecu = tfReNewPasswold.isSecureTextEntry
        tfReNewPasswold.isSecureTextEntry = !isSecu
        let imgName = !tfReNewPasswold.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmView.btnNext.indexPath = .init()
        confirmView.btnNext.actionClosure = { [weak self] indexPath in
            guard let selfWeak = self else { return  }
            selfWeak.changePassword()
        }
    }
}

extension TPChangePasswordViewController{
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
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
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    if code == -207 {
                        // sai mật khẩu quá 5 lần--> logout tài khoản
                        TPCakeDefaults.shared.access_token = nil
                        stateLogin = .Notyet
                        let vc = TPLoginViewController()
                        self.changeRootViewController(vc)
                    }
                })
            }else{
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    TPCakeDefaults.shared.access_token = nil
                    stateLogin = .Notyet
                    let vc = TPLoginViewController()
                    self.changeRootViewController(vc)
                })
            }
        }
        }
    }

extension TPChangePasswordViewController {
    func checkValidInput()->(Bool, String){
        let _ = tfPasswold.text
        let stringNewPasswold = tfNewPasswold.text
        let stringReNewPasswold = tfReNewPasswold.text
        
        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfPasswold,tfNewPasswold, tfReNewPasswold], sms: ["🔴 Mật khẩu không được để trống","🔴 Mật khẩu không được để trống", "🔴 Mật khẩu không được để trống"])
        if !check {
            return (false,"Textfild đang để trống.")
        }
        if stringNewPasswold!.count < 6 {
            tfNewPasswold.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPasswold, sms: "🔴 Mật khẩu phải lớn hơn 6 ký tự.")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        if stringNewPasswold!.count > 30 {
            tfNewPasswold.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPasswold, sms: "🔴 Mật khẩu không quá 30 ký tự.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if !stringNewPasswold!.checkSpecialCharacter() {
            tfNewPasswold.borderColor = .red
            Commons.showDialogJK("Mật khẩu cần có ít nhất 6 ký tự, 1 ký tự số, 1 ký tự đặc biệt, 1 ký tự in hoa")
            //showErrorBelowUITextfild(tf: tfNewPasswold, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringNewPasswold!.checkBigCharacter() {
            tfNewPasswold.borderColor = .red
            Commons.showDialogJK("Mật khẩu cần có ít nhất 6 ký tự, 1 ký tự số, 1 ký tự đặc biệt, 1 ký tự in hoa")
            //showErrorBelowUITextfild(tf: tfNewPasswold, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự in hoa.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringNewPasswold!.checkHaveNumber() {
            tfNewPasswold.borderColor = .red
            Commons.showDialogJK("Mật khẩu cần có ít nhất 6 ký tự, 1 ký tự số, 1 ký tự đặc biệt, 1 ký tự in hoa")
            //showErrorBelowUITextfild(tf: tfNewPasswold, sms: "🔴 Mật khẩu phải có ít nhất 1 chữ số.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if stringReNewPasswold! != stringNewPasswold!{
            tfReNewPasswold.borderColor = .red
            showErrorBelowUITextfild(tf: tfReNewPasswold, sms: "🔴 Mật khẩu nhập lại không khớp.")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        return (true,"ok")
    }
}
