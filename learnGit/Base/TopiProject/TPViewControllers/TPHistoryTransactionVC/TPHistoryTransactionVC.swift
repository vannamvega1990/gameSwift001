//
//  TPHistoryTransactionVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class TPHistoryTransactionVC: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var viewSaoke: UIView!
    @IBOutlet weak var buttonSaoke: UIButton!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewSelect: UIStackView!
    
    let fakeTextfild = UITextField()
    var dateFrom:String?
    var dateTo:String?
    var product_type_id:Int?
   
    var nameArray:[String] = ["Tài khoản liên kết",
                              "Hợp đồng điện tử",
                              "Lịch sử giao dịch",
                              "Cài đặt & Bảo mật",
                              "Thông tin hỗ trợ"]
    
    var dataArrayHistory: [TPTransactionProductObject] = [TPTransactionProductObject]()
    var dataArrayKind: [TPProductTypeObject] = [TPProductTypeObject]()
    var indexPathKind: Int?
    
    enum TypeRequest {
        case GetProductType
        case GetHistoryTransaction
        case none
    }
    var typeRequest: TypeRequest = .none
    
    init() {
        super.init(nibName: "TPHistoryTransactionVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cellShowListPopupPressed(indexpath: IndexPath) {
        let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
        hidePopupWithAnimTrump(typeAnimation: anim) {
            [weak self ] in
            guard let selfWeak = self else {
                return
            }
            print(indexpath)
            selfWeak.indexPathKind = indexpath.section
            let tfKind = selfWeak.stackViewSelect.subviews.first! as! UITextField
            tfKind.text = selfWeak.dataArrayKind[selfWeak.indexPathKind!].Name
            selfWeak.product_type_id = selfWeak.dataArrayKind[selfWeak.indexPathKind!].ProductTypeId
            Commons.showLoading(selfWeak.view)
            selfWeak.typeRequest = .GetHistoryTransaction
            TPNetworkManager.shared.requestHistoryTransaction(page: 1, count: 12, from_date: selfWeak.dateFrom, to_date: selfWeak.dateTo, search: nil, product_type_id: selfWeak.product_type_id, selfWeak.coordbust)
        }
    }
    
    func showPopupSelec(){
        let arr = dataArrayKind.map { (obj: TPProductTypeObject) -> String in
            showToast(sms: "Chua co du lieu")
            return obj.Name ?? ""
        }
        //showListPopup(dataArrayName: arr)
        self.showPopupTrumpList(dataArrayName:arr)
    }
    
    @IBAction func btnKidProductPressd(_ sender: UIButton) {
        if dataArrayKind.count > 0 {
            showPopupSelec()
            return
        }
        typeRequest = .GetProductType
        TPNetworkManager.shared.requestGetListProductType(coordbust)
        
    }
    
    func requestFirst(){
        Commons.showLoading(view)
        typeRequest = .GetProductType
        TPNetworkManager.shared.requestGetListProductType(coordbust)
    }
    
    var flagGetKindSussess: Bool = false {
        didSet{
            if flagGetKindSussess {
                indexPathKind = 0
                let tfKind = stackViewSelect.subviews.first! as! UITextField
                tfKind.text = dataArrayKind[indexPathKind!].Name
                let formatter = DateFormatter()
                formatter.dateFormat = "MM,yyyy"
                (stackViewSelect.subviews.last as! TPBaseTextField).text = "Tháng " + formatter.string(from: dateGlobal)
                flagGetHistoryTransactionFirst = true
            }
        }
    }
    
    var flagGetHistoryTransactionFirst: Bool = false {
        didSet{
            if flagGetHistoryTransactionFirst {
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "yyyy-MM"
                dateFrom = formatter1.string(from: dateGlobal) + "-01"
                dateTo = getEndDateOfAnyMoth(dateFrom: dateFrom)
                product_type_id = dataArrayKind[indexPathKind!].ProductTypeId
                Commons.showLoading(view)
                typeRequest = .GetHistoryTransaction
                TPNetworkManager.shared.requestHistoryTransaction(page: 1, count: 12, from_date: dateFrom!, to_date: dateTo!, search: nil, product_type_id: product_type_id!, coordbust)
            }
        }
    }
    
    @IBAction func btnDate(_ sender: UIButton) {
        fakeTextfild.becomeFirstResponder()
    }
    
    @IBAction func btnSaoke(_ sender: UIButton) {
//        let jk = TPCakeDefaults.shared.status_is_register_statement
//        if let jk1 = jk {
//            if jk1 {
//                let vc = TPConfirmSaokeVC()
//                vc.objectReciver = ["emailSaoke" : (TPCakeDefaults.shared.email ?? "noEmail")] as AnyObject
//                pushToViewController(vc, true)
//            }else{
//                let vc = TPRegisterStatementVC()
//                pushToViewController(vc, true)
//            }
//        }else{
//            let vc = TPRegisterStatementVC()
//            pushToViewController(vc, true)
//        }
        
        //let jk = TPCakeDefaults.shared.status_is_register_statement
        if status_is_register_statement_temp {
                let vc = TPConfirmSaokeVC()
                vc.objectReciver = ["emailSaoke" : (TPCakeDefaults.shared.email ?? "noEmail")] as AnyObject
                pushToViewController(vc, true)
        }else{
            let vc = TPRegisterStatementVC()
            pushToViewController(vc, true)
        }
            
        
    }
    fileprivate func settingTableview() {
        tbvView.tbv.estimatedRowHeight=56
        tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = dataArrayHistory.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        tbvView.registerCellWithNib(nib: UINib(nibName: "TPHistoryTransactionTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 56
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 1
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 1
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TPHistoryTransactionTableViewCell
            if let amountMoney = self.dataArrayHistory[indexPath.section].TotalValue {
                let amoutString = BaseCommons.instance.formatMoneyDouble(money: amountMoney)
                cell.amount.text = amoutString + " đ"
            }
            if let name = self.dataArrayHistory[indexPath.section].TransactionName {
                cell.name.text = name
            }
            if let time = self.dataArrayHistory[indexPath.section].CreateAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
                if let date = dateFormatter.date(from:time) {
                    dateFormatter.dateFormat = "dd-MM-yyyy・HH:mm:ss"
                    let timeFix = dateFormatter.string(from: date)
                    cell.time.text = timeFix
                }
            }
            cell.state.text = self.dataArrayHistory[indexPath.section].StatusStr
            return cell
        }
        tbvView.delegateDatasource {
            
        }
    }
    
    func stringToDate() -> Date{
        //let isoDate = "2016-04-14T10:44:00+0000"
        let isoDate = "2016-04-18"
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)!
        return date
    }

    override func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM,yyyy"
        print(formatter.string(from: self.datePicker!.date))
        (stackViewSelect.subviews.last as! TPBaseTextField).text = "Tháng " + formatter.string(from: self.datePicker!.date)
        //self.datePicker = nil
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM"
        dateFrom = formatter1.string(from: self.datePicker!.date) + "-01"
        
        dateTo = getEndDateOfAnyMoth(dateFrom: dateFrom)
        //dateTo = formatter1.string(from: self.datePicker!.date) + "-31"
        self.view.endEditing(true)
        //if let dateFrom = dateFrom, let dateTo = dateTo {
            Commons.showLoading(view)
            typeRequest = .GetHistoryTransaction
            //"page=1&count=12&from_date=2021-06-01&to_date=2021-06-31"
            //let dateToTest = "2021-06-18"
            TPNetworkManager.shared.requestHistoryTransaction(page: 1, count: 12, from_date: dateFrom, to_date: dateTo, search: nil, product_type_id: product_type_id, coordbust)
       // }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableview()
        fakeTextfild.frame = CGRect(x: 0, y: 0, width: sizeScreen.width, height: 96)
        fakeTextfild.isHidden=true
        addSubViews([fakeTextfild])
        showDatePickerForUITextfild(tfDatePicker: fakeTextfild)
        
        requestFirst()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let jk = TPCakeDefaults.shared.status_is_register_statement
        //if let jk = jk{
        //if status_is_register_statement_temp{
            if let stack = viewSaoke.subviews.first as? UIStackView {
                let title = stack.subviews.last as! UILabel
                title.text = status_is_register_statement_temp ? "Đã đăng ký" : "Chưa đăng ký"
            }
        //}
        //buttonSaoke.isEnabled = !(jk ?? false)
    }
    
//    func getEndDateOfAnyMoth(){
//        if let dateFrom1 = dateFrom, let dateFromString = stringToDate(txt: dateFrom1) {
//            let formatter2 = DateFormatter()
//            formatter2.dateFormat = "yyyy-MM-dd"
//            dateTo = formatter2.string(from: dateFromString.endOfMonth)
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM,yyyy"
//        let date = Date()
//        print(formatter.string(from: date))
//        (stackViewSelect.subviews.last as! TPBaseTextField).text = "Tháng " + formatter.string(from: date)
//
//        let formatter1 = DateFormatter()
//        formatter1.dateFormat = "yyyy-MM"
//        dateFrom = formatter1.string(from: date) + "-01"
//        if let dateFrom1 = dateFrom, let dateFromString = stringToDate(txt: dateFrom1) {
//            let formatter2 = DateFormatter()
//            formatter2.dateFormat = "yyyy-MM-dd"
//            dateTo = formatter2.string(from: dateFromString.endOfMonth)
//            Commons.showLoading(view)
//            typeRequest = .GetHistoryTransaction
//            TPNetworkManager.shared.requestHistoryTransaction(page: 1, count: 12, from_date: dateFrom, to_date: dateTo, search: nil, product_type_id: nil, coordbust)
//        }
        
    }

}

extension TPHistoryTransactionVC {
    func coordbust(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        Commons.hideLoading(self.view)
        if let error=errur{
            Commons.showDialogNetworkError()
            
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
            switch typeRequest {
            case .GetProductType:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    if let cus = TPProductTypeObjectArray(JSON: shitDic), let data = cus.data{
                        dataArrayKind = data
                        //self.showPopupSelec()
                        //flagGetHistoryTransaction = true
                        flagGetKindSussess = true
                    }
                }
                break
            case .GetHistoryTransaction:
                if code != 0 {
                    Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
                }else{
                    if let cus = TPTransactionProductObjectArray(JSON: shitDic), let data = cus.data, let dataArr = data.TransactionProducts{
                        dataArrayHistory = dataArr
                        tbvView.numberOfSections = dataArrayHistory.count
                        DispatchQueue.main.async {
                            self.tbvView.tbv.reloadData()
                            if self.dataArrayHistory.isEmpty {
                                self.showToastFix(sms: "Chưa có lịch sử giao dịch")
                            }
                        }
                    }
                }
                break
            default:
                break
            }
            
            
            
            
            
        }
    }
}

