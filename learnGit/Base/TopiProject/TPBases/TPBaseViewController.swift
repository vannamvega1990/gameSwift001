//
//  TPBaseViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

let colorGood = UIColor(rgb: 0xE98117, alpha: 1)
let colorWhitePlaceholder = UIColor.white.withAlphaComponent(0.6)
var status_verify_kyc: Bool = false
var status_verify_email: Bool = false
var status_is_register_statement_temp: Bool = false
var fullNameTemp: String = ""
var mobileTemp: String = ""
var TPPasswordTemp: String = ""
var emailTemp: String = ""

enum StateLogin {
    case Notyet
    case Logined
    case none
}

var stateLogin: StateLogin = .none

enum TPSocialType: Int {
    case Facebook = 0
    case Google = 1
    case Apple = 2
}

enum LoginRegisterVia {
    case Mobile
    case Social
    case none
}
var loginRegisterVia: LoginRegisterVia = .none

class TPBaseViewController: FTBaseViewController {
    
    enum TypeToast {
        case nomal
        case success
        case danger
        case info
        case error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTemp = TPCakeDefaults.shared.mobile ?? ""
    }
    
    func saveTouchId(val: Bool){
        TPCoreData.saveTouchObject(value:val)
    }
    func getTouchId() -> Bool?{
        if let filterData = TPCoreData.filterData(), filterData.count >= 1 {
            return filterData.first!.isTouch
        }
        return nil
    }
    func saveBioToken(stringBio: String){
        let string_Data = BaseKeyChain.stringToDATA(string: stringBio)
        //BaseKeyChain.save(key: "BIOTOKEN", data: string_Data)
        BaseKeyChain.save(key: mobileTemp, data: string_Data)
    }
    func removeBioToken(){
        //BaseKeyChain.remove(serviceKey: "BIOTOKEN")
        BaseKeyChain.remove(serviceKey: mobileTemp)
    }
    func getBioToken() -> String? {
        //if let RecievedDataStringAfterSave = BaseKeyChain.load(key: "BIOTOKEN") {
        if let RecievedDataStringAfterSave = BaseKeyChain.load(key: mobileTemp) {
            let NSDATAtoString = BaseKeyChain.DATAtoString(data: RecievedDataStringAfterSave)
            print(NSDATAtoString)
            return NSDATAtoString
        }
        return nil
    }

    func saveDeviceToken(_ device_token: String){
        TPCakeDefaults.shared.device_token = device_token
    }
    func saveAccessToken(_ access_token: String){
        TPCakeDefaults.shared.access_token = access_token
    }
    func saveMobile(mobile:String){
        TPCakeDefaults.shared.mobile = mobile
    }
    func getMobile() -> String?{
        return TPCakeDefaults.shared.mobile
    }
    func saveEmail(email:String){
        emailTemp = email
        TPCakeDefaults.shared.email = email
    }
    func getEmail() -> String?{
        return TPCakeDefaults.shared.email
    }
    override func pushToMainViewController() {
        let vc = TPTabBarViewController()
        pushToViewController(vc, true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AppDelegate.enableIQKeyboard()
    }
    func saveDataInfoUser(data:[String:Any]){
        if let access_token = data["access_token"] as? String, !Commons.stringIsNilOrEmpty(str: access_token) {
            //saveToken(access_token)
            saveAccessToken(access_token)
        }
        if let device_token = data["device_token"] as? String, !Commons.stringIsNilOrEmpty(str: device_token) {
            saveDeviceToken(device_token)
        }
        if let email = data["email"] as? String {
            emailTemp = email
            saveEmail(email: email)
        }
        if let statusVerify_email = data["status_verify_email"] as? Bool {
            status_verify_email = statusVerify_email
            TPCakeDefaults.shared.isVerifyEmail = statusVerify_email
        }
        if let status_is_register_statement = data["status_is_register_statement"] as? Bool {
            status_is_register_statement_temp = status_is_register_statement
            TPCakeDefaults.shared.status_is_register_statement = status_is_register_statement
        }
        if let statusKyc = data["status_verify_kyc"] as? Bool{
            status_verify_kyc = statusKyc
        }
//        if let statusEmail = data["status_verify_email"] as? Bool{
//            status_verify_email = statusEmail
//        }
        if let full_name = data["full_name"] as? String, !Commons.stringIsNilOrEmpty(str: full_name){
            fullNameTemp = full_name
        }
        if let mobileTemp1 = data["mobile"] as? String, !Commons.stringIsNilOrEmpty(str: mobileTemp1){
            mobileTemp = mobileTemp1
            TPCakeDefaults.shared.mobile = mobileTemp
        }
    }
    
    func logoutTK(){
        TPCakeDefaults.shared.access_token = nil
        stateLogin = .Notyet
        let vc = TPRegisterViewController()
        self.changeRootViewController(vc)
    }
    
    func coordbustTPBase(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        
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
            self.shitDic = shitDic
            self.code = code
            self.sms = sms
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            
        }else{
            return
        }
    }
}

extension TPBaseViewController {
    func showTPToast(typeToast:TypeToast, sms: String, actionCompleted: (() -> Void)? = nil){
        var bgColor: UIColor? = .white
        var icon: UIImage? = nil
        switch typeToast {
        case .error:
            bgColor = UIColor.init(named: "alertError")
            icon = UIImage(named: "ic_toast_error")
        case .info:
            bgColor = UIColor.init(named: "alertInfo")
            icon = UIImage(named: "ic_toast_info")
        case .danger:
            bgColor = UIColor.init(named: "alertDanger")
            icon = UIImage(named: "ic_toast_danger")
        case .success:
            bgColor = UIColor.init(named: "alertSuccess")
            icon = UIImage(named: "ic_toast_secess")
        case .nomal:
            bgColor = UIColor.init(named: "alertNomal")
            icon = nil
        }
        showToastFix(sms: sms, icon: icon, backgroundcolor: bgColor ?? .white, textcolor: .white, actionWhenCompleted: actionCompleted)
    }
    func checkEmptyTextFildHasErrorBellow(tfs: [TPBaseTextField],sms:[String]) -> Bool{
        for (key,tf) in tfs.enumerated() {
            if Commons.stringIsNilOrEmpty(str: tf.text) {
                tf.borderColor = .red
                showErrorBelowUITextfild(tf: tf, sms: sms[key])
                
                return false
                
            }else {
                hideErrorBelowUITextfild(tf: tf)
            }
        }
        return true
    }
    func showErrorBelowUITextfild(tf: UITextField,sms:String?=nil){
        let v = (tf.superview as! UIStackView).subviews.last
        v?.isHidden = false
        if let v1 = v, let stack = v1.subviews.first as? UIStackView,  let label =  stack.subviews.last as? UILabel, let sms1 = sms {
            label.text = sms1
        }
        if let v1 = v, let lable = v1.subviews.first as? UILabel, let sms1 = sms  {
            lable.text = sms1
        }
    }
    func hideErrorBelowUITextfild(tf: UITextField){
        let v = (tf.superview as! UIStackView).subviews.last
        v?.isHidden = true
    }
}

