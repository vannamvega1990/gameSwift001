//
//  StartViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/10/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

enum SocialType: Int {
    case Facebook = 0
    case Google = 1
    case Apple = 2
}

class StartViewController: FTBaseViewController {
    
    init() {
        super.init(nibName: "StartViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var versionlabel: UILabel!
    @IBOutlet weak var containerStackView: UIStackView!
    var socialType: SocialType = .Google
    var fullName:String?
    var email:String?
    var userId:String?
    var didLoginWithGoogle:Bool = false{
        didSet{
            print("da login google \(fullName)---\(email)---\(userId)")
            if didLoginWithGoogle, let _ = fullName, let _ = email, let _ = userId{
                Commons.showLoading(self.view)
                NetworkManager.shared.requestCheckAuthenSocial(SocialId: userId!, SocialType: socialType.rawValue, cucos)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentVC = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removePopupView),
                                               name: NSNotification.Name(Constants.NotificationCenterName.hidePopup),
                                               object: nil)
        let version = Commons.shared.getVersionApp() ?? "nil"
        let build = Commons.shared.getBuildApp() ?? "nil"
        let ver = "\(version) build \(build)"
        versionlabel.text = "Version App: " + ver
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        beginApp = false
    }
    
    @objc func removePopupView(){
        
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        //let loginVC = LoginViewController()
        let streechLoginVC = StreechLoginViewController()
        DispatchQueue.main.async {
            self.pushToViewController(streechLoginVC, true)
        }
    }
    
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        let heightOfPop: CGFloat = 216 + 76
        let popV = ViewOptionRegister(frame: CGRect(x: 0, y: 0, width: sizeScreen.width, height: heightOfPop))
        showPopup(popupPosition: .botton, popView: popV)
        //addPopupView(popupView: popV)
        popV.actionLoginWithGoole = {
            GIDSignIn.sharedInstance()?.signIn()
        }
        popV.actionLoginWithFacebook = {
            
            self.createLoginWithFacebook { (user:SocialObject?) in
                if let user = user, let id = user.idUser {
                    self.socialType = .Facebook
                    self.fullName = user.fullName
                    self.email = user.email
                    self.userId = id
                    Commons.showLoading(self.view)
                    NetworkManager.shared.requestCheckAuthenSocial(SocialId: id, SocialType: Constants.SocialType.Facebook, self.cucos)
                }
            }
        }
        popV.actionLoginWithApple = {
            self.closureAppleLogin = { (user: SocialObject) in
                if let id = user.idUser {
                    self.socialType = .Apple
                    self.fullName = user.fullName
                    self.email = user.email
                    self.userId = id
                    Commons.showLoading(self.view)
                    NetworkManager.shared.requestCheckAuthenSocial(SocialId: id, SocialType: Constants.SocialType.Apple, self.cucos)
                }
            }
            self.createLoginWithApple()
        }
    }
    
    
}


//extension StartViewController: ASAuthorizationControllerDelegate {
//
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//            if let fullName = fullName {
//                let givenName = fullName.givenName
//                let familyName = fullName.familyName
//                var fullNameApple: String?
//                if let givenName = givenName{
//                    fullNameApple = givenName
//                }
//                if let familyName = familyName {
//                    if fullNameApple == nil {
//                        fullNameApple = familyName
//                    }else{
//                        fullNameApple = fullNameApple! + " " + familyName
//                    }
//                }
//                if let fullNameApple = fullNameApple {
//                    CakeDefaults.shared.appleFullName = fullNameApple
//                }
//                if let email = email {
//                    CakeDefaults.shared.appleEmail = email
//                }
//                self.email = email ?? CakeDefaults.shared.appleEmail
//                self.userId = userIdentifier
//                self.fullName = fullNameApple ?? CakeDefaults.shared.appleFullName
//            }
//
//            let msm = "User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email)) "
//            print(msm)
//            //self.showSimpleAlert(title: "noi dung", ms: msm)
//            self.socialType = .Apple
//            NetworkManager.shared.requestCheckAuthenSocial(SocialId: userIdentifier, SocialType: Constants.SocialType.Apple, self.cucos)
//
//        }
//    }
//}


extension StartViewController {
//    func createLoginWithFacebook(){
//        let fbLoginManager : LoginManager = LoginManager()
//        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
//          if (error == nil){
//            let fbloginresult : LoginManagerLoginResult = result!
//            // if user cancel the login
//            if (result?.isCancelled)!{
//                    return
//            }
//            if(fbloginresult.grantedPermissions.contains("email"))
//            {
//              self.getFBUserData()
//            }
//          }
//        }
//    }
    
//    func getFBUserData(){
//        if((AccessToken.current) != nil){
//            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
//          if (error == nil){
//            //everything works print the user data
//            print(result)
//            //self.showSimpleAlert(title: "noi dung", ms: "\(result)")
//            if let dic = result as? [String:Any], let email = dic["email"] as? String , let name = dic["name"] as? String, let id = dic["id"] as? String{
//                print(email, name, id)
//                self.socialType = .Facebook
//                //["fullName":fullName!, "email":email!, "userId":userId!]
//                self.fullName = name
//                self.email = email
//                self.userId = id
//
//                let sms = "\(name)---\(email)---\(id)"
//                //self.showSimpleAlert(title: "noi dung", ms: sms)
//                NetworkManager.shared.requestCheckAuthenSocial(SocialId: id, SocialType: Constants.SocialType.Facebook, self.cucos)
//
//            }
//          }
//        })
//      }
//    }
    
    
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
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let _ = shitDic["Message"]  as? String {
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                saveToken(access_token)
            }
            if code == -839 {
                // Chưa có hồ sơ ứng với socialID => chuyển sang đăng ký social
                let regisWithSocialVC = CompleteRegisterBySocialVC()
                regisWithSocialVC.sosialType = socialType.rawValue
                regisWithSocialVC.stateSocialID = .notExist
                let sms = "\(fullName)---\(email)---\(userId)"
                //self.showSimpleAlert(title: "noi dung 123", ms: sms)
                if let _ = fullName, let _ = email, let _ = userId {
                    regisWithSocialVC.dicData = ["fullName":fullName!, "email":email!, "userId":userId!]
                        self.pushToViewController(regisWithSocialVC, true)
                }else{
                    //self.showSimpleAlert(title: "noi dung 123456", ms: sms)
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: "Dữ liệu chưa đầy đủ", inView: self.view, didFinishDismiss: nil)
                }
            }else if code == -840{
                // Đã có hồ sơ ứng với socialID, chưa xác thực => Chuyển qua bước nhập sdt, để gửi OTP
                let regisWithSocialVC = CompleteRegisterBySocialVC()
                regisWithSocialVC.sosialType = socialType.rawValue
                regisWithSocialVC.stateSocialID = .existButNotVerify
                if let _ = fullName, let _ = email, let _ = userId {
                    regisWithSocialVC.dicData = ["fullName":fullName!, "email":email!, "userId":userId!]
                        self.pushToViewController(regisWithSocialVC, true)
                }else{
                    self.showDialogJK("Dữ liệu chưa đầy đủ")
                }
            }else if code == -841{
                // Đã có hồ sơ ứng với socialID, đăng nhập luôn => đã có accesstoken, vào main
                self.pushToMainViewController() 
            }else{
                
            }
        }
    }
}
