//
//  LinkDislinkViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class LinkDislinkViewController: FTBaseViewController {

    enum TypeRequest {
        case getListLinkedSocial
        case newLink
    }
    var socialType: SocialType = .Google
    var typeRequest: TypeRequest = .getListLinkedSocial
    
    var addNewLinkSocialComplted: Bool = false {
        didSet{
            if addNewLinkSocialComplted {
                //DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.getListLinkedSocial(self.cucos)
                //}
            }
        }
    }
    
    
    @IBOutlet weak var viewContainer: UIView!
    
    init() {
        super.init(nibName: "LinkDislinkViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var dicTemp: [String:Any]?
    var countGoogle: Int = 0
    @objc func handleNotification(_ notification: NSNotification) {
        if let infoGoogleUser = notification.userInfo?["dataUser"] as? SocialObject , let access_token = CakeDefaults.shared.access_token{
            print(infoGoogleUser.email)
            if let id = infoGoogleUser.idUser {
                let email = infoGoogleUser.email ?? nil
                let name = infoGoogleUser.fullName ?? nil
                let type = "\(self.socialType.rawValue)"
                
                dicTemp = ["SocialId":id,
                                         "SocialType":self.socialType.rawValue,
                                         "SocialTypeSub":"Google",
                                         "SocialEmailOrMobile":email,
                                         "SocialName":name]
                countGoogle += 1   
                if countGoogle == 1 {
                    Commons.showLoading(view)
                    typeRequest = .newLink
                    NetworkManager.shared.requestLinkSocial(access_token, id, type, email, name, cucos)
                }
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BaseCommons.regisReceverNotificationcenter(self, NotificationCenterName.KEY_GOOGLE_LOGINED, nil, selector: #selector(handleNotification(_:)))
        Commons.showLoading(view)
        getListLinkedSocial(self.cucos)
        
        let img = UIImageView()
        
    }
    
    func getListLinkedSocial(_ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        if let access_token = CakeDefaults.shared.access_token {
            //Commons.showLoading(view)
            typeRequest = .getListLinkedSocial
            NetworkManager.shared.requestGetListLinkedSocial(access_token, self.cucos)
        }
    }
    
    @IBAction func addNewLinkSocial(_ sender: UIButton) {
        let heightOfPop: CGFloat = 216
        let popV = ViewOptionLinkSocial(frame: CGRect(x: 0, y: 0, width: sizeScreen.width, height: heightOfPop))
        showPopup(popupPosition: .botton, popView: popV)
        
        popV.actionLoginWithGoole = {
            self.signOutGoogle()
            self.countGoogle == 0
            self.socialType = .Google
            self.createSignInGoogle()
        }
        popV.actionLoginWithFacebook = {
            self.signOutFacebook()
            self.createLoginWithFacebook { (user:SocialObject?) in
                if let user = user, let id = user.idUser {
                    self.socialType = .Facebook
                    let email = user.email ?? nil
                    let name = user.fullName ?? nil
                    let type = "\(self.socialType.rawValue)"
                    
                    self.dicTemp = ["SocialId":id,
                    "SocialType":self.socialType.rawValue,
                    "SocialTypeSub":"Facebook",
                    "SocialEmailOrMobile":email,
                    "SocialName":name]
                    if let access_token = CakeDefaults.shared.access_token {
                        Commons.showLoading(self.view)
                        self.typeRequest = .newLink
                        NetworkManager.shared.requestLinkSocial(access_token, id, type, email, name, self.cucos)
                    }
                }
            }
        }
        popV.actionLoginWithApple = {
            self.closureAppleLogin = { (user: SocialObject) in
                if let id = user.idUser {
                    self.socialType = .Apple
                    let email = user.email ?? nil
                    let name = user.fullName ?? nil
                    let type = "\(self.socialType.rawValue)"
                    
                    self.dicTemp = ["SocialId":id,
                                    "SocialType":self.socialType.rawValue,
                                    "SocialTypeSub":"Facebook",
                                    "SocialEmailOrMobile":email,
                                    "SocialName":name]
                    if let access_token = CakeDefaults.shared.access_token {
                        Commons.showLoading(self.view)
                        self.typeRequest = .newLink
                        NetworkManager.shared.requestLinkSocial(access_token, id, type, email, name, self.cucos)
                    }
                }
            }
            self.createLoginWithApple()
        }
       
    }
    
    let tableVC = LinkSocialTableViewController()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableVC.enableEditCell = true
        
        addSubViewController(tableVC, supperView: viewContainer, frameOfSubVC:viewContainer.bounds)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

extension LinkDislinkViewController {
    func cucos(_ data:Data?,_ response:URLResponse?,_ error: Error?)->Void{
        if let error=error{
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
//        DispatchQueue.main.async {
//           Commons.hideLoading(self.view)
//        }
        
        if typeRequest == .getListLinkedSocial {
            if let shitDic = shit as? [String:Any]{
                Commons.hideLoading(self.view)
                if let cus = SocialArray(JSON: shitDic){
                    if let tiktok = cus.data {
                        DispatchQueue.main.async {
                            self.tableVC.dataArray = tiktok
                            self.tableVC.numberOfSections = self.tableVC.dataArray.count
                            self.tableVC.tableView.reloadData()
                        }
                        
                    }
                }
            }
            
        }else{
            if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
                Commons.hideLoading(self.view)
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }
                
                else {
                    //let dic = ["SocialId":"","SocialType":"","SocialTypeSub":"","SocialEmailOrMobile":"","SocialName":""]
                    if let cus = SocialInfo(JSON: dicTemp!){
                        //tableVC.dataArray.append(contentsOf: [cus])
                        //self.tableVC.numberOfSections = self.tableVC.dataArray.count
                        //tableVC.tableView.reloadData()
                        addNewLinkSocialComplted = true
                    }
                    
                }
            }
        }
        
    }
}
