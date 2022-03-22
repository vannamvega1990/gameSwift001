//
//  ProfileViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import ObjectMapper

class infoPersionViewController: FTBaseViewController {
    
    var nameArray:[String] = ["Tên *","Ngày sinh","Giới tính", "Email *", "Số điện thoại *", "Địa chỉ"]
    var valueArray:[String] = ["Warren Buffet","05 November 1993","Male", "warren.buff@invest.ai", "-", "-"]
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    
    init() {
        super.init(nibName: "infoPersionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissRecognizer()
        tbvView.numberRow = nameArray.count + 1
        tbvView.registerCell()
        tbvView.registerCellWithNib(nib: UINib(nibName: "CCCDTableViewCell", bundle: nil), idCell: "cellCCCD")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightForFooter = 80
        tbvView.CreateCellClorsure = {tbv, indexPath in
            if indexPath.row < self.nameArray.count {
                self.tbvView.heightOfCell = 80
                let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! infoPersionTableViewCell
                cell.setTitle(name: self.nameArray[indexPath.row])
                cell.setTextField(name: self.valueArray[indexPath.row])
                return cell
            }
            else {
                self.tbvView.heightOfCell = 180
                let cell = tbv.dequeueReusableCell(withIdentifier: "cellCCCD", for: indexPath) as! CCCDTableViewCell
                return cell
            }
        }
        if let access_token = CakeDefaults.shared.access_token {
            NetworkManager.shared.requestGetInfoUser(access_token, coordbust)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension infoPersionViewController {
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
        
        
        
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String,
            let dataDic = shitDic["Data"] as? [String: Any]{
            Commons.hideLoading(self.view)
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                if let cus = DataUserInfo(JSON: dataDic){
//                    print(cus?.email)
//                    print(cus?.access_token)
//                    print(cus?.mobile)
                    let fullName = cus.full_name ?? ""
                    let birth_day = cus.birth_day ?? ""
                    let gender = String(cus.gender ?? 0)
                    let email = cus.email ?? ""
                    let mobile = cus.mobile ?? ""
                    let address = cus.address ?? ""
                    valueArray = [fullName,birth_day,gender, email, mobile, address]
                    DispatchQueue.main.async {
                        self.tbvView.tbv.reloadData()
                    }
                }
                
            }
        }
    }
}
