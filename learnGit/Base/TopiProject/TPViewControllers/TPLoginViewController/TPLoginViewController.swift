//
//  TPLoginViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

var TPLoginViewControllerShared:TPBaseViewController? = TPBaseViewController()

extension TPLoginViewController: OTPDelegate {
    func compliteVerifyDevice() {
        //Commons.showDialogJK("Đã xác thực thiết bị thành công, vui lòng đăng nhập")
        LoginAction()
    }
    
    
}

class TPLoginViewController: TPBaseViewController {

    var socialType: TPSocialType = .Google
    var fullName:String?
    var email:String?
    var userId:String?
    
    var mobile:String = ""
    
    @IBOutlet weak var tfMobile: TPBaseTextField!
    @IBOutlet weak var tfPassword: TPBaseTextField!
    @IBOutlet weak var btnLogin: TPBaseViewImageWithLabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var fingerStackView: UIStackView!
    
    enum TypeNext {
        case goVerifyDevice
        case goVerifyMobile
        case login
        case loginViaSocial
        case getBiometricToken
        case none
    }
    var typeNext: TypeNext = .none
    
    var flagLoginSocial:Bool = false {
        didSet{
            if flagLoginSocial {
                if let device_token = TPCakeDefaults.shared.device_token, !Commons.stringIsNilOrEmpty(str: device_token) {
                    Commons.showLoading(self.view)
                    typeNext = .loginViaSocial
                    //TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, device_token: device_token, coordbust)
                    TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, self.email, self.fullName, device_token: device_token, coordbust)
                }else{
                    Commons.showLoading(self.view)
                    typeNext = .loginViaSocial
                    TPNetworkManager.shared.requestCheckAuthenSocial(SocialId: self.userId!, SocialType: socialType.rawValue, self.email, self.fullName, device_token: nil, coordbust)
                }
            }
        }
    }
    

    init() {
        super.init(nibName: "TPLoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var flagVerifyDevice: Bool = false {
        didSet{
            if flagVerifyDevice {
                //mobile = tfMobile.text!
                if let device_id = deviceID {
                    Commons.showLoading(view)
                    typeNext = .goVerifyDevice
                    TPNetworkManager.shared.requestVerifyDevice(mobile: mobile, device_id: device_id, coordbust)
                }
                else{
                    Commons.showDialogJK("Chưa lấy được deviceID")
                }
            }
        }
    }
    
    var flagVerifyMobile: Bool = false {
        didSet{
            if flagVerifyMobile {
                mobile = tfMobile.text!
                typeNext = .goVerifyMobile
                TPNetworkManager.shared.requestResendOTP(mobile: mobile, coordbust)
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
    
    @IBAction func btnEyePressed(_ sender: UIButton) {
        tfPassword.isSecurity = !tfPassword.isSecurity
        let imgName = !tfPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    
    @IBAction func btnRegisterBackPressed(_ sender: UIButton) {
        //popBackViewController(true)
        appDelegate.changeRootView(newRootView: TPRegisterViewController())
    }
    
    deinit {
        TPLoginViewControllerShared = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard stateLogin == .Logined  else {
            return
        }
        guard let obj = objectReciver as? String else {
            return
        }
        guard  let s1 = obj.components(separatedBy: "---").first else {
            return
        }
        guard let s2 = obj.components(separatedBy: "---").last else {
            return
        }
        guard s1 == "TPCreateNewPasswordVC"  else {
            return
        }
        guard !mobileTemp.elementsEqual("") else {
            return
        }
        Commons.showLoading(self.view)
        typeNext = .login
        let device_token1 = TPCakeDefaults.shared.device_token ?? ""
        TPNetworkManager.shared.requestLogin(mobile: mobileTemp, password: s2, device_token: device_token1, biometric_token: "", coordbust)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mobile = TPCakeDefaults.shared.mobile {
            tfMobile.text = mobile
        }
        
        mobileTemp = TPCakeDefaults.shared.mobile ?? ""
        
        
//        if let mobile = CakeDefaults.shared.mobile, let pass = BaseCommons.getPassword() {
//            mobileNumber = mobile
//            password = pass
//            showTouchID(actionSusses: {
//                Commons.showLoading(self.view)
//                NetworkManager.shared.requestLogin(mobile:mobile, password:pass, self.coordbustKeychain)
//            }, actionError: nil, actionErrorDeivce: nil, actionErrorVersionIos: nil)
//        }
        btnLogin.indexPath = IndexPath(row: 1, section: 1)
        btnLogin.actionClosure = { indexPath in
            self.goNext()
        }
        for (key, value)in stackView.subviews.enumerated(){
            if let btnView = value as? TPBaseViewImageWithLabel {
                btnView.indexPath = IndexPath(row: 1, section: 1)
                btnView.tag = key
                btnView.actionClosure = { indexPath in
                    self.goSocialLogin(index: btnView.tag)
                }
            }
        }
        
    }
    func goSocialLogin() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TPLoginViewControllerShared = self
        showSignInGoogle()
        let arrTextField = [tfMobile!,tfPassword!]
        addCustomToolBarForUITextfild(arrTextFild: arrTextField)
        BaseCommons.regisReceverNotificationcenter(self, NotificationCenterName.KEY_GOOGLE_LOGINED, nil, selector: #selector(handleGoogleSignNotification(_:)))
        
        
        if let touchID = TPCakeDefaults.shared.isTouchID {
            self.fingerStackView.subviews.first!.isHidden = false//!touchID
        }else{
            self.fingerStackView.subviews.first!.isHidden = false
        }
    }
    
    @IBAction func btnTouchIDPressed(_ sender: UIButton) {
        let touchID = TPCakeDefaults.shared.isTouchID ?? nil
        switch touchID {
        case nil, false:
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Bạn chưa bật chức năng vân tay, hãy đăng nhập xong, vào phần cài đặt")
            break
        default:
            showTouchID(actionSusses: {
                if let pass = BaseCommons.getPassword() {
                    self.tfPassword.text = pass
                    if let _ = self.tfMobile.text {
                        self.LoginAction()
                    }
                }
            }, actionError: nil, actionErrorDeivce: nil, actionErrorVersionIos: nil)
            break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        signOutGoogle()
        removeAllObserver()
    }
    
    func goNext() {
        let stringPassword = tfPassword.text
        let stringMobile = tfMobile.text
//        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfMobile,tfPassword], sms: ["🔴 Số điện thoại đang để trống","🔴 Mật khẩu đang để trống"])
//        if !check {
//            return
//        }
        if Commons.stringIsNilOrEmpty(str: stringMobile) {
            tfMobile.borderColor = .red
            showErrorBelowUITextfild(tf: tfMobile, sms: "🔴 Số điện thoại đang để trống.")
            return
        }
        if Commons.stringIsNilOrEmpty(str: stringPassword) {
            tfPassword.borderColor = .red
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu đang để trống.")
            return
        }
        if stringMobile!.count < 6 {
            tfMobile.borderColor = .red
            showErrorBelowUITextfild(tf: tfMobile, sms: "🔴 Số điện thoại không đúng.")
            return
        }
        if stringPassword!.count < 6 || stringPassword!.count > 30 || !stringPassword!.checkSpecialCharacter() || !stringPassword!.checkBigCharacter() || !stringPassword!.checkHaveNumber() {
            tfPassword.borderColor = .red
            //let sms1 = "🔴 Mật khẩu cần có \n   ✓  Ít nhất 6 ký tự trở lên \n   ✓  Ít nhất 1 ký tự số \n   ✓  Ít nhất 1 ký tự đặc biệt \n   ✓  Ít nhất 1 ký tự in hoa"
            //showErrorBelowUITextfild(tf: tfPassword, sms: sms1)
            
            showErrorBelowUITextfild(tf: tfPassword, sms: "🔴 Mật khẩu không chính xác.")
            return
        }
        
        //if check {
            LoginAction()
        //}
    }
    
    var flagLoginMobile:Bool = false {
        didSet{
            if flagLoginMobile {
//                guard let biometric_token = TPCakeDefaults.shared.biometric_token else {
//                    return
//                }
                if let device_token = TPCakeDefaults.shared.device_token {
                    mobile = tfMobile.text!
                    let password = tfPassword.text!
                    Commons.showLoading(self.view)
                    typeNext = .login
                    TPNetworkManager.shared.requestLogin(mobile:mobile, password:password, device_token: device_token, biometric_token: "", coordbust)
                }else{
                    Commons.showDialogConfirm(title: "Thiết bị này chưa được xác thực", content: "Bạn có muốn xác thực cho số điện thoại \(self.tfMobile.text!) ?", titleButton: "Xác thực", confirmAction: {[weak self] in
                        guard let weakSelf = self else{
                            return
                        }
                        weakSelf.mobile = weakSelf.tfMobile.text!
                        weakSelf.flagVerifyDevice = true
                    })
                }
            }
        }
    }
    
    private func LoginAction(){
        if let device_token = TPCakeDefaults.shared.device_token {
            mobile = tfMobile.text!
            let password = tfPassword.text!
            
            Commons.showLoading(self.view)
            
            //typeNext = .getBiometricToken
            //TPNetworkManager.shared.requestBiometricToken(mobile: mobile, password: password, device_token: device_token, coordbust)
            
            typeNext = .login
            TPNetworkManager.shared.requestLogin(mobile:mobile, password:password, device_token: device_token, biometric_token: "", coordbust)
        }else{
            mobile = tfMobile.text!
            let password = tfPassword.text!
            Commons.showLoading(self.view)
            typeNext = .login
            TPNetworkManager.shared.requestLogin(mobile:mobile, password:password, device_token: "", biometric_token: "", coordbust)
            
//            Commons.showDialogConfirm(title: "Thiết bị này chưa được xác thực", content: "Bạn có muốn xác thực cho số điện thoại \(self.tfMobile.text!) ?", titleButton: "Xác thực", confirmAction: {[weak self] in
//                guard let weakSelf = self else{
//                    return
//                }
//                extraOTPType = .GetBiophic
//                weakSelf.mobile = weakSelf.tfMobile.text!
//                weakSelf.flagVerifyDevice = true
//            })
        }
    }
    
    @IBAction func btnForgetPasswordPressed(_ sender: UIButton) {
        let vc = TPEnterMobileForgetPasswordVC()
        stateLogin = .Notyet
        pushToViewController(vc, true)
    }
}

extension TPLoginViewController{
    func goSocialLogin(index: Int){
        typeNext = .loginViaSocial
        switch index {
        case 0:
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
        case 1:
            // facebook register
            self.createLoginWithFacebook { (user:SocialObject?) in
                if let user = user, let id = user.idUser {
                    self.socialType = .Facebook
                    self.fullName = user.fullName
                    self.email = user.email
                    self.userId = id
                    self.objectTransmit = ["fullName":self.fullName, "email":self.email, "userId":id] as AnyObject
                    self.flagLoginSocial = true
                }
            }
            break
        case 2:
            // google register
            delegateSignInGoogle()
            break
        default:
            break
        }
    }
}


extension TPLoginViewController {
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
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Không gọi đc server", inView: self.view, didFinishDismiss: nil)
            return
        }
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
            
            switch typeNext {
            case .getBiometricToken:
                switch code {
                case 0:
                    if let biometricToken = shitDic["Data"] as? String {
                        print("---- biometricToken : \(biometricToken)")
                        //TPCakeDefaults.shared.biometric_token = biometricToken
                        //print(TPCakeDefaults.shared.biometric_token)
                        flagLoginMobile = true
                    }else{
                        Commons.showDialogAlert(title: "THÔNG BÁO", content: "ko có biometric token", inView: self.view, didFinishDismiss: nil)
                    }
                    break
                case -901:
                    //  Đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị
                    Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực") {
                        extraOTPType = .GetBiophic
                        self.mobile = self.tfMobile.text!
                        self.flagVerifyDevice = true
                    }
                    break
                default:
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                    break
                }
                break
            case .goVerifyMobile:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                        
                    })
                }else{
                    let vc = TPOTPViewController()
                    vc.mobile = tfMobile.text!
                    vc.typeNext = .fromMobileRegister
                    self.pushToViewController(vc, true)
                }
                break
            case .goVerifyDevice:
                switch code {
                case 0:
                    let vc = TPOTPViewController()
                    vc.mobile = mobile
                    mobileTemp = mobile
                    TPPasswordTemp = tfPassword.text!
                    vc.typeNext = .fromVerifyDevice
                    vc.viewControllerWantBack = TPLoginViewControllerShared
                    vc.delegate = self
                    self.pushToViewController(vc, true)
                    break
                case -504: //    Số điện thoại chưa được xác thực
                    Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực", confirmAction: {[weak self] in
                        guard let weakSelf = self else{
                            return
                        }
                        weakSelf.flagVerifyMobile = true
                    })
                    break
                default:
                    Commons.showDialogAlert(title: "ĐĂNG NHẬP", content: sms, inView: self.view, didFinishDismiss: {
                        
                    })
                    break
                }
                break
            case .loginViaSocial:
                if let data = shitDic["Data"] as? [String:Any]{
                    if let mobile1 = data["mobile"] as? String, !Commons.stringIsNilOrEmpty(str: mobile1) {
                        mobile = mobile1
                    }
                    saveDataInfoUser(data: data)
                }
                switch code {
                case -839:
                    // Chưa có hồ sơ ứng với socialID => chuyển sang đăng ký social
                    let regisWithSocialVC = TPCompleteRegisterBySocialVC()
                    regisWithSocialVC.requestType = .CompleteRegisterBySocial
                    regisWithSocialVC.sosialType = socialType
                    regisWithSocialVC.stateSocialID = .notExist
                    regisWithSocialVC.dicData = objectTransmit as! [String : String?]
                    self.pushToViewController(regisWithSocialVC, true)
                    break
                case -840:
                    // Đã có hồ sơ ứng với socialID, chưa xác thực => Chuyển qua bước nhập sdt, để gửi OTP
                    let regisWithSocialVC = TPCompleteRegisterBySocialVC()
                    regisWithSocialVC.requestType = .CompleteRegisterBySocial
                    regisWithSocialVC.sosialType = socialType
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
                
                break
            case .login:
                if let data = shitDic["Data"] as? [String:Any]{
                    saveDataInfoUser(data: data)
                }
                if code != 0 {
                    if code == -901 || code == -900 || code == -902 || code == -903{
                        // -900 Phiên đăng nhập trên thiết bị đã hết hạn. Vui lòng xác thực thiết bị.
                        // -901: đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị.
                        // -902: đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị.
                        // -903: đăng nhập lần đầu trên thiết bị mới. Vui lòng xác thực thiết bị.
                        // Xác thực device
                        Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực", confirmAction: {[weak self] in
                            guard let weakSelf = self else{
                                return
                            }
                            extraOTPType = .GetBiophic
                            weakSelf.mobile = weakSelf.tfMobile.text!
                            weakSelf.flagVerifyDevice = true
                        })
                    }
                    else if code == -504 {
                        // Xác thực số điện thoại
                        Commons.showDialogConfirm(title: "ĐĂNG NHẬP", content: sms, titleButton: "Xác thực", confirmAction: {[weak self] in
                            guard let weakSelf = self else{
                                return
                            }
                            weakSelf.flagVerifyMobile = true
                        })
                    }
                    else{
                        Commons.showDialogAlert(title: "ĐĂNG NHẬP", content: sms, inView: self.view, didFinishDismiss: {
                        })
                    }
                }else{
                    //TPCakeDefaults.shared.mobile = self.mobile
                    TPCakeDefaults.shared.mobile = mobileTemp
                    BaseCommons.setPassword(password: self.tfPassword.text!)
                    let vc = TPTabBarViewController()
                    navigationController?.pushViewController(vc, animated: true)
                }
                break
            default:
                break
            }
            
        }
    }
}
