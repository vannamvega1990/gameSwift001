//
//  TPVerifyEmailVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/24/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPVerifyEmailVC: TPBaseViewController {
    
    var email:String?
    
    @IBOutlet weak var tfEmail: TPBaseTextFieldWithLabel!
    @IBOutlet weak var btnVerify: TPBaseViewImageWithLabel!

    init() {
        super.init(nibName: "TPVerifyEmailVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func verifyEmail(){
        let check = checkValidInput()
        if check.0 {
            if let device_token = TPCakeDefaults.shared.access_token {
                Commons.showLoading(self.view)
                let email1 = tfEmail.text!
                TPNetworkManager.shared.requestVerifyEmail(access_token: device_token, email: email1, coordbust)
            }else{
                self.showDialogJK("Chưa có device_token")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.text = email
        btnVerify.indexPath = .init()
        btnVerify.actionClosure = {
            indexPath in
            self.verifyEmail()
        }
    }

}

extension TPVerifyEmailVC {
    func checkValidInput()->(Bool, String){
        let stringEmail = tfEmail.text
        
        if Commons.stringIsNilOrEmpty(str: stringEmail){
            tfEmail.showError(sms: "🔴 Email không được để trống")
            return (false,"Không được để trống mã code.")
        }
        if !stringEmail!.isValidEmail() {
            tfEmail.borderColor = .red
            tfEmail.showError(sms: "🔴 Email không đúng định dạng")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        return (true,"ok")
    }
}

extension TPVerifyEmailVC {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        Commons.hideLoading(self.view)
        if let error=errur{
            Commons.showDialogNetworkError()
            
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
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        Commons.hideLoading(self.view)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String{
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
                vc.mobile = self.tfEmail.text!
                vc.typeNext = .fromVerifyEmail
                self.pushToViewController(vc, true)
                
            }
        }
    }
}
