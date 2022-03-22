//
//  TPOTPViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

var TPOTPViewControllerShared = BaseViewControllers()

enum ExtraOTPType {
    case GetBiophic
    case none
}
var extraOTPType: ExtraOTPType = .none

protocol OTPDelegate {
    func compliteVerifyDevice()
}

class TPOTPViewController: TPBaseViewController {
    
    var socialID:String?
    var socialType:TPSocialType?
    var delegate: OTPDelegate?
    var viewControllerWantBack: TPBaseViewController?

    enum TypeNext {
        case goCreateNewPassword
        case fromSaoke
        case fromVerifyEmail
        case fromMobileRegister
        case fromSocialRegister
        case fromVerifyDevice
        case fromVerifyDeviceNoDeviceToken
        case fromVerifyMobile
        case resendOTPMobileRegister
        case loginViaMobile
        case none
    }
    
    enum SubType {
        case resendOTPMobileRegister
        case resendOTPVerifyEmail
        case resendOTP
        case none
    }
    
    @IBOutlet weak var tfOTP: TPBaseTextFieldWithLabel!
    @IBOutlet weak var titleMobile: UILabel!
    @IBOutlet weak var btnTimeResendOTP: TPBaseViewImageWithLabel!
    
    var typeNext: TypeNext = .none
    var subType: SubType = .none
    var mobile:String = ""
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        subType = .none
        typeNext = .none
        extraOTPType = .none
        AppDelegate.enableIQKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TPOTPViewControllerShared = self
        startTimer()
    }
    
    init() {
        super.init(nibName: "TPOTPViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func btnResendOTPPressed() {
        if countTime != 60 {
            Commons.showDialogJK("Vui lòng chờ ...")
            return
        }
        switch typeNext {
        case .fromMobileRegister:
            subType = .resendOTPMobileRegister
            TPNetworkManager.shared.requestResendOTP(mobile: mobile, coordbust)
            break
        case .fromVerifyDevice:
            subType = .resendOTP
            if let device_id = deviceID {
                TPNetworkManager.shared.requestVerifyDeviceResendOTP(mobile: mobile, device_id: device_id, coordbust)
            }
            break
        case .fromVerifyDeviceNoDeviceToken:
            subType = .resendOTP
            if let device_id = deviceID {
                TPNetworkManager.shared.requestVerifyDeviceResendOTP(mobile: mobile, device_id: device_id, coordbust)
            }
            break
        case .fromSocialRegister:
            subType = .resendOTP
            if let socialID = socialID, let socialType = socialType {
                TPNetworkManager.shared.requestSocialRegisterResentOTP(socialID, "\(socialType.rawValue)", mobile, coordbust)
            }
            break
        case .fromVerifyEmail:
            if let access_token = TPCakeDefaults.shared.access_token {
                subType = .resendOTPVerifyEmail
                TPNetworkManager.shared.requestVerifyEmailResendOTP(access_token: access_token, email: self.mobile, coordbust)
            }
            break
        default:
            
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleMobile.text = "Mã OTP đã được gửi tới số\n" + mobile + ""
        if typeNext == .fromVerifyEmail {
            titleMobile.text = "Mã OTP đã được gửi tới email\n" + mobile + ""
        }
        AppDelegate.disableIQKeyboard()
        btnTimeResendOTP.indexPath = IndexPath(row: 1, section: 1)
        btnTimeResendOTP.actionClosure = {[weak self] indexPath in
            guard let selfWeak = self else {
                return
            }
            selfWeak.btnResendOTPPressed()
        }
        tfOTP.addCustomTPToolBar(title: "Xác nhận", action: {
            self.hideKeyboard()
            self.subType = .none
            switch self.typeNext {
            case .goCreateNewPassword:
                let vc = TPCreateNewPasswordVC()
                self.pushToViewController(vc, true)
                break
            case .fromVerifyEmail:
                let check = self.checkValidInput()
                if !check.0 {
                    self.showDialogJK(check.1)
                }else{
                    if let access_token =  TPCakeDefaults.shared.access_token {
                        Commons.showLoading(self.view)
                        let otp = self.tfOTP.text!
                        self.subType = .none
                        TPNetworkManager.shared.requestVerifyEmailOTP(access_token: access_token, email: self.mobile, otp: otp, self.coordbust)
                    }
                    
                }
                break
            case .fromMobileRegister:
                let check = self.checkValidInput()
                if !check.0 {
                    self.showDialogJK(check.1)
                }else{
                    Commons.showLoading(self.view)
                    let otp = self.tfOTP.text!
                    self.subType = .none
                    TPNetworkManager.shared.requestVerifyOTP(mobile: self.mobile, otp: otp, device_id: deviceID ?? "", self.coordbust)
                }
                break
            case .fromSocialRegister:
                let check = self.checkValidInput()
                if !check.0 {
                    self.showDialogJK(check.1)
                }else{
                    Commons.showLoading(self.view)
                    let otp = self.tfOTP.text!
                    self.subType = .none
                    TPNetworkManager.shared.requestVerifyOTP(mobile: self.mobile, otp: otp, device_id: deviceID ?? "", self.coordbust)
                }
                break
            case .fromVerifyDevice:
                let check = self.checkValidInput()
                if !check.0 {
                    self.showDialogJK(check.1)
                }else{
                    Commons.showLoading(self.view)
                    let otp = self.tfOTP.text!
                    if let device_id = deviceID {
                        TPNetworkManager.shared.requestVerifyDeviceOTP(mobile: self.mobile, device_id: device_id , otp: otp, self.coordbust)
                    }
                }
                break
            case .fromVerifyDeviceNoDeviceToken:
                let check = self.checkValidInput()
                if !check.0 {
                    self.showDialogJK(check.1)
                }else{
                    Commons.showLoading(self.view)
                    let otp = self.tfOTP.text!
                    if let device_id = deviceID {
                        TPNetworkManager.shared.requestVerifyDeviceOTP(mobile: self.mobile, device_id: device_id , otp: otp, self.coordbust)
                    }else{
                        self.showToast(sms: "Chưa lấy đc id thiết bị")
                    }
                }
                break
            case .fromSaoke:
                let vc = TPConfirmSaokeVC()
                vc.objectReciver = self.objectReciver
                self.pushToViewController(vc, true)
                break
            default:
                break
            }
        })
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
    
    private func LoginAction(){
        let deviceToken = TPCakeDefaults.shared.device_token ?? ""
        Commons.showLoading(self.view)
        TPNetworkManager.shared.requestLogin(mobile:mobileTemp, password:TPPasswordTemp, device_token: deviceToken, biometric_token: "", coordbust)
        
    }
    var flagLogin:Bool = false {
        didSet{
            if flagLogin {
                typeNext = .loginViaMobile
                LoginAction()
            }
        }
    }
}


extension TPOTPViewController {
    func checkValidInput()->(Bool, String){
            let stringCode = tfOTP.text
            if Commons.stringIsNilOrEmpty(str: stringCode){
                tfOTP.showError(sms: "🔴 OTP không được để trống")
                return (false,"Không được để trống mã code.")
            }
        return (true,"ok")
    }
//    func saveDataInfoUser(data:[String:Any]){
//        if let access_token = data["access_token"] as? String {
//            saveToken(access_token)
//            saveAccessToken(access_token)
//        }
//        if let device_token = data["device_token"] as? String {
//            saveDeviceToken(device_token)
//        }
//        if let email = data["email"] as? String {
//            saveEmail(email: email)
//        }
//        if let status_verify_email = data["status_verify_email"] as? Bool {
//            TPCakeDefaults.shared.isVerifyEmail = status_verify_email
//        }
//        if let status_is_register_statement = data["status_is_register_statement"] as? Bool {
//            TPCakeDefaults.shared.status_is_register_statement = status_is_register_statement
//        }
//    }
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                }
            }
            return
        }
        Commons.hideLoading(self.view)
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
            if let data = shitDic["Data"] as? [String:Any]{
                saveDataInfoUser(data: data)
            }
            //Commons.hideLoading(self.view)
            
            switch self.typeNext {
            
            case .goCreateNewPassword:
                break
                
            case .loginViaMobile:
                if let data = shitDic["Data"] as? [String:Any]{
                    saveDataInfoUser(data: data)
                }
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                        self.backToAnyViewController2(vc: self.viewControllerWantBack!)
                    })
                }else{
                    self.pushToMainViewController()
                }
                break
                
            case .fromVerifyEmail:
                if let data = shitDic["Data"] as? [String:Any]{
                    saveDataInfoUser(data: data)
                }
                switch subType {
                case .resendOTPVerifyEmail:
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                        if code == 0 {
                            self.startTimer()
                        }
                    })
                    break
                default:
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                        if code == 0 {
                            emailTemp = self.mobile
                            status_verify_email = true
                            TPCakeDefaults.shared.isVerifyEmail = true
                            TPCakeDefaults.shared.email = self.mobile
                            self.backToAnyViewController(n: 2)
                        }
                    })
                    break
                }
                
                break
            case .fromMobileRegister:
                if let data = shitDic["Data"] as? [String:Any]{
                    saveDataInfoUser(data: data)
                }
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    switch subType {
                    case .resendOTPMobileRegister:
                        if code == 0 {
                            subType = .none
                            self.startTimer()
                        }
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                        break
                    default:
                        self.saveMobile(mobile: self.mobile)
                        self.pushToMainViewController()
//                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
//                            self.saveMobile(mobile: self.mobile)
//                            self.pushToMainViewController()
//                            //self.backToAnyViewController2(vc: TPRegisterViewControllerShared)
//                        })
                        break
                    }
                }
                break
            case .fromSocialRegister:
                if let data = shitDic["Data"] as? [String:Any]{
                    saveDataInfoUser(data: data)
                }
                switch subType {
                case .resendOTP:
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                    if code == 0 {
                        subType = .none
                        self.startTimer()
                    }
                    break
                default:
                    if code != 0 {
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                    }else{
                        self.pushToMainViewController()
                    }
                    break
                }
                
                break
            case .fromVerifyDevice:
                
                switch subType {
                case .resendOTP:
                    if code == 0 {
                        subType = .none
                        self.startTimer()
                    }
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                    break
                default:
                    if let data = shitDic["Data"] as? [String:Any]{
                        saveDataInfoUser(data: data)
                    }
                    
                    guard extraOTPType != .GetBiophic else {
                        if code != 0 {
                            Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                        }else{
                            if let data = shitDic["Data"] as? [String:Any]{
                                saveDataInfoUser(data: data)
                            }
                            if loginRegisterVia == .Social {
                                loginRegisterVia = .none
                                self.pushToMainViewController()
                            }else{
                                self.flagLogin = true
                            }
//                            Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: { [weak self ] in
//                                guard let selfWeak = self else {
//                                    return
//                                }
//                                //selfWeak.delegate?.compliteVerifyDevice()
//                                //selfWeak.backToAnyViewController2(vc: selfWeak.viewControllerWantBack!)
//                            })
                        }
                        return
                    }
                    
                    if code != 0 {
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                            self.popBackViewController(true)
                        })
                    }else{
                        self.saveMobile(mobile: self.mobile)
                        self.pushToMainViewController()
//                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
//                            self.pushToMainViewController()
//                        })
                    }
                    break
                }
                break
            case .fromVerifyDeviceNoDeviceToken:
                switch subType {
                case .resendOTP:
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                    break
                default:
                   
                    if code != 0 {
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                            
                        })
                    }else{
                        if let data = shitDic["Data"] as? [String:Any]{
                            saveDataInfoUser(data: data)
                        }
                        
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                            TPRegisterViewControllerShared.fromViewController = self
                            self.backToAnyViewController2(vc: TPRegisterViewControllerShared)
                        })
                    }
                    break
                }
                break
            case .fromSaoke:
                
                break
            default:
                break
            }
        }else{
            
        }
    }
}
