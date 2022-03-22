//
//  TPDetailBankViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

protocol TPDetailBankDelegate {
    func removeBank(at index: IndexPath)
}

class TPDetailBankViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: TPBaseHeaderView!
    var delegate: TPDetailBankDelegate?
    
    var nameArray:[String] = ["Tên ngân hàng","Số tài khoản","Tên tài khoản",]
    var subTileArray:TPPaymentObject?
    
    init() {
        super.init(nibName: "TPDetailBankViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnRemoveBankPressed(_ sender: UIButton) {
//        delegate?.removeBank(at: self.objectReciver as! IndexPath)
//        self.popBackViewController(true)
        
        guard let device_token = TPCakeDefaults.shared.access_token, let contents = subTileArray, let profilePaymentId = contents.ProfilePaymentId else {
            return
        }
        Commons.showLoading(self.view)
        TPNetworkManager.shared.requestDeleteProfilePayment(device_token, profile_payment_id: profilePaymentId, coordbust)
       
    }
   
    fileprivate func settingTableView() {
        //setupKeyboardDismissRecognizer()
        //tbvView.tbv.estimatedRowHeight=64
        //tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        //tbvView.tbv.disableScroll()
        tbvView.registerCellWithNib(nib: UINib(nibName: "TitleAndSubTitleTableViewCell", bundle: nil), idCell: "cell")
        //tbvView.tbv.register(TPDetailBankTableViewCell.self, forCellReuseIdentifier: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 64
        //tbvView.heightForHeaderInSection = 1
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 1
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 1
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleAndSubTitleTableViewCell
            cell.enableHeighlight = true
            cell.colorWhenHeightlight = .red
            cell.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
            cell.title.textColor = UIColor(rgb: 0x919191, alpha: 1)
            cell.subTitle.textColor = UIColor(rgb: 0xEAEAEC, alpha: 1)
            cell.title.text = self.nameArray[indexPath.section]
            if let subTileArray = self.subTileArray {
                //let nameBank = (subTileArray.PaymentChannelName ?? "-----")
                var nameBank = "-----"
                if let nameBk = subTileArray.PaymentChannelName,
                   let nameLast = nameBk.components(separatedBy: "(").last, let nameLast2 = nameLast.components(separatedBy: ")").first {
                    nameBank = nameLast2
                }
                self.headerView.nameTitle = nameBank
                let numBank = String(subTileArray.PaymentNumber ?? "-----")
                let nameAccountBank = (subTileArray.PaymentName ?? "-----")
                let arr = [nameBank,numBank,nameAccountBank]
                cell.subTitle.text = arr[indexPath.section]
            }
            
            return cell
        }
        
        tbvView.delegateDatasource {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView()
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


extension TPDetailBankViewController {
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
        Commons.hideLoading(self.view)
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
                
                self.popBackViewController(true)

            }
        }
    }
}

