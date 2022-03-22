//
//  TouchID.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchID {
    
    func showTouchID(){
        let context: LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "we need yor tounchID") { (wasSessesful, error) in
                if wasSessesful {
                    print("was 1 seccess")
                }else {
                    print("not loged in")
                }
            }
        }
    }
    
    
}

extension BaseViewControllers {
    func showTouchID(actionSusses:(()->Void)?, actionError:(()->Void)?, actionErrorDeivce:(()->Void)?, actionErrorVersionIos:(()->Void)?){
        print("hello there!.. You have clicked the touch ID")
        let myContext = LAContext()
        let appName = BaseCommons.instance.getAppName() ?? "This App"
        let myLocalizedReasonString = "\(appName) want to use touchID to login"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            //self.successLabel.text = "Awesome!!... User authenticated successfully"
                            actionSusses?()
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            //self.successLabel.text = "Sorry!!... User did not authenticate successfully"
                            actionError?()
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                //successLabel.text = "Sorry!!.. Could not evaluate policy."
                actionErrorDeivce?()
            }
        } else {
            // Fallback on earlier versions
            //successLabel.text = "Ooops!!.. This feature is not supported."
            actionErrorVersionIos?()
        }
    }
}
