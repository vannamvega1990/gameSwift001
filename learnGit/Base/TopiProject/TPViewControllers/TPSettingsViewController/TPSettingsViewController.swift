//
//  TPSettingsViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPSettingsViewController: TPBaseViewController, BioTokenDelegate{

    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    
    var nameArray:[String] = ["Đổi mật khẩu","Xác thực sinh trắc học","Đăng xuất",]
    var iconArray:[String] = ["ic_lock", "ic_finger", "ic_logout"]
    
    init() {
        super.init(nibName: "TPSettingsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func conpleteGetBioToken(state: Bool) {
        //let name = TPCakeDefaults.shared.isTouchID! ? "switch" : "switchOff"
        //.baseView.setNail = UIImage(named: name)!
        if state {
            TPCakeDefaults.shared.isTouchID = true
            let bioTOken = getBioToken()
            print(bioTOken)
            tbvView.tbv.reloadSections([1], with: .none)
        }
        
    }
    
    @IBAction func btnShowInfoPersionPressed(_ sender: UIButton) {
        let vc = TPInfoPersionViewController()
        pushToViewController(vc, true)
    }
    
    func setup(){
        //setupKeyboardDismissRecognizer()
        //tbvView.tbv.estimatedRowHeight=48
        //tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        tbvView.tbv.disableScroll()
        tbvView.registerCellWithNib(nib: UINib(nibName: "profileTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 48
        //tbvView.heightForHeaderInSection = 1
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 1
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 1
        tbvView.CreateCellClorsure = {[weak self] tbv, indexPath in
            guard let weakSelf = self else {
                return UITableViewCell()
            }
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileTableViewCell
            cell.setTitle(name: weakSelf.nameArray[indexPath.section])
            cell.baseView.title.textAlignment = .left
            cell.baseView.title.textColor = .white
            cell.baseView.leftContraintLogo.constant = 20
            cell.baseView.leftContraintTitle.constant = 20
            cell.baseView.rootView.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
            cell.baseView.layoutIfNeeded()
            cell.heightlightBoder = true
            cell.hideHightlightWhenClick = true
            cell.baseView.indexPath = indexPath
            let imgName = weakSelf.iconArray[indexPath.section]
            cell.baseView.setIcon = UIImage(named: imgName)!
            if indexPath.section == 1 {
                let name = TPCakeDefaults.shared.isTouchID! ? "switch" : "switchOff"
                cell.baseView.setNail = UIImage(named: name)!
                //cell.baseView.setNail = UIImage(named: "switchOff")!
            }
            cell.baseView.actionClosure = { [weak self] index in
                guard let weakSelf1 = self else {
                    return
                }
                print(index.section)
                switch index.section {
                case 0:
                    let vc = TPChangePasswordViewController()
                    weakSelf1.pushToViewController(vc, true)
                    break
                case 1:
                    
                    //if let isTouchID = TPCakeDefaults.shared.isTouchID, !isTouchID, weakSelf1.getBioToken() == nil{
                    //TPCakeDefaults.shared.isTouchID = !TPCakeDefaults.shared.isTouchID!
                    //let name = TPCakeDefaults.shared.isTouchID! ? "switch" : "switchOff"
                    //cell.baseView.setNail = UIImage(named: name)!
                    
                    guard let isTouchID = TPCakeDefaults.shared.isTouchID else {
                        return
                    }
                    if isTouchID {
                        //weakSelf1.saveTouchId(val: false) // = false
                        TPCakeDefaults.shared.isTouchID = false
                        weakSelf1.removeBioToken()
                        let name = TPCakeDefaults.shared.isTouchID! ? "switch" : "switchOff"
                        cell.baseView.setNail = UIImage(named: name)!
                    }else {
                        let vc = TPBioTokenViewController()
                        vc.delegate = weakSelf1
                        weakSelf1.pushToViewController(vc, true)
                    }
                    
//                    if let isTouchID = TPCakeDefaults.shared.isTouchID, !isTouchID{
//                        let vc = TPBioTokenViewController()
//                        vc.delegate = weakSelf1
//                        weakSelf1.pushToViewController(vc, true)
//                    }
                    //weakSelf1.getBioToken()
                    
                    break
                case 2:
                    guard let access_token = TPCakeDefaults.shared.access_token else {
                        return
                    }
                    Commons.showLoading(weakSelf1.view)
                    TPNetworkManager.shared.requestLogout(access_token, weakSelf1.coordbust)
                    break
                case 5:
                    
                    break
                case 6:
                    
                    break
                default:
                    break
                }
            }
            return cell
        }
        tbvView.delegateDatasource {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TPCakeDefaults.shared.isTouchID = TPCakeDefaults.shared.isTouchID ?? false
        //self.saveTouchId(val: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TPCakeDefaults.shared.isTouchID = false
        setup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
        self.tbvView.layoutIfNeeded()
    }
    
}


extension TPSettingsViewController {
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
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            if code != 0 {
                Commons.showDialogAlert(title: "ĐĂNG XUẤT", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                appDelegate.reset()
                stateLogin = .Notyet
                let vc = TPRegisterViewController()
                self.changeRootViewController(vc)
            }
        }
    }
}

