//
//  TPRegisterViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices



var TPRegisterViewControllerShared = TPBaseViewController()

extension TPRegisterViewController: OTPDelegate {
    func compliteVerifyDevice() {
        showToastFix(sms: "Đã xác thực thiết bị thành công")
    }
}

class TPRegisterViewController: TPBaseViewController {
    

    @IBOutlet weak var stackView: UIStackView!
    
    var socialType: TPSocialType = .Google
    var fullName:String?
    var email:String?
    var userId:String?
    
    var mobile: String?
    var isBussyHandleGoogle: Bool = false
    
    enum TypeRequest {
        case AuthenSocail
        case VerifyDevice
        case none
    }
   
    var typeRequest: TypeRequest = .none
    init() {
        super.init(nibName: "TPRegisterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //mobile = nil
        flagVerifyDevice = false
        isBussyHandleGoogle = false
        signOutGoogle()
        removeAllObserver()
        //NotificationCenter.default.removeObserver(self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TPRegisterViewControllerShared = self
        if let fromVC = self.fromViewController, fromVC === TPOTPViewControllerShared {
            showToast(sms: "Thiết bị đã được xác thực", backgroundcolor: UIColor(rgb: 0x289B3C))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSignInGoogle()
        appDelegate.reset()
        flagVerifyDevice = false
        isBussyHandleGoogle = false
        BaseCommons.regisReceverNotificationcenter(self, NotificationCenterName.KEY_GOOGLE_LOGINED, nil, selector: #selector(handleGoogleSignNotification(_:)))
    }
    var flagVerifyDevice: Bool = false {
        didSet{
            if flagVerifyDevice && mobile != nil {
                if let device_id = deviceID {
                    Commons.showLoading(view)
                    typeRequest  = .VerifyDevice
                    TPNetworkManager.shared.requestVerifyDevice(mobile: mobile!, device_id: device_id, cucos)
                }
                else{
                    Commons.showDialogJK("Chưa lấy được deviceID")
                }
            }
        }
    }
    
    @objc func handleGoogleSignNotification(_ notification: NSNotification) {
        if  let infoGoogleUser = notification.userInfo?["dataUser"] as? SocialObject{
            print(infoGoogleUser.email as Any)
            if let id = infoGoogleUser.idUser {
                self.fullName = infoGoogleUser.fullName
                self.email = infoGoogleUser.email
                self.userId = id
                self.objectTransmit = ["fullName":self.fullName, "email":self.email, "userId":id] as AnyObject
                socialType = .Google
                self.userId = id
                flagLoginSocial = true
            }
        }
    }
    
    var flagLoginSocial:Bool = false {
        didSet{
            if flagLoginSocial {
                if let device_token = TPCakeDefaults.shared.device_token {
                    Commons.showLoading(self.view)
                    typeRequest = .AuthenSocail
                    //TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, device_token: device_token, cucos)
                    TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, self.email, self.fullName, device_token: device_token, cucos)
                }else{
                    Commons.showLoading(self.view)
                    typeRequest = .AuthenSocail
                    TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, self.email, self.fullName, device_token: nil, cucos)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (key, value)in stackView.subviews.enumerated(){
            if let btnView = value as? TPBaseViewImageWithLabel {
                btnView.indexPath = IndexPath(row: 1, section: 1)
                btnView.tag = key
                btnView.actionClosure = { indexPath in
                    self.goNext(index: btnView.tag)
                }
            }
        }
        
        
    }
    
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        let vc = TPLoginViewController()
        pushToViewController(vc, true)
    }
    func goNext(index: Int){
        switch index {
        case 0:
            // tới màn hình đăng ký số điện thoại
            let vc = TPMobileRegisterViewController()
            self.pushToViewController(vc, true)
            break
        case 1:
            // apple register
            if let idApple = TPCakeDefaults.shared.appleID {
                self.socialType = .Apple
                self.fullName = TPCakeDefaults.shared.appleFullName
                self.email = TPCakeDefaults.shared.appleEmail
                self.userId = idApple
                self.objectTransmit = ["fullName":self.fullName, "email":self.email, "userId":idApple] as AnyObject
                self.flagLoginSocial = true
                return
            }
            
            self.closureAppleLogin = { (user: SocialObject) in
                if let id = user.idUser {
                    self.socialType = .Apple
                    self.fullName = user.fullName
                    self.email = user.email
                    self.userId = id
                    //TPCakeDefaults.shared.appleID = id
                    //TPCakeDefaults.shared.appleEmail = self.email
                    //TPCakeDefaults.shared.appleFullName = self.fullName
                    self.objectTransmit = ["fullName":self.fullName, "email":self.email, "userId":id] as AnyObject
                    self.flagLoginSocial = true
                }else{
                    self.showToastFix(sms: "Chưa lấy được apple id")
                }
            }
            self.createLoginWithApple()
            break
        case 2:
            // facebook register
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                //Commons.showLoading(self.view)
            }
            //Commons.showLoading(self.view)
            self.createLoginWithFacebook { (user:SocialObject?) in
                if let user = user, let id = user.idUser {
                    self.socialType = .Facebook
                    self.fullName = user.fullName
                    self.email = user.email
                    self.userId = id
                    self.objectTransmit = ["fullName":self.fullName, "email":self.email, "userId":id] as AnyObject
                    Commons.hideLoading(self.view)
                    self.flagLoginSocial = true
                }
            }
            break
        case 3:
            // google register
            //isBussyHandleGoogle = false
            delegateSignInGoogle()
            break
        default:
            break
        }
    }
    
    
}

extension TPRegisterViewController {
    
    func cucos(_ data:Data?,_ response:URLResponse?,_ error: Error?)->Void{
        if let error=error{
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
        Commons.hideLoading(self.view)
        
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            if let data = shitDic["Data"] as? [String:Any]{
                if let mobile1 = data["mobile"] as? String, !Commons.stringIsNilOrEmpty(str: mobile1) {
                    mobile = mobile1
                }
                saveDataInfoUser(data: data)
            }
            
            switch typeRequest {
            case .AuthenSocail:
                switch code {
                case -839:
                    // Chưa có hồ sơ ứng với socialID => chuyển sang đăng ký social
                    let regisWithSocialVC = TPCompleteRegisterBySocialVC()
                    regisWithSocialVC.requestType = .CompleteRegisterBySocial
                    regisWithSocialVC.sosialType = socialType
                    regisWithSocialVC.sosialID = userId
                    regisWithSocialVC.stateSocialID = .notExist
                    regisWithSocialVC.dicData = objectTransmit as! [String : String?]
                    self.pushToViewController(regisWithSocialVC, true)
                    break
                case -840:
                    // Đã có hồ sơ ứng với socialID, chưa xác thực => Chuyển qua bước nhập sdt, để gửi OTP
                    let regisWithSocialVC = TPCompleteRegisterBySocialVC()
                    regisWithSocialVC.requestType = .CompleteRegisterBySocial
                    regisWithSocialVC.sosialType = socialType
                    regisWithSocialVC.sosialID = userId 
                    regisWithSocialVC.stateSocialID = .existButNotVerify
                    regisWithSocialVC.dicData = objectTransmit as! [String : String?]
                    self.pushToViewController(regisWithSocialVC, true)
                    break
                case -841:
                    // Đã có hồ sơ ứng với socialID, đăng nhập luôn => đã có accesstoken, vào main
                    self.pushToMainViewController()
                    break
                case -903, -902, -901, -900:
                    // Đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị
                    // Đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị
                    Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực", confirmAction: {[weak self] in
                        guard let weakSelf = self else{
                            return
                        }
                        extraOTPType = .GetBiophic
                        loginRegisterVia = .Social
                        weakSelf.flagVerifyDevice = true
                    })
                    break
                default:
                    break
                }
                typeRequest = .none
                
                break
            case .VerifyDevice:
                switch code {
                case 0:
                    let vc = TPOTPViewController()
                    vc.mobile = mobile ?? ""
                    vc.typeNext = .fromVerifyDevice
                    vc.viewControllerWantBack = TPRegisterViewControllerShared
                    vc.delegate = self
                    self.pushToViewController(vc, true)
                    break
                case -504: //    Số điện thoại chưa được xác thực
                    Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực", confirmAction: {[weak self] in
                        guard let weakSelf = self else{
                            return
                        }
                        //weakSelf.flagVerifyMobile = true
                    })
                    break
                default:
                    Commons.showDialogAlert(title: "ĐĂNG NHẬP", content: sms, inView: self.view, didFinishDismiss: {
                    })
                    break
                }
                
//                if code != 0 {
//                    Commons.showDialogAlert(title: "ĐĂNG KÝ", content: sms, inView: self.view, didFinishDismiss: {
//
//                    })
//                }else{
//                    let vc = TPOTPViewController()
//                    vc.mobile = mobile!
//                    vc.typeNext = .fromVerifyDevice
//                    self.pushToViewController(vc, true)
//                }
//                typeRequest = .none
//                mobile = nil
                break
            default:
                typeRequest = .none
                break
            }
            
            

        }
    }
}
