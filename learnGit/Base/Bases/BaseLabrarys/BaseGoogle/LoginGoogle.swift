//
//  LoginGoogle.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import GoogleSignIn

//class LoginGoogle:NSObject, GIDSignInDelegate {

extension UIViewController {
    // create sign in google ------------------
    func createSignInGoogle(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.signIn()
    }
    // sign out google ----------------------
    func signOutGoogle(){
        GIDSignIn.sharedInstance().signOut()
    }
    
    func showSignInGoogle(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    func delegateSignInGoogle(){
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func signOutGoogle(){
        GIDSignIn.sharedInstance().signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        // ...
        print(fullName)
        print(email)
        print(userId)
        
        let googleObject = SocialObject(idUser: userId, email: email, fullName: fullName)
        let googleDataDict:[String: SocialObject] = ["dataUser": googleObject]
        BaseCommons.registerTransmitNotificationcenter(NotificationCenterName.KEY_GOOGLE_LOGINED, nil, googleDataDict)
        
        
        
        if currentVC is StartViewController {
            let vc = currentVC as! StartViewController
            vc.fullName = fullName
            vc.email = email
            vc.userId = userId
            vc.didLoginWithGoogle = true
        }

    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      print("user disconnects")
    }
    
}
 
