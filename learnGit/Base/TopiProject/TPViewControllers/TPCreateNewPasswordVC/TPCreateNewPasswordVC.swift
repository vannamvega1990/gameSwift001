//
//  TPCreateNewPasswordVC.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPCreateNewPasswordVC: TPBaseViewController {

    var mobile = ""
    var typeRequest: TypeRequest = .defult
    
    @IBOutlet weak var tfOTP: TPBaseTextFieldWithLabel!
    @IBOutlet weak var tfReNewPassword: TPBaseTextField!
    @IBOutlet weak var tfNewPassword: TPBaseTextField!
    @IBOutlet weak var btnTimeResendOTP: TPBaseViewImageWithLabel!
    @IBOutlet weak var titleMobile: UILabel!
    
    enum TypeRequest {
        case reSendOTP
        case changePassword
        case defult
    }
    
    init() {
        super.init(nibName: "TPCreateNewPasswordVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func btnEyePressed1(_ sender: UIButton) {
        let isSecu = tfNewPassword.isSecureTextEntry
        tfNewPassword.isSecureTextEntry = !isSecu
        let imgName = !tfNewPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    @IBAction func btnEyePressed2(_ sender: UIButton) {
        let isSecu = tfReNewPassword.isSecureTextEntry
        tfReNewPassword.isSecureTextEntry = !isSecu
        let imgName = !tfReNewPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    private func btnResendOTPPressed() {
        if countTime != 60 {
            Commons.showDialogJK("Vui lòng chờ ...")
            return
        }
        typeRequest = .reSendOTP
        TPNetworkManager.shared.requestForgetPasswordReSendOTP(mobile, coordbust)
    }
    
    var countTime:Int = 60
    var timer: Timer?
    @objc func handleTimer(){
        countTime -= 1
        if countTime < 0 {
            countTime = 60
            timer?.invalidate()
        }
        let txt = countTime == 60 ? "Gửi lại" : "Gửi lại (\(countTime)s)"
        btnTimeResendOTP.txtTitle = txt
    }
    func startTimer(){
        timer = createTimer(timeInterval: 1, selector: #selector(handleTimer), repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.disableIQKeyboard()
        titleMobile.text = "Chúng tôi đã gửi mã OTP tới số điện thoại \n\(mobile)"
        btnTimeResendOTP.indexPath = IndexPath(row: 1, section: 1)
        btnTimeResendOTP.actionClosure = {[weak self] indexPath in
            guard let selfWeak = self else {
                return
            }
            selfWeak.btnResendOTPPressed()
        }
        tfReNewPassword.addCustomTPToolBar(title: "Xác nhận", action: { [weak self] in
            guard let selfWeak = self else { return }
            selfWeak.requestCreateNewPassword()
        })
        tfOTP.addCustomTPToolBar(title: "Xác nhận", action: { [weak self] in
            guard let selfWeak = self else { return }
            selfWeak.requestCreateNewPassword()
        })
        tfNewPassword.addCustomTPToolBar(title: "Xác nhận", action: { [weak self] in
            guard let selfWeak = self else { return }
            selfWeak.requestCreateNewPassword()
        })
    }
    
    func requestCreateNewPassword(){
        let check = self.checkValidInput()
        if !check.0 {
        }else{
            Commons.showLoading(self.view)
            let newPassword = self.tfNewPassword.text!
            let otp = self.tfOTP.text!
            self.typeRequest = .changePassword
            TPNetworkManager.shared.requestResetPassword(self.mobile,otp,newPassword,self.coordbust)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AppDelegate.enableIQKeyboard()
    }

}

extension TPCreateNewPasswordVC{
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
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            
            if code != 0 {
                Commons.showDialogAlert(title: "ĐỔI MẬT KHẨU", content: sms, inView: self.view, didFinishDismiss: nil)
                
            }else{
                switch self.typeRequest {
                case .changePassword :
                    Commons.showDialogAlert(title: "ĐỔI MẬT KHẨU", content: sms, inView: self.view, didFinishDismiss: {
                        TPCakeDefaults.shared.access_token = nil
                        //self.backToAnyViewController(n: 2)
                        let vc = TPLoginViewController()
                        vc.objectReciver = "TPCreateNewPasswordVC---\(self.tfNewPassword.text!)" as AnyObject
                        self.changeRootViewController(vc)
                    })
                    break
                case .reSendOTP :
                    startTimer()
                    break
                default:
                    break
                }
            }
        }
    }
    func checkValidInput()->(Bool, String){
        let stringOTP = tfOTP.text
        let stringNewPassword = tfNewPassword.text
        let stringReNewPassword = tfReNewPassword.text
        
        if Commons.stringIsNilOrEmpty(str: stringOTP){
            tfOTP.showError(sms: "🔴 OTP không được để trống")
            return (false,"Không được để trống mã code.")
        }
        
        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfNewPassword, tfReNewPassword], sms: ["🔴 Mật khẩu không được để trống", "🔴 Mật khẩu không được để trống"])
        if !check {
            return (false,"Textfild đang để trống.")
        }
     
        if stringNewPassword!.count < 6 {
            tfNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPassword, sms: "🔴 Mật khẩu phải lớn hơn 6 ký tự.")
            return (false,"Email phải lớn hơn 6 ký tự.")
        }
        if stringNewPassword!.count > 30 {
            tfNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPassword, sms: "🔴 Mật khẩu không quá 30 ký tự.")
            return (false,"Email phải lớn hơn 6 ký tự.")
        }
        if !stringNewPassword!.checkSpecialCharacter() {
            tfNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringNewPassword!.checkBigCharacter() {
            tfNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự in hoa.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringNewPassword!.checkHaveNumber() {
            tfNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfNewPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 chữ số.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if stringReNewPassword! != stringNewPassword! {
            tfReNewPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfReNewPassword, sms: "🔴 Mật khẩu nhập lại không trùng khớp.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        return (true,"ok")
    }
}
