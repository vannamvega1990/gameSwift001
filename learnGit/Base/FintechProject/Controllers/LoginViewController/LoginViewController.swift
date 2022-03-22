//
//  LoginViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/11/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class LoginViewController: FTBaseViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var tfMobile: FTBaseTextField!
    @IBOutlet weak var tfPasswold: FTBaseTextField!
    
    var mobileNumber: String?
    var password: String?
    
    var daXacthucSdt: Bool = true{
        didSet{
            if !daXacthucSdt {
                Commons.showLoading(view)
                let mobi = self.tfMobile.text!
                NetworkManager.shared.requestResendOTP(mobile: mobi, coordbustResendOTP)
            }
        }
    }
    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissRecognizer()
        if let mobile = CakeDefaults.shared.mobile {
            tfMobile.text = mobile
        }
        if let mobile = CakeDefaults.shared.mobile, let pass = BaseCommons.getPassword() {
            mobileNumber = mobile
            password = pass
            showTouchID(actionSusses: {
                Commons.showLoading(self.view)
                NetworkManager.shared.requestLogin(mobile:mobile, password:pass, self.coordbustKeychain)
            }, actionError: nil, actionErrorDeivce: nil, actionErrorVersionIos: nil)
        }
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
            let check = checkValidInput()
            if !check.0 {
                showDialogJK(check.1)
            }else{
                Commons.showLoading(view)
                let mobile = tfMobile.text!//"0962877090"//"0974399575"
                mobileNumber = mobile
                let password = tfPasswold.text!//"Vega@123"
                NetworkManager.shared.requestLogin(mobile:mobile, password:password, coordbust)
            }
    }
    
    @IBAction func btnForgetPasswordPressed(_ sender: UIButton) {
        tfMobile.borderColor = .lightGray
        tfPasswold.borderColor = .lightGray
        let stringMobile = tfMobile.text
        if Commons.stringIsNilOrEmpty(str: stringMobile){
            tfMobile.borderColor = .red
            showDialogJK("Hãy nhập số điện thoại trước")
            return
        }
        if stringMobile!.count < 6 {
            tfMobile.borderColor = .red
            showDialogJK("Số điện thoại phải lớn hơn 6 ký tự")
            return
        }
        Commons.showLoading(self.view)
        NetworkManager.shared.requestForgetPasswordOTP(mobile: stringMobile!, coordbustForgetPassOTP)
    }
}
extension LoginViewController {
    func coordbustForgetPassOTP(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let _=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
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
        Commons.hideLoading(self.view)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
           
            if code != 0 {
                Commons.showDialogAlert(title: "GET OTP", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                let vc = ForgetPasswordViewController()
                vc.mobile = tfMobile.text!
                    //StreechForgetPasswordVC(mobile: tfMobile.text!)
                pushToViewController(vc, true)
            }
        }
    }
    func coordbustKeychain(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let _=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
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
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                CakeDefaults.shared.access_token = access_token
            }
            if code != 0 {
                if code == -504 {
                    self.daXacthucSdt = false
                    return
                }
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                let vc = TabBarViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                    //AppDelegate.disconnected(self.view)
                    print("123")
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                    //AppDelegate.reconnect()
                    print("123")
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
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                CakeDefaults.shared.access_token = access_token
            }
            if code != 0 {
                if code == -504 {
                    self.daXacthucSdt = false
                    return
                }
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                BaseCommons.setPassword(password: self.tfPasswold.text!)
                CakeDefaults.shared.mobile = self.mobileNumber!
                let vc = TabBarViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func coordbustResendOTP(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                    //AppDelegate.disconnected(self.view)
                    print("123")
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                    //AppDelegate.reconnect()
                    print("123")
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
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                CakeDefaults.shared.access_token = access_token
            }
            if code != 0 {
            }else{
                let otpVC = OTPViewController()
                let mobi = self.tfMobile.text!
                otpVC.mobile = mobi
                self.pushToViewController(otpVC, true)
            }
        }
    }
    func checkValidInput()->(Bool, String){
        let stringMobile = tfMobile.text
        let stringPass = tfPasswold.text
        if Commons.stringIsNilOrEmpty(str: stringMobile){
            tfMobile.borderColor = .red
            return (false,"Số điện thoại đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringPass){
            tfPasswold.borderColor = .red
            return (false,"Mật khẩu mới đang để trống.")
        }
        if stringMobile!.count < 6 {
            tfMobile.borderColor = .red
            return (false,"Số điện thoại phải lớn hơn 6 ký tự.")
        }
        if stringPass!.count < 6 {
            tfPasswold.borderColor = .red
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        return (true,"ok")
    }
    func checkValid()->Bool{
        if !checkPhone() {
            Commons.showDialogJK("Số điện thoại không hợp lệ !")
            return false
        } else if !checkPassword() {
            Commons.showDialogJK("Mật khẩu không hợp lệ !")
            return false
        }
        return true
    }
    func checkPhone() -> Bool{
        if tfMobile.text == nil || tfMobile.text == "" {
            return false
        } else if tfMobile.text!.count < 6 {
            return false
        }
        return true
    }
    func checkPassword() -> Bool{
        if tfPasswold.text == nil || tfPasswold.text == "" {
            return false
        } else if tfPasswold.text!.count < 6 {
            return false
        }
        return true
    }
}

