////
////  LoginByApple.swift
////  VegaFintech
////
////  Created by Tu Dao on 6/7/21.
////  Copyright © 2021 Vega. All rights reserved.
////
//
//import UIKit
//import AuthenticationServices
//
//extension BaseViewControllers {
//
//    func createLoginWithApple(){
//        if #available(iOS 13.0, *) {
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//            authorizationController.delegate = self
//            authorizationController.performRequests()
//        } else {
//            // Fallback on earlier versions
//            let sms = "Phiên bản iOS thấp hơn iOS 13.0 không được hỗ trợ !"
//            Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
//        }
//    }
//}
//extension BaseViewControllers: ASAuthorizationControllerDelegate{
//    
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
//            var userIdentifier = appleIDCredential.user
//            var fullName = appleIDCredential.fullName
//            var email = appleIDCredential.email
//            var nameUser: String?
//            
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
//                if let fullNameApple1 = fullNameApple {
//                    TPCakeDefaults.shared.appleFullName = fullNameApple1
//                }
//                
//                
//            }
//            if let email1 = email {
//                TPCakeDefaults.shared.appleEmail = email1
//            }
//            if let userIdentifier1 = userIdentifier as? String {
//                TPCakeDefaults.shared.appleID = userIdentifier1
//            }
//            let email1 = TPCakeDefaults.shared.appleEmail
//            let userId = TPCakeDefaults.shared.appleID
//            let nameUser1 = TPCakeDefaults.shared.appleFullName
//            self.userSocial = SocialObject(idUser: userId, email: email1, fullName: nameUser1)
//            
//            let msm = "User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email)) "
//            print(msm)
//            //self.showSimpleAlert(title: "noi dung", ms: msm)
//            //completed(self.userSocial)
//            self.closureAppleLogin?(self.userSocial!)
//            //self.socialType = .Apple
//            //NetworkManager.shared.requestCheckAuthenSocial(SocialId: userIdentifier, SocialType: Constants.SocialType.Apple, self.cucos)
//            
//        }
//    }
//}
