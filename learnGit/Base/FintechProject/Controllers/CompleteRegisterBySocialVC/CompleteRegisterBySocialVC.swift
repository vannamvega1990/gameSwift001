//
//  CompleteRegisterBySocialVC.swift
//  FinTech
//
//  Created by Tu Dao on 5/12/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

enum StateSocialID {
    case notExist
    case existButNotVerify
    case exist
}

class CompleteRegisterBySocialVC: FTBaseViewController {
    
    @IBOutlet weak var textFildWithTitleMobile: FTBaseTextFildWithTitle!
    @IBOutlet weak var btnBack: FTBaseButtonBack!
    var dicData:[String:String?] = [:]
    var sosialType:Int = 0
    
    var stateSocialID:StateSocialID = .notExist
    var mobile = ""
    
    init() {
        super.init(nibName: "CompleteRegisterBySocialVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissRecognizer()
        //["fullName":fullName!, "email":email!, "userId":userId!]
        let fullName = dicData["fullName"]
        let email = dicData["email"]
        let userId = dicData["userId"]
        print(fullName!,email!,userId!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnBack.actionBackClosure = {
            self.logoutGoogle()
        }
    }
    
    @IBAction func btnRegisterViaSocalPressed(_ sender: UIButton) {
        if !checkValid() {
            return
        }
        if stateSocialID == .notExist {
            if let fullName = dicData["fullName"], let email = dicData["email"], let userId = dicData["userId"] {
                Commons.showLoading(view)
                print(email)
                mobile = textFildWithTitleMobile.textfield.text!//"0974399575"
                let sosialId = userId
                //let sosialType = sosialType
                let sosialEmailOrMobile = email
                let sosialName = fullName
                NetworkManager.shared.requestRegisterViaSocial(mobile,sosialId!,"\(sosialType)",
                sosialEmailOrMobile!,sosialName!,coordbust)
            }
        }
        else if stateSocialID == .existButNotVerify {
            if let userId = dicData["userId"] {
                Commons.showLoading(view)
                mobile = textFildWithTitleMobile.textfield.text!//"0974399575"
                let sosialId = userId
                NetworkManager.shared.requestSocialRegisterResentOTP(sosialId!, "\(sosialType)", mobile, coordbust)
            }
        }
        else{
            
        }
    }
}

extension CompleteRegisterBySocialVC {
    func checkMobile() -> Bool{
        if textFildWithTitleMobile.textfield.text == nil || textFildWithTitleMobile.textfield.text == "" {
            return false
        } else if textFildWithTitleMobile.textfield.text!.count < 6 {
            return false
        }
        return true
    }
    func checkValid()->Bool{
        if !checkMobile() {
            Commons.showDialogJK("Số điện thoại không hợp lệ !")
            return false
        }
        return true
    }
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
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
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                let vc = OTPViewController()
                vc.mobile = mobile
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
