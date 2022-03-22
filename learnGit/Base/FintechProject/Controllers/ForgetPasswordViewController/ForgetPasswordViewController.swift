//
//  LoginViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/11/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: FTBaseViewController {
    
    @IBOutlet weak var tfOtp: FTBaseTextField!
    @IBOutlet weak var tfNewPasswold: FTBaseTextField!
    @IBOutlet weak var tfReNewPasswold: FTBaseTextField!
    
    var mobile: String = ""
    init() {
        super.init(nibName: "ForgetPasswordViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissRecognizer()
    }
    
    @IBAction func btnResetPasswordPressed(_ sender: UIButton) {
        let check = checkValidInput()
        if !check.0 {
            showDialogJK(check.1)
        }else{
            Commons.showLoading(view)
            let newPassword = tfNewPasswold.text!
            let otp = tfOtp.text!
            NetworkManager.shared.requestResetPassword(mobile,otp,newPassword,coordbust)
        }
        
    }
    
}

extension ForgetPasswordViewController {
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
            
            if code != 0 {
                Commons.showDialogAlert(title: "ĐỔI MẬT KHẨU", content: sms, inView: self.view, didFinishDismiss: nil)
                
            }else{
                Commons.showDialogAlert(title: "ĐỔI MẬT KHẨU", content: sms, inView: self.view, didFinishDismiss: {
                    //self.changeRootViewController(StartViewController())
                    self.popBackViewController(true)
                })
            }
        }
    }
    
    func checkValidInput()->(Bool, String){
        let stringOtp = tfOtp.text
        let stringNewPass = tfNewPasswold.text
        let stringReNewPass = tfReNewPasswold.text
        if Commons.stringIsNilOrEmpty(str: stringOtp){
            tfOtp.borderColor = .red
            return (false,"OTP đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringNewPass){
            tfNewPasswold.borderColor = .red
            return (false,"Mật khẩu mới đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringReNewPass){
            tfReNewPasswold.borderColor = .red
            return (false,"Xác nhận mật khẩu mới")
        }
        if stringNewPass!.count < 6 {
            tfNewPasswold.borderColor = .red
            return (false,"Mật khẩu mới phải lớn hơn 6 ký tự.")
        }
        if stringReNewPass! != stringNewPass! {
            tfReNewPasswold.borderColor = .red
            return (false,"Mật khẩu mới không giống nhau.")
        }
        return (true,"ok")
   }
    
}

