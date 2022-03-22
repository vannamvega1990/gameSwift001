//
//  TPBioTokenViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

protocol BioTokenDelegate {
    func conpleteGetBioToken(state:Bool)
}

class TPBioTokenViewController: TPBaseViewController {
    
    @IBOutlet weak var tfPassword: TPBaseTextFieldWithLabel!
    
    var delegate: BioTokenDelegate?
    var isCompleteGetBioToken:Bool = false
    
    init() {
        super.init(nibName: "TPBioTokenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum RequestType {
        case GetBioToken
        case ForgetPassword
        case none
    }
    var requestType: RequestType = .none
    
    var flagForgetPassword: Bool = false {
        didSet {
            if flagForgetPassword {
                requestType = .ForgetPassword
                Commons.showLoading(self.view)
                TPNetworkManager.shared.requestForgetPasswordSendOTP(mobileTemp, self.coordbust)
            }
        }
    }
    @IBAction func btnForgetPasswordPressed(_ sender: UIButton) {
        Commons.showDialogConfirm(title: "Đặt lại mật khẩu", content: "Bạn sẽ phải đăng xuất khỏi tài khoản này để đặt lại mật khẩu.") {
            self.flagForgetPassword = true
        }
//        let vc = TPEnterMobileForgetPasswordVC()
//        stateLogin = .Logined
//        requestType = .ForgetPassword
//        pushToViewController(vc, true)
    }
    
    @IBAction func btnEyePressed(_ sender: UIButton) {
        print("---\(tfPassword.isSecurity)")
        tfPassword.isSecurity = !tfPassword.isSecurity
        let imgName = !tfPassword.isSecurity ? "ic_eye" : "eyes-bgsd"
        sender.setImage(UIImage(named: imgName), for: .normal)
    }
    
    @IBAction func btnContinusPressed(_ sender: UIButton) {
        self.hideKeyboard()
        let check = checkValidInput()
        if check.0 {
            getBioToken1()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        delegate?.conpleteGetBioToken(state: isCompleteGetBioToken)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //var string_Data = KeyChain.stringToNSDATA("MANIAK")
        //    KeyChain.save("ZAHAL", data: string_Data)
        
//        let string_Data = BaseKeyChain.stringToDATA(string: "MANIAK")
//        BaseKeyChain.save(key: "ZAHAL", data: string_Data)
//
//        let RecievedDataStringAfterSave = BaseKeyChain.load(key: "ZAHAL1")
//        let NSDATAtoString = BaseKeyChain.DATAtoString(data: RecievedDataStringAfterSave!)
//        print(NSDATAtoString)
        let bioTOken = getBioToken()
        print(bioTOken)
        
//        mobileTemp = "0945264982"
//        TPCoreData.saveTouchObject(value:true)
//        TPCoreData.saveTouchObject(value:true)
//        TPCoreData.saveTouchObject(value:false)
//        let data = TPCoreData.fetchObject()
//        print(data?.count)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let bioTOken = getBioToken()
        print("bioTOken -------\(bioTOken)")
    }
    func getBioToken1(){
        
        if let deviceToken = TPCakeDefaults.shared.device_token, let password = tfPassword.text {
            Commons.showLoading(view)
            isCompleteGetBioToken = false
            requestType = .GetBioToken
            TPNetworkManager.shared.requestBiometricToken(mobile: mobileTemp, password: password, device_token: deviceToken, coordbust)
        }else{
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Chưa có device token")
        }
    }
}

extension TPBioTokenViewController {
    func checkValidInput()->(Bool, String){
        let stringPassword = tfPassword.text
        
        if Commons.stringIsNilOrEmpty(str: stringPassword){
            tfPassword.showError(sms: "🔴 Password không được để trống")
            return (false,"Không được để trống mã code.")
        }
//        if stringPassword!.count < 3 {
//            tfPassword.borderColor = .red
//            tfPassword.showError(sms: "🔴 Password không đúng")
//            return (false,"Họ tên phải lớn hơn 3 ký tự.")
//        }
        return (true,"ok")
    }
}

extension TPBioTokenViewController {
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
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Server không phản hồi", inView: self.view, didFinishDismiss: nil)
            return
        }
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        Commons.hideLoading(self.view)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            if let data = shitDic["Data"] as? [String:Any]{
                saveDataInfoUser(data: data)
            }
            if let bioToken = shitDic["Data"]  as? String {
                //TPCakeDefaults.shared.biometric_token = bioToken
                saveBioToken(stringBio: bioToken)
            }
            switch requestType {
            case .GetBioToken:
                if code != 0 {
                    Commons.showDialogAlert(title: "ĐĂNG XUẤT", content: sms, inView: self.view, didFinishDismiss: {
                        if code == -207 {
                            // sai mật khẩu quá 5 lần--> logout tài khoản
                            TPCakeDefaults.shared.access_token = nil
                            let vc = TPRegisterViewController()
                            self.changeRootViewController(vc)
                        }
                    })
                }else{
                    //delegate?.conpleteGetBioToken()
                    isCompleteGetBioToken = true
                    self.popBackViewController(true)
                }
                break
            case .ForgetPassword:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                        
                    })
                }else{
                    let vc = TPCreateNewPasswordVC()
                    vc.mobile = mobileTemp
                    self.pushToViewController(vc, true)
                }
                break
            default:
                break
            }
            
        }
    }
}


