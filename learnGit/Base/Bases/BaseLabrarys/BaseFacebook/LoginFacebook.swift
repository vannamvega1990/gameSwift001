//
//  LoginFacebook.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import FBSDKLoginKit


extension BaseViewControllers {
    func createLoginWithFacebook(completed: @escaping (SocialObject?)->Void) {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData(completed: { (user: SocialObject?) in
                        completed(user)
                    })
                }
            }
            
        }
        
    }
    
    func getFBUserData(completed: @escaping (SocialObject?)->Void) {
        //var userSocial: SocialObject?
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result as Any)
                    //self.showSimpleAlert(title: "noi dung", ms: "\(result)")
                    if let dic = result as? [String:Any], let email = dic["email"] as? String , let name = dic["name"] as? String, let id = dic["id"] as? String{
                        print(email, name, id)
                        
                        
                        _ = "\(name)---\(email)---\(id)"
                        self.userSocial = SocialObject(idUser: id, email: email, fullName: name)
                        completed(self.userSocial)
                        
                        //NetworkManager.shared.requestCheckAuthenSocial(SocialId: id, SocialType: Constants.SocialType.Facebook, self.cucos)
                        
                    }
                }
            })
        }
    }
    
    // sign out facebook ----------------------
    func signOutFacebook(){
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
}
