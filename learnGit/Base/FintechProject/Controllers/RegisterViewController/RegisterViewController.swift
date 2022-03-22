//
//  RegisterViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/6/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class RegisterViewController: FTBaseViewController {
    
    @IBOutlet var arrayTextfieldWithTitle: [FTBaseTextFildWithTitle]!
    @IBOutlet weak var tfName: FTBaseTextFildWithTitle!
    @IBOutlet weak var tfPhone: FTBaseTextFildWithTitle!
    @IBOutlet weak var tfEmail: FTBaseTextFildWithTitle!
    @IBOutlet weak var tfPassword: FTBaseTextFildWithTitle!
    init() {
        super.init(nibName: "RegisterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissRecognizer()
        //AppDelegate.disableIQKeyboard()
        let imgNext =  #imageLiteral(resourceName: "ic_nextYellow")
        let backToolbarItem = UIBarButtonItem(image: imgNext , style: .plain, target: self, action: #selector(xuly))
        let backToolbarItem2 = UIBarButtonItem(title: "123", style: UIBarButtonItem.Style.plain, target: self, action: nil)
        //tf1.textfield.addItem = [backToolbarItem, backToolbarItem2]
        //tf1.textfield.addToolBar()
//        tf1.textfield.nextItemAction = {
//            print("123")
//        }
        //tf2.textfield.addItem = [backToolbarItem, backToolbarItem2]
        //tf2.textfield.addToolBar()
//        arrayTextfieldWithTitle.last!.textfield.addItem = [backToolbarItem, backToolbarItem2]
//        arrayTextfieldWithTitle.last!.textfield.addToolBar()
//        arrayTextfieldWithTitle.forEach { (baseTF: FTBaseTextFildWithTitle) in
//            baseTF.textfield.addItem = [backToolbarItem, backToolbarItem2]
//            baseTF.textfield.addToolBar()
//            //baseTF.textfield.layoutIfNeeded()
//        }
    }
    @objc func xuly(){
        print("123")
    }
    var mobile = ""
    @IBAction func btnRegisterPressed(_ sender: UIButton) {
        let check = checkValidInput()
        if !check.0 {
            showDialogJK(check.1)
        }else{
            Commons.showLoading(view)
            mobile = tfPhone.textfield.text!//"0974399575"
            let password = tfPassword.textfield.text!//"Vega@123"
            let full_name = tfName.textfield.text!//"tran van nam"
            let email = tfEmail.textfield.text!//"tranvannam1998@gmail.com"
            let device = "ios"
            NetworkManager.shared.requestRegister(mobile: mobile, password: password, full_name: full_name, email: email, device: device, coordbust)
        }
    }
}


extension RegisterViewController {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
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
    func checkValidInput()->(Bool, String){
        let stringFullname = tfName.textfield.text
        let stringMobile = tfPhone.textfield.text
        let stringEmail = tfEmail.textfield.text
        let stringPassword = tfPassword.textfield.text
        if Commons.stringIsNilOrEmpty(str: stringFullname){
            tfName.textfield.borderColor = .red
            return (false,"Họ tên đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringMobile){
            tfPhone.textfield.borderColor = .red
            return (false,"Số điện thoại đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringEmail){
            tfEmail.textfield.borderColor = .red
            return (false,"Email đang để trống.")
        }
        if Commons.stringIsNilOrEmpty(str: stringPassword){
            tfPassword.textfield.borderColor = .red
            return (false,"Mật khẩu đang để trống.")
        }
        if stringFullname!.count < 6 {
            tfName.textfield.borderColor = .red
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        if stringMobile!.count < 6 {
            tfPhone.textfield.borderColor = .red
            return (false,"Số điện thoại phải lớn hơn 6 ký tự.")
        }
        if stringEmail!.count < 6 {
            tfEmail.textfield.borderColor = .red
            return (false,"Email phải lớn hơn 6 ký tự.")
        }
        if stringPassword!.count < 6 {
            tfPassword.textfield.borderColor = .red
            return (false,"Mật khẩu phải lớn hơn 6 ký tự.")
        }
        if !BaseCommons.checkEmail(str: stringEmail!){
            tfEmail.textfield.borderColor = .red
            return (false,"Email không đúng định dạng.")
        }
        return (true,"ok")
    }
    
    
    
    func checkName() -> Bool{
        if tfName.textfield.text == nil || tfName.textfield.text == "" {
            return false
        } else if tfName.textfield.text!.count < 6 {
            return false
        }
        return true
    }
    func checkPhone() -> Bool{
        if tfPhone.textfield.text == nil || tfPhone.textfield.text == "" {
            return false
        } else if tfPhone.textfield.text!.count < 6 {
            return false
        }
        return true
    }
    func checkEmail() -> Bool{
        if tfEmail.textfield.text == nil || tfEmail.textfield.text == "" {
            return false
        } else if tfEmail.textfield.text!.count < 6 {
            return false
        }
        return true
    }
    func checkPassword() -> Bool{
        if tfPassword.textfield.text == nil || tfPassword.textfield.text == "" {
            return false
        } else if tfPassword.textfield.text!.count < 6 {
            return false
        }
        return true
    }
    func checkValid()->Bool{
        if !checkName(){
            Commons.showDialogJK("Họ tên không hợp lệ !")
            return false
        } else if !checkPhone() {
            Commons.showDialogJK("Số điện thoại không hợp lệ !")
            return false
        } else if !checkEmail() {
            Commons.showDialogJK("Email không hợp lệ !")
            return false
        } else if !checkPassword() {
            Commons.showDialogJK("Mật khẩu không hợp lệ !")
            return false
        }
        return true
    }
}
