//
//  FTBaseViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/6/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import GoogleSignIn

class FTBaseViewController: BaseViewControllers {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavigation(isHidden: true)
        //setGradientForNavigationBar()
    }
    
    func saveToken(_ access_token: String){
        //CakeDefaults.shared.access_token = access_token
    }
    
    func showDialogMessage(_ sms: String){
        Commons.showDialogJK(sms)
    }
    
    func logoutGoogle(){
        GIDSignIn.sharedInstance().signOut()
    }
   
}
