//
//  LinkSocialViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class LinkSocialViewController: UIViewController {
    
    @IBOutlet weak var tbvView: BaseTableView!
    var nameArray:[String] = ["Thông tin cá nhân","Tài khoản ngân hàng","Mời bạn bè", "Hướng dẫn sử dụng", "Hợp đồng điện tử", "Cài đặt và bảo mật", "Cài đặt liên kết social", "Hotline: 1900 89 89 56"]

    init() {
        super.init(nibName: "LinkSocialViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSwipe(){
        let cell =  tbvView.tbv.cellForRow(at: IndexPath.init())
        cell?.contentView.frame.origin.x = 56
    }
    var closureCellSwipe:((UITableViewCell) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let access_token = CakeDefaults.shared.access_token {
            Commons.showLoading(view)
            NetworkManager.shared.requestGetListLinkedSocial(access_token, self.cucos)
        }
        
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.backgroundColor = UIColor.white
        tbvView.registerCellWithNib(nib: UINib(nibName: "SocialTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 80
        tbvView.heightForHeaderInSection = 16
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocialTableViewCell
            cell.tag = indexPath.section
//            cell.actionEdit = {
//                self.nameArray.remove(at: indexPath.section)
//                self.tbvView.tbv.deleteRows(at: [indexPath], with: .automatic)
//            }
            

//            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
//            swipeGesture.direction = [.left,.right]
//            cell.addGestureRecognizer(swipeGesture)
            
            
//            cell.setTitle(name: self.nameArray[indexPath.section])
//            cell.heightlightBoder = true
//            cell.hideHightlightWhenClick = true
//            cell.baseView.indexPath = indexPath
//            cell.baseView.actionClosure = { [weak self] index in
//                print(index.section)
//                
//            }
            return cell
        }
        
    }
}

extension LinkSocialViewController {
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
        //self.showSimpleAlert(title: "noi dung 123", ms: "\(shit)")
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if let data = shitDic["Data"] as? Array<String>{
                //nameArray = data
                //self.tbvView.tbv.reloadData()
            }
          
        }
    }
}
