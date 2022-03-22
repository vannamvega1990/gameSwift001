//
//  TPAddBankAcountVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

protocol TPAddBankAcountVCDelegate {
    func infoAddBank(obj:AnyObject?)
}

class TPAddBankAcountVC: TPBaseViewController {
    
    @IBOutlet weak var confirmView: TPConfirmView!
    @IBOutlet weak var tfNameBank: TPBaseTextField!
    @IBOutlet weak var tfNumberBank: TPBaseTextField!
    @IBOutlet weak var tfNameAccountBank: TPBaseTextField!
    @IBOutlet weak var btnShowBank: BaseButton!
    
    var paymentChannelArray:[TPPaymentChannelObject] = []
    var delegate: TPAddBankAcountVCDelegate?
    
    enum TypeRequest {
        case GetListPaymentChannel
        case AddBankAcount
        case none
    }
    var typeRequest: TypeRequest = .none
    var indexBankSelected: Int?

    init() {
        super.init(nibName: "TPAddBankAcountVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let device_token = TPCakeDefaults.shared.access_token else {
            return
        }
        Commons.showLoading(view)
        typeRequest = .GetListPaymentChannel
        TPNetworkManager.shared.requestGetListPaymentChannel(device_token, payment_type_id: 1, coordbust)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closureHidePopupTrump = {
            if self.indexBankSelected == nil {
                self.tfNameBank.text = ""
            }else{
                self.tfNameBank.text = self.filteredData[self.indexBankSelected!].Name
            }
        }
        confirmView.btnNext.indexPath = IndexPath(row: 1, section: 1)
        confirmView.btnNext.actionClosure = { [weak self ]indexPath in
            guard let selfWeak = self else {
                return
            }
            let check = selfWeak.checkValidInput()
            if !check.0 {
            }else{
                
                guard let access_token = TPCakeDefaults.shared.access_token else {
                    return
                }      
                selfWeak.typeRequest = .AddBankAcount
                if let bankSelected = selfWeak.indexBankSelected, let payment_channel_id = selfWeak.filteredData[bankSelected].PaymentChannelId{
                    Commons.showLoading(selfWeak.view)
                    TPNetworkManager.shared.requestCreateProfilePayment(access_token, payment_channel_id: payment_channel_id, payment_name: selfWeak.tfNameAccountBank.text!, payment_number: selfWeak.tfNumberBank.text!, selfWeak.coordbust)
                }
                
            }
            //self.goNext()
        }
    }
    
    override func cellShowListPopupPressed(indexpath: IndexPath) {
        
        
        let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
        hidePopupWithAnimTrump(typeAnimation: anim) {
            [weak self ] in
            guard let selfWeak = self else {
                return
            }
            print(indexpath)
            selfWeak.indexBankSelected = indexpath.section
            if let name = selfWeak.paymentChannelArray[selfWeak.indexBankSelected!].Name,let nameLast = name.components(separatedBy: "(").last, let nameLast2 = nameLast.components(separatedBy: ")").first {
                //selfWeak.tfNameBank.text = nameLast2
            }
            if let name = selfWeak.filteredData[selfWeak.indexBankSelected!].Name {
                selfWeak.tfNameBank.text = name
            }
            
        }
    }
    
    var tbv: FTBaseTableView!
    var filteredData:[TPPaymentChannelObject] = []
    var data :[TPPaymentChannelObject] = []
    
    @objc func editingChanged(){
//        filteredData = tfNameBank.text!.isEmpty ? data : data.filter({(dataString: TPPaymentChannelObject) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            //return dataString.range(of: tfNameBank.text!, options: .caseInsensitive) != nil
//            //$0.nameOfBook.rangeOfString("rt", options: .CaseInsensitiveSearch) != nil
//            //return dataString.Name!.range(of: tfNameBank.text!, options: .) != nil
//
//        })
        //filteredData = paymentChannelArray.filter{ ($0.Name!.contains(tfNameBank.text ?? "")) }
        
        //searchedCountry = dataJson.filter({$0.countryName.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.numbers.lowercased().prefix(searchText.count) == searchText.lowercased()})
        if Commons.stringIsNilOrEmpty(str: tfNameBank.text) {
            filteredData = paymentChannelArray
        }else{
            //filteredData = paymentChannelArray.filter({$0.Name!.lowercased().prefix(tfNameBank.text!.count) == tfNameBank.text!.lowercased() || ($0.Description ?? "").lowercased().prefix(tfNameBank.text!.count) == tfNameBank.text!.lowercased()})
            print(tfNameBank.text!)
            //filteredData = paymentChannelArray.filter{ ($0.Name!.lowercased().contains(tfNameBank.text!.lowercased())) }
            filteredData = paymentChannelArray.filter({$0.Name!.lowercased().prefix(tfNameBank.text!.count) == tfNameBank.text!.lowercased()})
                   
        }
        
        print(filteredData.count)
        tbv.numberOfSections = filteredData.count
        tbv.reload()
    }
    
    @IBAction func btnShowListPaymentChannelPressed(_ sender: UIButton) {
        let dataArrayName = paymentChannelArray.map { (obj:TPPaymentChannelObject) -> String in
            return obj.Name ?? "-----"
        }
        let dataArrayName2 = dataArrayName.map { (name) -> String in
            if let nameLast = name.components(separatedBy: "(").last, let nameLast2 = nameLast.components(separatedBy: ")").first {
                return nameLast2
            }
            return "-----"
        }
        let dataArrayName3 = dataArrayName.map { (name) -> String in
            if let nameFirst = name.components(separatedBy: "(").first {
                return nameFirst
            }
            return "-----"
        }
        
        //showListPopup(dataArrayName: dataArrayName)
        //self.showPopupTrumpList(dataArrayName:dataArrayName3,subArrayName:dataArrayName2)
        
        tfNameBank.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        filteredData = paymentChannelArray
        data = paymentChannelArray
        let nib = UINib(nibName: "ImageAndTitleTableViewCell", bundle: nil)
        let CreateCellClorsure1:((UITableView,IndexPath)->BaseTableViewCell)? = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImageAndTitleTableViewCell
            cell.title.text = self.filteredData[indexPath.section].Name
            cell.subTitle.text = self.filteredData[indexPath.section].Description ?? "Ngân hàng \(cell.title.text!)"
            //cell.logo.imageFromURL(urlString: self.filteredData[indexPath.section].Image ?? "", extraImage: UIImage(named: "ic_vietcombank"))
            cell.logo.imageFromURL(urlString: self.filteredData[indexPath.section].Image ?? "", extraImage: nil)
            cell.actionWhenClick = {
                self.cellShowListPopupPressed(indexpath: indexPath)
            }
            return cell
        }
        let point = CGPoint(x: 0, y: self.btnShowBank.bounds.height)
        let convertPoint = btnShowBank.convert(point, to: window)
        
        let viewWantPop = FTBaseTableView()
        viewWantPop.backgroundColor = .white
        viewWantPop.cornerRadius = 8
        viewWantPop.clipsToBounds = true
        viewWantPop.borderWidth = 0.3
        viewWantPop.borderColor = UIColor.lightGray
        viewWantPop.numberOfSections = filteredData.count
        viewWantPop.numberRow = 1
        viewWantPop.hideSpactorCellVarible = false
        viewWantPop.heightOfCell = 48
        viewWantPop.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 0
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        viewWantPop.viewForHeaderInSection = 1
        
        tbv = self.showPopupTrumpList(tbv: viewWantPop, bgColor: UIColor.clear, topConstraint: convertPoint.y + 3, left: convertPoint.x, right: convertPoint.x, height: 376, customNibCell:nib, CreateCellClorsure: CreateCellClorsure1)
        tfNameBank.becomeFirstResponder()
    }
    func goNext(){
        self.objectReciver = ["bank":"tpbank",
                              "numberBank" : "12345678",
                              "nameOwner": "tran van nam",] as AnyObject
        delegate?.infoAddBank(obj: self.objectReciver)
        self.popBackViewController(true)
    }
}

extension TPAddBankAcountVC {
    func checkValidInput()->(Bool, String){
        let check = checkEmptyTextFildHasErrorBellow(tfs: [tfNameBank,tfNumberBank, tfNameAccountBank], sms: ["🔴 Tên Ngân hàng không được để trống","🔴 Số tài khoản không được để trống", "🔴 Tên tài khoản không được để trống"])
        if !check {
            return (false,"Textfild đang để trống.")
        }
        if tfNumberBank.text!.count < 6 {
            tfNumberBank.borderColor = .red
            showErrorBelowUITextfild(tf: tfNumberBank, sms: "🔴 Số tài khoản không đúng.")
            return (false,"Họ tên phải lớn hơn 3 ký tự.")
        }
        
        return (true,"ok")
    }
}


extension TPAddBankAcountVC {
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
            switch typeRequest {
            case .GetListPaymentChannel:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    if let cus = TPPaymentChannelObjectArray(JSON: shitDic), let data = cus.data{
                        paymentChannelArray = data
                    }
                }
                break
            case .AddBankAcount:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    
                    self.popBackViewController(true)

                }
                break
            default:
                break
            }
            
            
            
        }
    }
}


