//
//  TPCompleteRegisterBySocialVC.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

enum TPStateSocialID {
    case notExist
    case existButNotVerify
    case exist
    case defult
}

var TPCompleteRegisterBySocialVCShared = UIViewController()

class TPCompleteRegisterBySocialVC: TPBaseViewController {
    
    enum RequestType {
        case CompleteRegisterBySocial
        case VerifyDevice
        case none
    }

    @IBOutlet weak var tfMobile: TPBaseTextFieldWithLabel!
    @IBOutlet weak var tfPassword: TPBaseTextField!
    
    var sosialType:TPSocialType?
    var stateSocialID:TPStateSocialID = .defult
    var dicData:[String:String?] = [:]
    var requestType: RequestType = .none
    
    var sosialID:String?
    
    init() {
        super.init(nibName: "TPCompleteRegisterBySocialVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var flagRegisterViaSocial:Bool = false {
        didSet{
            if flagRegisterViaSocial {
                let mobile = tfMobile.text!
                let fullName = dicData["fullName"] ?? nil
                let email = dicData["email"] ?? nil
                
                let password = self.tfPassword.text!

                if let sosialId = dicData["userId"] as? String, let sosialType = sosialType {
                    Commons.showLoading(self.view)
                    TPNetworkManager.shared.requestRegisterViaSocial(mobile,sosialId,"\(sosialType.rawValue)",email,fullName,password,coordbust)
                }
                
            }
        }
    }
    
    @IBAction func btnEyePressed(_ sender: UIButton) {
        let isSecu = tfPassword.isSecureTextEntry
        tfPassword.isSecureTextEntry = !isSecu
        let imgName = !tfPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AppDelegate.enableIQKeyboard()
        TPCompleteRegisterBySocialVCShared = self
    }
    
    func request(){
        switch self.requestType {
        case .VerifyDevice:
            if let device_id = deviceID {
                Commons.showLoading(self.view)
                TPNetworkManager.shared.requestVerifyDevice(mobile: self.tfMobile.text!, device_id: device_id, self.coordbust)
            }
            else {
                self.showToast(sms: "Chưa lấy được ID của thiết bị này")
            }
            break
        case .CompleteRegisterBySocial:
            switch self.stateSocialID {
            case .notExist:
                self.flagRegisterViaSocial = true
                break
            case .existButNotVerify:
                self.flagRegisterViaSocial = true
                break
            default:
                break
            }
            break
        default:
            break
        }
    }
    
    func request1(){
        self.hideKeyboard()
        let check = self.checkValidInput()
        if !check.0 {
            self.showDialogJK(check.1)
        }else{
            self.request()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.disableIQKeyboard()
        tfPassword.addCustomTPToolBar1(title: "Đăng ký") {
            [weak self ] in
            guard let selfWeak = self else {
                return
            }
            selfWeak.request1()
        }
        tfMobile.addCustomTPToolBarAll(title: "Đăng ký") {
            [weak self ] in
            guard let selfWeak = self else {
                return
            }
            selfWeak.request1()
        }
        
//        tfMobile.addCustomTPToolBar(title: "Xác nhận") {
//            [weak self ] in
//            guard let selfWeak = self else {
//                return
//            }
//
//            selfWeak.hideKeyboard()
//            //self.flagRegisterViaGoogle = true
//
//            let check = selfWeak.checkValidInput()
//            if !check.0 {
//                selfWeak.showDialogJK(check.1)
//            }else{
//                switch selfWeak.requestType {
//                case .VerifyDevice:
//                    if let device_id = deviceID {
//                        Commons.showLoading(selfWeak.view)
//                        TPNetworkManager.shared.requestVerifyDevice(mobile: selfWeak.tfMobile.text!, device_id: device_id, selfWeak.coordbust)
//                    }
//                    else {
//                        selfWeak.showToast(sms: "Chưa lấy được ID của thiết bị này")
//                    }
//                    break
//                case .CompleteRegisterBySocial:
//                    switch selfWeak.stateSocialID {
//                    case .notExist:
//                        selfWeak.flagRegisterViaSocial = true
//                        break
//                    case .existButNotVerify:
//                        selfWeak.flagRegisterViaSocial = true
//                        break
//                    default:
//                        break
//                    }
//                    break
//                default:
//                    break
//                }
//            }
//        }
    }
    
    
    

}

extension TPCompleteRegisterBySocialVC {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                
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
            
            switch requestType {
            case .VerifyDevice:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    let vc = TPOTPViewController()
                    vc.mobile = tfMobile.text!
                    vc.typeNext = .fromVerifyDeviceNoDeviceToken
                    self.pushToViewController(vc, true)
                }
                break
            case .CompleteRegisterBySocial:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    let vc = TPOTPViewController()
                    vc.mobile = tfMobile.text!
                    vc.typeNext = .fromSocialRegister
                    vc.socialID = sosialID
                    vc.socialType  = sosialType
                    pushToViewController(vc, true)
                }
                break
            default:
                break
            }
            
            
        }
    }
    func checkValidInput()->(Bool, String){
        let stringCode = tfMobile.text
        let stringPassword = tfPassword.text
        if Commons.stringIsNilOrEmpty(str: stringCode){
            tfMobile.showError(sms: "🔴 Số điện thoại không được để trống")
            return (false,"Không được để trống mã code.")
        }
        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfPassword], sms: ["🔴 Mật khẩu không được để trống"])
        if !check {
            return (false,"Textfild đang để trống.")
        }
        if stringPassword!.count < 6 {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải lớn hơn 6 ký tự.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if stringPassword!.count > 30 {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không quá 30 ký tự.")
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if !stringPassword!.checkSpecialCharacter() {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringPassword!.checkBigCharacter() {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 ký tự in hoa.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        if !stringPassword!.checkHaveNumber() {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu phải có ít nhất 1 chữ số.")
            return (false,"Mật khẩu phải có ít nhất 1 ký tự đặc biệt.")
        }
        
        return (true,"ok")
    }
}
