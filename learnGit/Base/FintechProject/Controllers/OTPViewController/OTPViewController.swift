//
//  OTPViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/11/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

protocol DelegateTest {
    func clearPopup()
}

class OTPViewController: FTBaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var stackTextField: UIStackView!
    @IBOutlet weak var titleMobile: UILabel!
    var arrayTextField:[UITextField] = []
    var mobile:String = ""
    
    var delegate:DelegateTest?

    init() {
        super.init(nibName: "OTPViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissRecognizer()
        stackTextField.subviews.forEach { (v:UIView) in
            if let tf = v as? UITextField {
                tf.delegate = self
                tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                arrayTextField = arrayTextField + [tf]
            }
        }
        titleMobile.text = "Mã OTP đã được gửi tới số " + mobile + "."
    }
    var stopCheckValid: Bool = false
    @IBAction func btnVerifyPressed(_ sender: UIButton) {
        stopCheckValid = false
        let check = checkValidInput()
        if !check.0 {
            showDialogJK(check.1)
        }else{
            Commons.showLoading(view)
            //let mobile = mobile //"0962877090"//"0974399575"
            let otp = getValueOTP() //"123456"
            NetworkManager.shared.requestVerifyOTP(mobile: mobile, otp: otp, coordbust)
        }
    }
    
    @IBAction func btnResendOTPPressed(_ sender: UIButton) {
        Commons.showLoading(view)
        //let mobile = "0962877090"//"0974399575"
        NetworkManager.shared.requestResendOTP(mobile: mobile, coordbustResendOtp)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let txt = textField.text, txt.count >= 1 {
            let index = textField.tag + 1
            if index < arrayTextField.count {
                arrayTextField[index].becomeFirstResponder()
            }
        }
        if let txt = textField.text, txt.count == 2 {
            textField.text = String(txt.last!)
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      //textField.resignFirstResponder()
        return true
    }

}

extension OTPViewController {
    func coordbustResendOtp(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
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
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                CakeDefaults.shared.access_token = access_token
            }
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                Commons.showDialogJK(sms)
            }
        }
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
            if let data = shitDic["Data"] as? [String:Any], let access_token = data["access_token"] as? String {
                saveToken(access_token)
            }
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    //self.popToRootViewController(true)
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationCenterName.hidePopup), object: nil)
                    self.pushToMainViewController()                   
                })
            }
        }
    }
    
    func checkValidInput()->(Bool, String){
        if let tf = stackTextField.subviews[0] as? BaseTextField {
            let stringCode = tf.text
            if Commons.stringIsNilOrEmpty(str: stringCode){
                tf.borderColor = .red
                return (false,"Không được để trống mã code.")
            }
        }
        if let tf = stackTextField.subviews[1] as? BaseTextField {
            let stringCode = tf.text
            if Commons.stringIsNilOrEmpty(str: stringCode){
                tf.borderColor = .red
                return (false,"Không được để trống mã code.")
            }
        }
        if let tf = stackTextField.subviews[2] as? BaseTextField {
            let stringCode = tf.text
            if Commons.stringIsNilOrEmpty(str: stringCode){
                tf.borderColor = .red
                return (false,"Không được để trống mã code.")
            }
        }
        if let tf = stackTextField.subviews[3] as? BaseTextField {
            let stringCode = tf.text
            if Commons.stringIsNilOrEmpty(str: stringCode){
                tf.borderColor = .red
                return (false,"Không được để trống mã code.")
            }
        }
//        for each in stackTextField.subviews {
//            if let tf = each as? BaseTextField {
//                let stringCode = tf.text
//                if Commons.stringIsNilOrEmpty(str: stringCode){
//                    tf.borderColor = .red
//                    return (false,"Không được để trống mã code.")
//                }
//            }
//        }
        return (true,"ok")
    }
    
    func getValueOTP() -> String{
        var value = ""
        stackTextField.subviews.forEach { (v:UIView) in
            if let tf = v as? UITextField {
                value = value + (tf.text ?? "" )
            }
        }
        return value
    }
}
