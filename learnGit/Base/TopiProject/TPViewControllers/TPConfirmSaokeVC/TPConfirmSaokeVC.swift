//
//  TPConfirmSaokeVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPConfirmSaokeVC: TPBaseViewController {
    
    @IBOutlet weak var tfEmail: TPBaseTextField!
    
    init() {
        super.init(nibName: "TPConfirmSaokeVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnCancelSaoke(_ sender: UIButton) {
        //popBackViewController(true)
        
        //tfEmail.addCustomTPToolBar(title: "Huỷ nhận sao kê", action: {
        
        if Commons.stringIsNilOrEmpty(str: tfEmail.text) {
            Commons.showDialogJK("Bạn chưa có email")
            return
        }
        if !tfEmail.text!.checkEmail(){
            Commons.showDialogJK("Email ko đúng định dạng")
            return
        }
        
        guard let access_token = TPCakeDefaults.shared.access_token else {
            return
        }
        Commons.showLoading(view)
        TPNetworkManager.shared.requestRegisterStatement(access_token, coordbustBase)
        
    }
    
    override func coordbustBase(_ data: Data?, _ respawn: URLResponse?, _ errur: Error?) {
        super.coordbustTPBase(data, respawn, errur)
        if code! != 0 {
            Commons.showDialogAlert(title: "THÔNG BÁO", content: self.sms!, inView: self.view, didFinishDismiss: nil)
        }else{
            Commons.showDialogAlert(title: "THÔNG BÁO", content: self.sms!, inView: self.view, didFinishDismiss: {
                status_is_register_statement_temp = false
                self.popBackViewController(true)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let obj = objectReciver as? [String:String] {
            let email = obj["emailSaoke"]
            tfEmail.text = email
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }


}


