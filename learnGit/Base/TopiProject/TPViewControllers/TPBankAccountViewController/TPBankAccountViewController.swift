//
//  TPBankAccountViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class TPBankAccountViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    @IBOutlet weak var comfirmView: TPConfirmView!
    //@IBOutlet weak var viewEmpty: UIView!
    @IBOutlet var viewEmpty2: UIView!
    
    let viewEmpty = TPEmptyView()
    
    var nameArray:[TPPaymentObject] = []
    //var iconArray:[String] = ["ic_lock", "ic_finger", "ic_logout"]
    
    init() {
        super.init(nibName: "TPBankAccountViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnShowInfoPersionPressed(_ sender: UIButton) {
        let vc = TPInfoPersionViewController()
        pushToViewController(vc, true)
    }
    fileprivate func settingTableview() {
        //tbvView.tbv.estimatedRowHeight=120
        //tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        tbvView.registerCellWithNib(nib: UINib(nibName: "TPBankTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 120
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 16
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 3
        tbvView.didSelectedRowClosure = {[weak self] tbv, indexPath in
            guard let weakSelf = self else {
                return
            }
            print("-----123 did select cell")
        }
        tbvView.CreateCellClorsure = {[weak self] tbv, indexPath in
            guard let weakSelf = self else {
                return UITableViewCell()
            }
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TPBankTableViewCell
            cell.index = indexPath
            if let nameBk = weakSelf.nameArray[indexPath.section].PaymentChannelName,
               let nameLast = nameBk.components(separatedBy: "(").last, let nameLast2 = nameLast.components(separatedBy: ")").first {
                cell.nameBank.text = nameLast2
            }else{
                cell.nameBank.text = "Ngân hàng:---------"
            }
            //cell.nameBank.text = weakSelf.nameArray[indexPath.section].PaymentChannelName ?? "Ngân hàng :---------"
            if let paymentNumber = weakSelf.nameArray[indexPath.section].PaymentNumber {
                cell.numberBank.text = "**** **** **** " + paymentNumber.getSuffix(4)
            }else{
                cell.numberBank.text = "Số tài khoản:--------- "
            }
            //cell.numberBank.text = "Số tài khoản: " + String(weakSelf.nameArray[indexPath.section].PaymentNumber ?? "---------")
            
            if let logoBank = weakSelf.nameArray[indexPath.section].PaymentChannelImage {
                cell.logoBank.imageFromURL(urlString: logoBank)
            }
            
            cell.actionWhenClick = {
                print("------")
                let vc = TPDetailBankViewController()
                vc.objectReciver = cell.index as AnyObject
                vc.subTileArray = weakSelf.nameArray[indexPath.section] 
                vc.delegate = self
                weakSelf.pushToViewController(vc, true)
            }
            return cell
        }
        tbvView.delegateDatasource {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewEmpty.isHidden = true
        settingTableview()
        comfirmView.btnNext.indexPath = IndexPath(row: 1, section: 1)
        comfirmView.btnNext.actionClosure = { indexPath in
            let vc = TPAddBankAcountVC()
            vc.delegate = self
            self.pushToViewController(vc, true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !view.subviews.contains(viewEmpty){
            //viewEmpty.frame = CGRect(x: 0, y: 196, width: window.bounds.width, height: 126)
            viewEmpty.setTile(titleContent: "Chưa có tài khoản liên kết nào")
            view.addSubview(viewEmpty)
            viewEmpty.setConstraintByCode(constraintArray: [
                viewEmpty.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
                viewEmpty.widthAnchor.constraint(equalToConstant: window.bounds.width)
            ])
        }
        self.viewEmpty.isHidden = self.nameArray.isEmpty ? false : true
        guard let access_token = TPCakeDefaults.shared.access_token else {
            return
        }
        TPNetworkManager.shared.requestGetListProfilePayment(access_token, payment_channel_id: 0, coordbust)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        viewEmpty2.frame = CGRect(x: 0, y: 196, width: sizeScreen.width, height: 126)
//        if !view.subviews.contains(viewEmpty2){
//            view.addSubview(viewEmpty2)
//        }
//        self.viewEmpty2.isHidden = self.nameArray.isEmpty ? false : true
    }
}

extension TPBankAccountViewController: TPAddBankAcountVCDelegate {
    func infoAddBank(obj: AnyObject?) {
//        nameArray.append("add bank")
//        tbvView.numberOfSections = nameArray.count
//        tbvView.tbv.addSectionsCustom(editActionsForRowAt: IndexPath(row: 0, section: self.nameArray.count-1))
    }
}

extension TPBankAccountViewController: TPDetailBankDelegate {
    func removeBank(at index: IndexPath) {
//        nameArray.remove(at: index.section)
//        tbvView.numberOfSections = nameArray.count
//        tbvView.tbv.deleteSectionsCustom(editActionsForRowAt: IndexPath(row: 0, section: index.section)) {
//            guard self.nameArray.count >= 1 else {
//                return
//            }
//            for i in 0...self.nameArray.count-1 {
//                let indexPath = IndexPath(row: 0, section: i)
//                let cell = self.tbvView.tbv.cellForRow(at:indexPath) as! TPBankTableViewCell
//                cell.index = indexPath
//            }
//        }
        
    }
}


extension TPBankAccountViewController {
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
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                
                if let cus = TPPaymentObjectAray(JSON: shitDic), let data = cus.data{
                    nameArray = data
                    tbvView.numberOfSections = nameArray.count
                    DispatchQueue.main.async {
                        self.viewEmpty.isHidden = self.nameArray.isEmpty ? false : true
                        self.tbvView.tbv.reloadData()
                    }
                }

            }
        }
    }
}
            

