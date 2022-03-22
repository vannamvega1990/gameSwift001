//
//  TPInfoPersionViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPInfoPersionViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    @IBOutlet weak var btnKYCView: TPBaseViewImageWithLabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewImage: UIStackView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var notYetKYCView: BaseView!
    
    var nameArray:[String] = ["Tài khoản liên kết","Hợp đồng điện tử","Lịch sử giao dịch",
                              "Cài đặt & Bảo mật", "Thông tin hỗ trợ"]
    var data = ["Họ và tên",
                "Số điện thoại",
                "Email",
                "Giới tính",
                "Ngày sinh",]
//    var data2 = ["Harry Tran",
//                 "123456879",
//                 "abc@gmail.com",
//                 "Lựa chọn",
//                 "Lựa chọn"]
    var data2 = ["",
                 "",
                 "",
                 "Lựa chọn",
                 "Lựa chọn"]
    //var status_verify_email = false
    var lableVerifyEmail = UILabel()
    
    init() {
        super.init(nibName: "TPInfoPersionViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnGoKYCPressed() {
        let vc = TPDiscriptionKYCViewController()
        pushToViewController(vc, true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnKYCView.indexPath = IndexPath(row: 1, section: 1)
        btnKYCView.actionClosure = { indexPath in
            self.btnGoKYCPressed()
        }
        notYetKYCView.isFakeUIButton = true
        notYetKYCView.actionFakeWhenTouchUp = {
            self.btnGoKYCPressed()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupKeyboardDismissRecognizer()
        //tbvView.tbv.estimatedRowHeight=64
        //tbvView.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = data.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        tbvView.tbv.disableScroll()
        tbvView.registerCellWithNib(nib: UINib(nibName: "TitleAndSubTitleTableViewCell", bundle: nil), idCell: "cell")
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
            cell.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
            cell.title.textColor = UIColor(rgb: 0x919191, alpha: 1)
            cell.subTitle.textColor = .white
            cell.title.text = self.data[indexPath.section]
            cell.subTitle.text = self.data2[indexPath.section]
            if indexPath.section == 2 {
                
                self.lableVerifyEmail.removeFromSuperview()
                if status_verify_email{
                    self.lableVerifyEmail.text = "✓ Đã xác thực"
                    self.lableVerifyEmail.isHidden = false
                    self.lableVerifyEmail.textColor = UIColor(rgb: 0x289B3C)
                }else {
                    self.lableVerifyEmail.isHidden = false
                    self.lableVerifyEmail.text = "Chưa xác thực"
                    self.lableVerifyEmail.textColor = .red
                }
                
                self.lableVerifyEmail.textAlignment = .right
                self.lableVerifyEmail.font = .systemFont(ofSize: 12)
                cell.addSubview(self.lableVerifyEmail)
                cell.bringSubviewToFront(self.lableVerifyEmail)
                self.lableVerifyEmail.setConstraintByCode(constraintArray: [
                    self.lableVerifyEmail.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                    self.lableVerifyEmail.heightAnchor.constraint(equalToConstant: 56),
                    self.lableVerifyEmail.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -35)
                ])
                
            }
            cell.actionWhenClick = {
                if indexPath.section == 2 {
                    if !status_verify_email{
                        let vc = TPVerifyEmailVC()
                        vc.email = self.data2[indexPath.section]
                        self.pushToViewController(vc, true)
                    }
                }
            }
            return cell
        }
        tbvView.delegateDatasource {
            
        }
        //setupDisctiption()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
        self.tbvView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let access_token = TPCakeDefaults.shared.access_token {
            TPNetworkManager.shared.requestGetInfoUser(access_token, coordbust)
        }
    }
}

extension TPInfoPersionViewController: UITextViewDelegate {
    func setupDisctiption(){
        let quote = "Bạn cần cung cấp thông tin CCCD để định danh thực hiện các hoạt động liên quan tới chuyển tiền,.... theo qui định của Nhà nước"
        let attributedQuote = NSMutableAttributedString(string: quote)
        let attribute: [NSAttributedString.Key: Any] = [
                    .font: textView.font!,
            .foregroundColor: UIColor.white,
        ]
        attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: quote.length))
        let linkRange = (attributedQuote.string as NSString).range(of: "qui định")
        attributedQuote.addAttribute(NSAttributedString.Key.link, value: "signin", range: linkRange)
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xE98117),
        ]
        textView.linkTextAttributes = linkAttributes
        textView.attributedText = attributedQuote
        textView.delegate = self
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("123 link")
        return false
    }
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
            if code == -102 || code == -103 || code == -104 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: {
                    self.logoutTK()
                })
                return
            }
            saveDataInfoUser(data: dataDic)
            if code != 0 {
                Commons.showDialogAlert(title: "THÔNG BÁO", content: sms, inView: self.view, didFinishDismiss: nil)
            }else{
                if let cus = DataUserInfo(JSON: dataDic){
                    let fullName = cus.full_name ?? ""
                    let status_verify_kyc = cus.status_verify_kyc ?? false
                    stackView.subviews.last!.isHidden = status_verify_kyc
                    stackView.subviews.first!.isHidden = !status_verify_kyc
                    notYetKYCView.isHidden = stackView.subviews.last!.isHidden
                    let mobile = cus.mobile ?? ""
                    //status_verify_email = cus.status_verify_email ?? false
                    let email = cus.email ?? ""
                    //let gender = cus.gender ?? nil
                    let birth_day = cus.birth_day ?? ""
                    var gender1 = ""
                    if let gender = cus.gender {
                        gender1 = gender == 0 ? "Nam" : "Nữ"
                    }
                    
                    data2 = [fullName,
                             mobile,
                             email,
                             gender1,
                             birth_day]
                    if !status_verify_kyc {
                        data2 = [fullName,
                                 mobile,
                                 email,
                                 "",
                                 ""]
                    }
                    
                    //valueArray = [fullName,birth_day,gender, email, mobile, address]
                    if let imgFrontLink = cus.id_image_front {
                        let imgViewFront = stackViewImage.subviews.first as! UIImageView
                        //imgViewFront.imageFromURL(urlString: imgFrontLink)
                        let exImage = status_verify_kyc ? TPFrontImage : nil
                        imgViewFront.imageFromURL(urlString: imgFrontLink, extraImage:exImage)
                    }else {
                        //let imgViewFront = stackViewImage.subviews.first as! UIImageView
                        //imgViewFront.image = status_verify_kyc ? TPFrontImage : nil
                    }
                    if let imgBackLink = cus.id_image_back {
                        let imgViewBack = stackViewImage.subviews.last as! UIImageView
                        //imgViewBack.imageFromURL(urlString: imgBackLink)
                        let exImage = status_verify_kyc ? TPBackImage : nil
                        imgViewBack.imageFromURL(urlString: imgBackLink, extraImage:exImage)
                    }else{
                        //let imgViewBack = stackViewImage.subviews.last as! UIImageView
                        //imgViewBack.image = status_verify_kyc ? TPBackImage : nil
                    }
                    DispatchQueue.main.async {
                        self.tbvView.tbv.reloadData()
                    }
                }
                
            }
        }
    }
}
