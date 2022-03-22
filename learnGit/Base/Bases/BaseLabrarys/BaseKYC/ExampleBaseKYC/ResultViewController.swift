//
//  ResultViewController.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 03/02/2021.
//

import UIKit

class ResultViewController: FTBaseViewController {
    
    @IBOutlet weak var resultView: UIStackView!
    @IBOutlet weak var identityNameLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var fakeRealLabel: UILabel!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var faceIdentityImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewBackground: UIView!
    
    var faceIdentity: UIImage!
    var frontImage: UIImage!
    var backImage: UIImage!
    let apiService = APIServices()
    var ocrFrontData = OCRFrontData()
    var ocrBackData = OCRBackData()
    var loadingView = UIView()
    var ocrResult = OCRResult()
    var isAPI1Response = false
    var isAPI2Response = false
    var isAPI3Response = false
    var reachability: Reachability!
    var compareFaceResponse : Face2Face!
    var uploadOCRFrontResponse : OCRFront!
    var uploadOCRBackResponse : OCRBack!
    var onDoneBlock : ((Bool) -> Void)?
    var resultCallBack: ResultOCR?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
//        do {
//            try reachability?.startNotifier()
//        } catch {
//            print("could not start reachability notifier")
//        }
        
        checkConnection()
        setupLanguage()
        fillData()
        //self.infoTableView.dataSource = self
        //self.infoTableView.delegate = self
        stackViewBackground.layer.cornerRadius = 20
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLoading()
        //view.backgroundColor = .red
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    //    //MARK: Kiểm tra internet connection liên tục khi có thông báo kết nối/ngắt
    @objc func reachabilityChanged(_ note: Notification) {
        if let reachability = note.object as? Reachability {
            if reachability.isReachable {
                //TODO: Xử lý ngay lập tức khi có kết nối
                print("Reachable")
                reachableInternet()
            } else {
                //TODO: Xử lý ngay lập tức khi bị mất mạng
                print("un Reachable")
                reachableNotInternet()
            }
        }
    }
    
    open func reachableInternet() {
        refreshData()
    }
    
    open func reachableNotInternet() {
        checkConnection()
    }
    
}

//class ResultViewController: UIViewController {
//    @IBOutlet weak var resultView: UIStackView!
//    @IBOutlet weak var identityNameLabel: UILabel!
//    @IBOutlet weak var resultLabel: UILabel!
//    @IBOutlet weak var scoreLabel: UILabel!
//    @IBOutlet weak var fakeRealLabel: UILabel!
//    @IBOutlet weak var infoTableView: UITableView!
//    @IBOutlet weak var faceIdentityImageView: UIImageView!
//    @IBOutlet weak var frontImageView: UIImageView!
//    @IBOutlet weak var backImageView: UIImageView!
//    @IBOutlet weak var doneBtn: UIButton!
//    @IBOutlet weak var separatorLine: UIView!
//    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
//    @IBOutlet weak var stackViewBackground: UIView!
//
//    var faceIdentity: UIImage!
//    var frontImage: UIImage!
//    var backImage: UIImage!
//    let apiService = APIServices()
//    var ocrFrontData = OCRFrontData()
//    var ocrBackData = OCRBackData()
//    var loadingView = UIView()
//    var ocrResult = OCRResult()
//    var isAPI1Response = false
//    var isAPI2Response = false
//    var isAPI3Response = false
//    var reachability: Reachability!
//    var compareFaceResponse : Face2Face!
//    var uploadOCRFrontResponse : OCRFront!
//    var uploadOCRBackResponse : OCRBack!
//    var onDoneBlock : ((Bool) -> Void)?
//    var resultCallBack: ResultOCR?
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        reachability = Reachability()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
//        do {
//            try reachability?.startNotifier()
//        } catch {
//            print("could not start reachability notifier")
//        }
//        checkConnection()
//        setupLanguage()
//        fillData()
//        self.infoTableView.dataSource = self
//        self.infoTableView.delegate = self
//        stackViewBackground.layer.cornerRadius = 20
//        showLoading()
//    }
//
//    func refreshData() {
//        checkConnection()
//        setupLanguage()
//        fillData()
//        DispatchQueue.main.async {
//            self.infoTableView.dataSource = self
//            self.infoTableView.delegate = self
//            self.stackViewBackground.layer.cornerRadius = 20
//            self.removeLoading()
//        }
//    }
//
//    //MARK: Kiểm tra internet connection liên tục khi có thông báo kết nối/ngắt
//    @objc func reachabilityChanged(_ note: Notification) {
//        if let reachability = note.object as? Reachability {
//            if reachability.isReachable {
//                //TODO: Xử lý ngay lập tức khi có kết nối
//                print("Reachable")
//                reachableInternet()
//            } else {
//                //TODO: Xử lý ngay lập tức khi bị mất mạng
//                print("un Reachable")
//                reachableNotInternet()
//            }
//        }
//    }
//
//    open func reachableInternet() {
//        refreshData()
//    }
//
//    open func reachableNotInternet() {
//        checkConnection()
//    }
//
//    func hasInternetConnection() -> Bool {
//        if (reachability?.isReachable)! {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    func showLoading() {
//        loadingView = UIView(frame: self.view.bounds)
//        loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        let spinner = UIActivityIndicatorView(style: .gray)
//        spinner.translatesAutoresizingMaskIntoConstraints = false
//        spinner.startAnimating()
//        loadingView.addSubview(spinner)
//        spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
//        spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
//        self.view.addSubview(loadingView)
//    }
//
//    func setupLanguage() {
//        DispatchQueue.main.async {
//            if isVN {
//                self.doneBtn.setTitle("Hoàn thành", for: .normal)
//                self.resultLabel.text = "Tỷ lệ trùng khớp khuôn mặt"
//            } else {
//                self.doneBtn.setTitle("Done", for: .normal)
//                self.resultLabel.text = "Likehood score"
//            }
//        }
//
//    }
//
//    private func fillData() {
//        DispatchQueue.main.async {
//            self.faceIdentityImageView.image = self.faceIdentity
//            self.frontImageView.image = self.frontImage.rotate(radians: -.pi / 2)
//            self.backImageView.image = self.backImage.rotate(radians: -.pi / 2)
//            self.resultLabel.isHidden = false
//        }
//        apiRequest()
//    }
//
//    func colorWithRed(_ red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat = 1.0) ->  UIColor{
//        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
//    }
//
//    private func apiRequest() {
//        let group = DispatchGroup()
//        group.enter()
//        self.apiService.compare2Face(identityImage: self.frontImage, faceImage: self.faceIdentity) { (response) in
//            self.compareFaceResponse = response
//            group.leave()
//        }
//        group.enter()
//        self.apiService.requestUploadOCRFront(image: self.frontImage) { (response) in
//            self.uploadOCRFrontResponse = response
//            group.leave()
//        }
//        group.enter()
//        self.apiService.requestUploadOCRBack(image: self.backImage) { (response) in
//            self.uploadOCRBackResponse = response
//            group.leave()
//        }
//        group.notify(queue: DispatchQueue.main) { [weak self] in
//            if let weakSelf = self {
//                if weakSelf.compareFaceResponse.status_code == 200 {
//                    DispatchQueue.main.async {
//                        weakSelf.isAPI1Response = true
//                        weakSelf.scoreLabel.text = "\(Int(weakSelf.compareFaceResponse.match_score ?? 0) )/100"
//                        weakSelf.ocrResult.imageResult = "\(Int(weakSelf.compareFaceResponse.match_score ?? 0) )/100"
//                        weakSelf.fakeRealLabel.text = weakSelf.compareFaceResponse.predict?.uppercased()
//                        if let predict = weakSelf.compareFaceResponse.predict?.uppercased() {
//                            weakSelf.ocrResult.fakeOrReal = predict
//                        }
//                        weakSelf.fakeRealLabel.textColor = .white
//                        weakSelf.scoreLabel.textColor = .white
//                        if let score = weakSelf.compareFaceResponse.match_score {
//                            if score >= 50 {
//                                weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(49, green: 155, blue: 67)
//                                weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(49, green: 155, blue: 67)
//                            } else {
//                                weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
//                                weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
//                            }
//                        }else {
//                            weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
//                            weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
//                        }
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        weakSelf.isAPI1Response = true
//                        weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(255, green: 181, blue: 70)
//                        weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(255, green: 181, blue: 70)
//                        weakSelf.fakeRealLabel.textColor = .black
//                        if isVN {
//                            weakSelf.fakeRealLabel.text = "HÌNH ẢNH CHƯA HỢP LỆ"
//                            weakSelf.ocrResult.fakeOrReal = "HÌNH ẢNH CHƯA HỢP LỆ"
//                        } else {
//                            weakSelf.ocrResult.fakeOrReal = "INVALID IMAGE"
//                            weakSelf.fakeRealLabel.text = "INVALID IMAGE"
//                        }
//
//                        weakSelf.separatorLine.isHidden = true
//                        weakSelf.scoreLabel.isHidden = true
//                    }
//                }
//
//                if weakSelf.uploadOCRFrontResponse.error_code == 200 {
//                    if let data = weakSelf.uploadOCRFrontResponse.data {
//                        print(data)
//                        weakSelf.ocrFrontData = data
//                        DispatchQueue.main.async {
//                            weakSelf.isAPI2Response = true
//                            weakSelf.identityNameLabel.text = data.name
//                            weakSelf.infoTableView.reloadData()
//                        }
//                    }
//                } else {
//
//                    weakSelf.isAPI2Response = true
//                    weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRFrontResponse.error_code ?? 0)", message: weakSelf.uploadOCRFrontResponse.description ?? "")
//                }
//                if weakSelf.uploadOCRBackResponse.error_code == 200 {
//                    if let data = weakSelf.uploadOCRBackResponse.data {
//                        print(data)
//                        weakSelf.ocrBackData = data
//                        DispatchQueue.main.async {
//                            weakSelf.isAPI3Response = true
//                            weakSelf.infoTableView.reloadData()
//                        }
//                    }
//                } else {
//                    weakSelf.isAPI3Response = true
//                    weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRBackResponse.error_code ?? 0)", message: weakSelf.uploadOCRBackResponse.description ?? "")
//
//                    weakSelf.removeLoading()
//                }
//            }
//        }
//    }
//
//
//    func removeLoading() {
//        if isAPI1Response && isAPI2Response && isAPI3Response {
//            self.loadingView.removeFromSuperview()
//        }
//    }
//
//    override func viewWillLayoutSubviews() {
//        super.updateViewConstraints()
//        self.tableViewHeight.constant = self.infoTableView.contentSize.height
//    }
//
//    func resizeTableView() {
//        self.resultCallBack?.resultCallBack(image: self.ocrResult)
//        self.onDoneBlock!(true)
//        self.tableViewHeight.constant = self.infoTableView.contentSize.height
//        self.infoTableView.layoutIfNeeded()
//    }
//
//    @IBAction func doneAction(_ sender: Any) {
//        //        self.navigationController?.popToRootViewController(animated: true)
//        self.dismiss(animated: false, completion: nil)
//    }
//
//}

extension ResultViewController {
    func resizeTableView() {
        self.resultCallBack?.resultCallBack(image: self.ocrResult)
        self.onDoneBlock!(true)
        self.tableViewHeight.constant = self.infoTableView.contentSize.height
        self.infoTableView.layoutIfNeeded()
    }
    func refreshData() {
        checkConnection()
        setupLanguage()
        fillData()
        DispatchQueue.main.async {
            self.infoTableView.dataSource = self
            self.infoTableView.delegate = self
            self.stackViewBackground.layer.cornerRadius = 20
            self.removeLoading()
        }
    }
    func setupLanguage() {
        DispatchQueue.main.async {
            if isVN {
                self.doneBtn.setTitle("Hoàn thành", for: .normal)
                self.resultLabel.text = "Tỷ lệ trùng khớp khuôn mặt"
            } else {
                self.doneBtn.setTitle("Done", for: .normal)
                self.resultLabel.text = "Likehood score"
            }
        }
    }
    private func fillData() {
        DispatchQueue.main.async {
            self.faceIdentityImageView.image = self.faceIdentity
            self.frontImageView.image = self.frontImage.rotate(radians: -.pi / 2)
            self.backImageView.image = self.backImage.rotate(radians: -.pi / 2)
            self.resultLabel.isHidden = false
        }
        apiRequest()
    }
    func removeLoading() {
        self.loadingView.removeFromSuperview()
//        if isAPI1Response && isAPI2Response && isAPI3Response {
//            self.loadingView.removeFromSuperview()
//        }
    }
    func colorWithRed(_ red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat = 1.0) ->  UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    func showLoading() {
        loadingView = UIView(frame: self.view.bounds)
        loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        loadingView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        self.view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
    }
}

extension ResultViewController {
    private func apiRequest() {
        let group = DispatchGroup()
        group.enter()
        self.apiService.compare2Face(identityImage: self.frontImage, faceImage: self.faceIdentity) { (response) in
            self.compareFaceResponse = response
            group.leave()
        }
        group.enter()
        self.apiService.requestUploadOCRFront(image: self.frontImage) { (response) in
            self.uploadOCRFrontResponse = response
            group.leave()
        }
        group.enter()
        self.apiService.requestUploadOCRBack(image: self.backImage) { (response) in
            self.uploadOCRBackResponse = response
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) { [weak self] in
            if let weakSelf = self {
                weakSelf.removeLoading()
                if weakSelf.compareFaceResponse.status_code == 200 {
                    DispatchQueue.main.async {
                        weakSelf.isAPI1Response = true
                        weakSelf.scoreLabel.text = "\(Int(weakSelf.compareFaceResponse.match_score ?? 0) )/100"
                        weakSelf.ocrResult.imageResult = "\(Int(weakSelf.compareFaceResponse.match_score ?? 0) )/100"
                        weakSelf.fakeRealLabel.text = weakSelf.compareFaceResponse.predict?.uppercased()
                        if let predict = weakSelf.compareFaceResponse.predict?.uppercased() {
                            weakSelf.ocrResult.fakeOrReal = predict
                        }
                        weakSelf.fakeRealLabel.textColor = .white
                        weakSelf.scoreLabel.textColor = .white
                        if let score = weakSelf.compareFaceResponse.match_score {
                            if score >= 50 {
                                weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(49, green: 155, blue: 67)
                                weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(49, green: 155, blue: 67)
                            } else {
                                weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
                                weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
                            }
                        }else {
                            weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
                            weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(223, green: 68, blue: 68)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        weakSelf.isAPI1Response = true
                        weakSelf.resultView.backgroundColor = weakSelf.colorWithRed(255, green: 181, blue: 70)
                        weakSelf.stackViewBackground.backgroundColor = weakSelf.colorWithRed(255, green: 181, blue: 70)
                        weakSelf.fakeRealLabel.textColor = .black
                        if isVN {
                            weakSelf.fakeRealLabel.text = "HÌNH ẢNH CHƯA HỢP LỆ"
                            weakSelf.ocrResult.fakeOrReal = "HÌNH ẢNH CHƯA HỢP LỆ"
                        } else {
                            weakSelf.ocrResult.fakeOrReal = "INVALID IMAGE"
                            weakSelf.fakeRealLabel.text = "INVALID IMAGE"
                        }
                        
                        weakSelf.separatorLine.isHidden = true
                        weakSelf.scoreLabel.isHidden = true
                    }
                }
                
                if weakSelf.uploadOCRFrontResponse.error_code == 200 {
                    if let data = weakSelf.uploadOCRFrontResponse.data {
                        print(data)
                        weakSelf.ocrFrontData = data
                        DispatchQueue.main.async {
                            weakSelf.isAPI2Response = true
                            weakSelf.identityNameLabel.text = data.name
                            weakSelf.infoTableView.reloadData()
                        }
                    }
                } else {
                    
                    weakSelf.isAPI2Response = true
                    weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRFrontResponse.error_code ?? 0)", message: weakSelf.uploadOCRFrontResponse.description ?? "")
                }
                if weakSelf.uploadOCRBackResponse.error_code == 200 {
                    if let data = weakSelf.uploadOCRBackResponse.data {
                        print(data)
                        weakSelf.ocrBackData = data
                        DispatchQueue.main.async {
                            weakSelf.isAPI3Response = true
                            weakSelf.infoTableView.reloadData()
                        }
                    }
                } else {
                    weakSelf.isAPI3Response = true
                    weakSelf.showAlert(title: "Error Code: \(weakSelf.uploadOCRBackResponse.error_code ?? 0)", message: weakSelf.uploadOCRBackResponse.description ?? "")
                    
                    //weakSelf.removeLoading()
                }
            }
        }
    }
}
extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "infoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! InfoTableViewCell
        switch indexPath.row {
        case 0:
            if isVN {
                cell.titleLabel.text = "Số CMND/CCCD"
            } else {
                cell.titleLabel.text = "ID number"
            }
            cell.descriptionLabel.text = self.ocrFrontData.id
            self.ocrResult.id = self.ocrFrontData.id
            if self.ocrFrontData.id == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 1:
            if isVN {
                cell.titleLabel.text = "Họ tên"
            } else {
                cell.titleLabel.text = "Name"
            }
            cell.descriptionLabel.text = self.ocrFrontData.name
            self.ocrResult.name = self.ocrFrontData.name
            if self.ocrFrontData.name == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 2:
            if isVN {
                cell.titleLabel.text = "Ngày sinh"
            } else {
                cell.titleLabel.text = "Date of birth"
            }
            cell.descriptionLabel.text = self.ocrFrontData.dob
            self.ocrResult.dob = self.ocrFrontData.dob
            if self.ocrFrontData.dob == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 3:
            if isVN {
                cell.titleLabel.text = "Giới tính"
            } else {
                cell.titleLabel.text = "Gender"
            }
            cell.descriptionLabel.text = self.ocrFrontData.gender
            self.ocrResult.gender = self.ocrFrontData.gender
            if self.ocrFrontData.gender == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 4:
            if isVN {
                cell.titleLabel.text = "Quê quán"
            } else {
                cell.titleLabel.text = "Hometown"
            }
            cell.descriptionLabel.text = self.ocrFrontData.hometown
            self.ocrResult.hometown = self.ocrFrontData.hometown
            if self.ocrFrontData.hometown == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 5:
            if isVN {
                cell.titleLabel.text = "ĐKHK thường trú"
            } else {
                cell.titleLabel.text = "Address"
            }
            cell.descriptionLabel.text = self.ocrFrontData.address
            self.ocrResult.address = self.ocrFrontData.address
            if self.ocrFrontData.address == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 6:
            if isVN {
                cell.titleLabel.text = "Giá trị sử dụng"
            } else {
                cell.titleLabel.text = "Expired"
            }
            cell.descriptionLabel.text = self.ocrFrontData.expired
            self.ocrResult.expired = self.ocrFrontData.expired
            if self.ocrFrontData.expired == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 7:
            if isVN {
                cell.titleLabel.text = "Dân tộc"
            } else {
                cell.titleLabel.text = "Nation"
            }
            cell.descriptionLabel.text = self.ocrBackData.nation
            self.ocrResult.nation = self.ocrBackData.nation
            if self.ocrBackData.nation == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 8:
            if isVN {
                cell.titleLabel.text = "Tôn giáo"
            } else {
                cell.titleLabel.text = "Religion"
            }
            cell.descriptionLabel.text = self.ocrBackData.religion
            self.ocrResult.religion = self.ocrBackData.religion
            if self.ocrBackData.religion == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 9:
            if isVN {
                cell.titleLabel.text = "Đặc điểm nhận dạng"
            } else {
                cell.titleLabel.text = "Characteristic"
            }
            cell.descriptionLabel.text = self.ocrBackData.characteristic
            self.ocrResult.characteristic = self.ocrBackData.characteristic
            if self.ocrBackData.characteristic == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 10:
            if isVN {
                cell.titleLabel.text = "Ngày cấp"
            } else {
                cell.titleLabel.text = "Issue date"
            }
            cell.descriptionLabel.text = self.ocrBackData.issued_on
            self.ocrResult.issued_on = self.ocrBackData.issued_on
            if self.ocrBackData.religion == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        case 11:
            if isVN {
                cell.titleLabel.text = "Nơi cấp"
            } else {
                cell.titleLabel.text = "Issue place"
            }
            cell.descriptionLabel.text = self.ocrBackData.location
            self.ocrResult.location = self.ocrBackData.location
            if self.ocrBackData.location == "N/A" {
                cell.naView.isHidden = false
            } else {
                cell.naView.isHidden = true
            }
        default:
            return cell
        }
        self.resizeTableView()
        return cell
    }
}





extension ResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
}
