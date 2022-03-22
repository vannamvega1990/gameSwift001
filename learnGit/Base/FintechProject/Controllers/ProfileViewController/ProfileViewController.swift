//
//  ProfileViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import GoogleSignIn

class ProfileViewController: FTBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    
    var nameArray:[String] = ["Thông tin cá nhân","Tài khoản ngân hàng","Mời bạn bè", "Hướng dẫn sử dụng", "Hợp đồng điện tử", "Cài đặt và bảo mật", "Cài đặt liên kết social", "Hotline: 1900 89 89 56"]
    
    init() {
        super.init(nibName: "ProfileViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        if let access_token = CakeDefaults.shared.access_token {
           NetworkManager.shared.requestLogout(access_token, coordbust)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupKeyboardDismissRecognizer()
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.backgroundColor = UIColor.white
        tbvView.registerCellWithNib(nib: UINib(nibName: "profileTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 80
        tbvView.heightForHeaderInSection = 16
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileTableViewCell
            cell.setTitle(name: self.nameArray[indexPath.section])
            cell.heightlightBoder = true
            cell.hideHightlightWhenClick = true
            cell.baseView.indexPath = indexPath
            cell.baseView.actionClosure = { [weak self] index in
                print(index.section)
                switch index.section {
                case 0:
                    let infoPersionVC = infoPersionViewController()
                    self?.pushToViewController(infoPersionVC, true)
                    break
                case 1:
                    let listAcountBankVC = ListAccountBankViewController()
                    self?.pushToViewController(listAcountBankVC, true)
                    break
                case 5:
                    let changePasswordVC =  StreechChangePasswordVC()
                    //ChangePasswordViewController()
                    self?.pushToViewController(changePasswordVC, true)
                    break
                case 6:
                    let linkSocialViewController =  LinkDislinkViewController()
                    //ChangePasswordViewController()
                    self?.pushToViewController(linkSocialViewController, true)
                    break
                default:
                    break
                }
            }
            return cell
        }
    }
}

extension ProfileViewController {
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
                Commons.showDialogAlert(title: "ĐĂNG XUẤT", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                Commons.showDialogAlert(title: "ĐĂNG XUẤT", content: sms, inView: self.view, didFinishDismiss: {
                    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.changeRootView(newRootView: StartViewController())
                    //changeRootVC = true
                    CakeDefaults.shared.access_token = nil
                    GIDSignIn.sharedInstance().signOut()
                })               
            }
        }
    }
}
