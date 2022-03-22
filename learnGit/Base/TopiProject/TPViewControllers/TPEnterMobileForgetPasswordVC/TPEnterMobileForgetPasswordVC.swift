//
//  TPEnterMobileForgetPasswordVC.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPEnterMobileForgetPasswordVC: TPBaseViewController {

    @IBOutlet weak var tfMobile: TPBaseTextFieldWithLabel!
    
    init() {
        super.init(nibName: "TPEnterMobileForgetPasswordVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.disableIQKeyboard()
        tfMobile.addCustomTPToolBar(title: "Tiếp tục", action: {
            let check = self.checkValidInput()
            if !check.0 {
               // self.showDialogJK(check.1)
            }else{
                Commons.showLoading(self.view)
                let mobile = self.tfMobile.text!
                TPNetworkManager.shared.requestForgetPasswordSendOTP(mobile, self.coordbust)
            }
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        AppDelegate.enableIQKeyboard()
    }


}

extension TPEnterMobileForgetPasswordVC {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
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
        //let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            
            if code != 0 {
                Commons.showDialogAlert(title: "ĐỔI MẬT KHẨU", content: sms, inView: self.view, didFinishDismiss: nil)
                
            }else{
                let vc = TPCreateNewPasswordVC()
                vc.mobile = self.tfMobile.text!
                self.pushToViewController(vc, true)
            }
        }
    }
    func checkValidInput()->(Bool, String){
        let stringCode = tfMobile.text
        if Commons.stringIsNilOrEmpty(str: stringCode){
            tfMobile.showError(sms: "🔴 Số điện thoại không được để trống")
            return (false,"Không được để trống mã code.")
        }
        if stateLogin == .Logined && !stringCode!.elementsEqual(mobileTemp){
            tfMobile.showError(sms: "🔴 Số điện thoại không đúng")
            return (false,"Không được để trống mã code.")
        }
        return (true,"ok")
    }
}
