//
//  TPResultOCRViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/24/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPResultOCRViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    @IBOutlet weak var viewTong: UIView!
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHeader1: UIView!
    @IBOutlet weak var viewHeader2: UIView!
    @IBOutlet weak var viewMK1: UIView!
    @IBOutlet weak var viewMK2: UIView!
    @IBOutlet weak var viewContainer: UIView!
    
    let apiService = APIServices()
    var uploadOCRFrontResponse : OCRFront?
    var uploadOCRBackResponse : OCRBack?
    var ocrFrontData = OCRFrontData()
    var ocrBackData = OCRBackData()
    var isAPI2Response = false
    var isAPI3Response = false
    
    var imageFront:UIImage?
    var imageBack:UIImage?
    
    var nameArray:[String] = ["Tài khoản liên kết","Hợp đồng điện tử","Lịch sử giao dịch",
                              "Cài đặt & Bảo mật", "Thông tin hỗ trợ",
                              "Hợp đồng điện tử","Lịch sử giao dịch",
                                                        "Cài đặt & Bảo mật", "Thông tin hỗ trợ"]
    var data1 = ["Số CMND/CCCD","Họ tên","Ngày sinh",
                 "Giới tính","Quê quán","ĐKHK thường trú",
                 "Giá trị sử dụng","Dân tộc","Tôn giáo",
                 "Đặc điểm nhận dạng","Ngày cấp","Nơi cấp",]
    
    var data2 = ["N/A","N/A","N/A",
                 "N/A","N/A","N/A",
                 "N/A","N/A","N/A",
                 "N/A","N/A","N/A",]
    
    var dataTest = ["012354687","Harry Tran","20/4/2021",
                 "Nam","Thủy Xuân Tiên, Chương Mỹ,Hà Nội","Thủy Xuân Tiên, Chương Mỹ,Hà Nội",
                 "20/4/2021","Kinh","Không",
                 "Nốt ruồi","20/4/2021","Hà Nội",]
    
    init() {
        super.init(nibName: "TPResultOCRViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        backToAnyViewController(n: 2)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTong.backgroundColor = .clear
        stack1.backgroundColor = .clear
        viewHeader1.backgroundColor = .black
        viewHeader2.backgroundColor = .black
        stack1.subviews.first?.isHidden = true
        scrollView.backgroundColor = .clear
        tbvView.tbv.estimatedRowHeight=64
        tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = data1.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        //tbvView.tbv.disableScroll()
        tbvView.registerCellWithNib(nib: UINib(nibName: "TitleAndTitleTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = UITableView.automaticDimension
        //tbvView.heightForHeaderInSection = 1
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 1
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 1
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleAndTitleTableViewCell
            cell.title1.text = self.data1[indexPath.section]
            cell.title2.text = self.data2[indexPath.section]
            cell.title1.font = UIFont.systemFont(ofSize: 14)
            cell.title2.font = UIFont.systemFont(ofSize: 14)
            cell.title1.textColor = UIColor(rgb: 0x919191)
            cell.title2.textColor = UIColor(rgb: 0xEAEAEC)
            cell.backgroundColor = UIColor(rgb: 0x21232C)
            return cell
        }
        tbvView.delegateDatasource {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        namelabel.text = fullNameTemp
        Commons.showLoading(view)
        if let btnReScan = stack2.subviews.first as? TPBaseViewImageWithLabel {
            btnReScan.indexPath = .init()
            btnReScan.actionClosure = {
                [weak self ]indexPath in
                guard let selfWeak = self else {
                    return
                }
                selfWeak.backToAnyViewController(n: 2)
            }
        }
        if let btnConfirm = stack2.subviews.last as? TPBaseViewImageWithLabel {
            btnConfirm.indexPath = .init()
            btnConfirm.actionClosure = {
                [weak self ]indexPath in
                guard let selfWeak = self else {
                    return
                }
                selfWeak.confirmAction()
            }
        }
        viewMK2.isHidden = true
        viewMK1.isHidden = false
        stack2.isHidden = true
    }
    
    func confirmAction(){
        if let device_token = TPCakeDefaults.shared.access_token {
            var data1 = ["Số CMND/CCCD","Họ tên","Ngày sinh",
                         "Giới tính","Quê quán","ĐKHK thường trú",
                         "Giá trị sử dụng","Dân tộc","Tôn giáo",
                         "Đặc điểm nhận dạng","Ngày cấp","Nơi cấp",]
            
            let fullname = data2[1]
            let id_number = data2[0]
            let date_of_birth = data2[2]
            let sex = data2[3]
            let nationality = "Việt Nam"
            let place_of_origin = data2[4]
            let place_of_residence = data2[5]
            let date_of_expired = data2[6]
            let ethnic = data2[7]
            let religion = data2[8]
            let personal_identification = data2[9]
            let date_of_issue = data2[10]
            let place_of_issue = data2[11]
            let image_front = uploadOCRFrontResponse!.data!.url
            let image_back = uploadOCRBackResponse!.data!.url
            let kyc_score = "100"
            
            Commons.showLoading(view)
            TPNetworkManager.shared.requestProfileUpdateKYC(access_token: device_token, fullname: fullname, id_number: id_number, date_of_birth: date_of_birth, sex: sex, nationality: nationality, place_of_origin: place_of_origin, place_of_residence: place_of_residence, date_of_expired: date_of_expired, ethnic: ethnic, religion: religion, personal_identification: personal_identification, date_of_issue: date_of_issue, place_of_issue: place_of_issue, image_front: image_front, image_back: image_back, kyc_score: kyc_score, coordbust)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getOCR()
    }
    
    func getOCR(){
        viewHeader1.backgroundColor = .black
        viewHeader2.backgroundColor = .black
        stack1.subviews.first?.isHidden = true
        stack2.subviews.last?.isHidden = false 
        (stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor1 = true
        (stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor2 = false
        (stack2.subviews.first! as! TPBaseViewImageWithLabel).title.textColor =  .white
        apiRequest()
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        backToAnyViewController2(vc: TPTabBarViewControllerShared!)
        
    }
    
    @IBAction func btnReMakePressed(_ sender: UIButton) {
        backToAnyViewController(n: 2)
    }
    
    @IBAction func btnConfirmPressed(_ sender: UIButton) {
        confirmAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
        self.tbvView.layoutIfNeeded()
    }
}

extension TPResultOCRViewController {
    private func apiRequest() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.testImage(img: self.imageFront!.rotate(radians: -.pi/2))
//        }
        
        
        let group = DispatchGroup()
//        group.enter()
//        self.apiService.compare2Face(identityImage: self.frontImage, faceImage: self.faceIdentity) { (response) in
//            self.compareFaceResponse = response
//            group.leave()
//        }
        group.enter()
        self.apiService.requestUploadOCRFront(image: self.imageFront!.rotate(radians: -.pi/2)) { (response) in
            self.uploadOCRFrontResponse = response
            print(response)
            group.leave()
        }
        group.enter()
        
        self.apiService.requestUploadOCRBack(image: self.imageBack!.rotate(radians: -.pi/2)) { (response) in
            self.uploadOCRBackResponse = response
            print(response)
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) { [weak self] in
            if let weakSelf = self {
                Commons.hideLoading(weakSelf.view)
//                weakSelf.stack2.subviews.last?.isHidden = true
//                (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor1 = false
//                (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor2 = true
//                (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).txtColor = .black
//                weakSelf.viewHeader1.backgroundColor = UIColor(rgb: 0xDA3937)
//                weakSelf.viewHeader2.backgroundColor = UIColor(rgb: 0xDA3937)
//                weakSelf.viewContainer.bringSubviewToFront(weakSelf.viewMK2)
//                weakSelf.viewMK2.isHidden = false
//                weakSelf.viewMK1.isHidden = true
                
                //weakSelf.viewMK1.frame = weakSelf.stack2.frame
                //weakSelf.viewContainer.addSubview(weakSelf.viewMK1)
                //weakSelf.viewMK2.frame = weakSelf.stack2.frame
                //weakSelf.viewContainer.addSubview(weakSelf.viewMK2)
                //weakSelf.viewMK1.isHidden = true
                //viewContainer.bringSubviewToFront(self.viewMK1)
                weakSelf.viewMK1.isHidden = true
                weakSelf.viewMK2.isHidden = false
                DispatchQueue.main.async {
                    weakSelf.stack1.subviews.first?.isHidden = false
                }
                
                if weakSelf.uploadOCRFrontResponse == nil || weakSelf.uploadOCRBackResponse == nil {
                    weakSelf.showDialogMessage("Chưa lấy được thông tin.")
                    return
                }
                guard let error_code_front = weakSelf.uploadOCRFrontResponse!.error_code , let error_code_back = weakSelf.uploadOCRBackResponse!.error_code else {
                    weakSelf.showDialogMessage("Chưa lấy được thông tin.")
                    return
                }
                guard error_code_front == 200 && error_code_back == 200 else {
                    weakSelf.showDialogMessage("Đã có lỗi xảy ra .")
                    return
                }
                guard let dataFront = weakSelf.uploadOCRFrontResponse!.data, let dataBack = weakSelf.uploadOCRBackResponse!.data else {
                    weakSelf.showDialogMessage("Chưa có dữ liệu .")
                    return
                }
                
                let numberID = dataFront.id
                let name = dataFront.name
                let birday = dataFront.dob
                let gender = dataFront.gender
                let hometown = dataFront.hometown
                let address = dataFront.address
                let expired = dataFront.expired
                
                let nation = dataBack.nation
                let religion = dataBack.religion
                let characteristic = dataBack.characteristic
                let issued_on = dataBack.issued_on
                let location = dataBack.location
                
                weakSelf.data2 = [numberID,name,birday,
                              gender,hometown,address,
                              expired,nation,religion,
                              characteristic,issued_on,location,]
                
                DispatchQueue.main.async {
//                    weakSelf.viewHeader1.backgroundColor = .black
//                    weakSelf.viewHeader2.backgroundColor = .black
//                    weakSelf.stack1.subviews.first?.isHidden = true
//                    weakSelf.stack2.subviews.last?.isHidden = false
//                    (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor1 = true
//                    (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).setBgColor2 = false
//                    (weakSelf.stack2.subviews.first! as! TPBaseViewImageWithLabel).title.textColor =  .white
//                    weakSelf.viewMK1.frame = weakSelf.stack2.frame
//                    weakSelf.viewContainer.addSubview(weakSelf.viewMK1)
//                    weakSelf.viewMK2.frame = weakSelf.stack2.frame
//                    weakSelf.viewContainer.addSubview(weakSelf.viewMK2)
//                    weakSelf.viewMK2.isHidden = true
//                    //viewContainer.bringSubviewToFront(self.viewMK1)
//                    weakSelf.stack2.isHidden = true
                    weakSelf.viewMK1.isHidden = false
                    weakSelf.viewMK2.isHidden = true
                    weakSelf.stack1.subviews.first?.isHidden = true
                    print("------lllllll")
                    weakSelf.tbvView.tbv.reloadData()
                }
                
                
//                if weakSelf.uploadOCRFrontResponse.error_code == 200 {
//                    if let data = weakSelf.uploadOCRFrontResponse.data {
//                        print(data)
//                        weakSelf.ocrFrontData = data
//                        DispatchQueue.main.async {
//                            weakSelf.isAPI2Response = true
//                            print(data.name)
//                            //weakSelf.infoTableView.reloadData()
//                        }
//                    }
//                } else {
//
//                    weakSelf.isAPI2Response = true
//                    weakSelf.showSimpleAlert(title: "Error Code: \(weakSelf.uploadOCRFrontResponse.error_code ?? 0)", ms: weakSelf.uploadOCRFrontResponse.description ?? "")
//                    //weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRFrontResponse.error_code ?? 0)", message: weakSelf.uploadOCRFrontResponse.description ?? "")
//                }
//                if weakSelf.uploadOCRBackResponse.error_code == 200 {
//                    if let data = weakSelf.uploadOCRBackResponse.data {
//                        print(data)
//                        weakSelf.ocrBackData = data
//                        DispatchQueue.main.async {
//                            weakSelf.isAPI3Response = true
//                            //weakSelf.infoTableView.reloadData()
//                        }
//                    }
//                } else {
//                    weakSelf.isAPI3Response = true
//                    weakSelf.showSimpleAlert(title: "Error Code: \(weakSelf.uploadOCRBackResponse.error_code ?? 0)", ms: weakSelf.uploadOCRBackResponse.description ?? "")
//                    //weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRBackResponse.error_code ?? 0)", message: weakSelf.uploadOCRBackResponse.description ?? "")
//
//                    //weakSelf.removeLoading()
//                }
            }
        }
    }
}

extension TPResultOCRViewController {
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
        let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        print(shit)
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            if let data = shitDic["Data"] as? [String:Any]{
                saveDataInfoUser(data: data)
            }
            Commons.hideLoading(self.view)
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                status_verify_kyc = true
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    TPFrontImage = self.imageFront!.rotate(radians: -.pi/2)
                    TPBackImage = self.imageBack!.rotate(radians: -.pi/2)
                    self.backToAnyViewController(n: 3)
                })

            }
            
            
        }
    }
}




