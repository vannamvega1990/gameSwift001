//
//  TPAccountViewController.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPAccountViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvView: FTBaseTableView!
    @IBOutlet weak var viewStatusKyc: BaseView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var heightTbvContraint: NSLayoutConstraint!
    
    @IBAction func btnResize(_ sender: UIButton) {
        //tbvView.resizeHeightTableview()
        //tbvView.tbv.reloadData()
        //heightTbvContraint.constant = tbvView.tbv.contentSize.height
        //tbvView.layoutIfNeeded()
        //tbvView.setNeedsLayout()
        //tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
        
    }
    
    var nameArray:[String] = ["Tài khoản ngân hàng","Hợp đồng điện tử","Lịch sử giao dịch",
                              "Cài đặt & Bảo mật", "Thông tin hỗ trợ"]
    var iconArray:[String] = ["ic_bank_24","ic_contract_24","ic_history_24",
                              "ic_setting_24", "ic_info_24"]
    
    init() {
        super.init(nibName: "TPAccountViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnShowInfoPersionPressed(_ sender: UIButton) {
        let vc = TPInfoPersionViewController()
        pushToViewController(vc, true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fullNameLabel.text = ""
        mobileLabel.text = ""
        //tbvView.tbv.estimatedRowHeight=64
        //tbvView.tbv.rowHeight=UITableView.automaticDimension
        self.tbvView.tbv.estimatedSectionHeaderHeight = 1
        hiddenNavigation(isHidden: true)
        tbvView.numberOfSections = nameArray.count
        tbvView.numberRow = 1
        tbvView.setBackgroundColor(color: .clear)
        tbvView.tbv.disableScroll()
        tbvView.registerCellWithNib(nib: UINib(nibName: "profileTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 64
        //tbvView.heightForHeaderInSection = 1
        tbvView.heightForHeaderInSectionClorsure = { tbv, session in
            //let height: CGFloat = session == 0 ? 0 : 1
            let height: CGFloat = session == 0 ? 0 : CGFloat.leastNormalMagnitude
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        tbvView.viewForHeaderInSection = 1
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! profileTableViewCell
            cell.setTitle(name: self.nameArray[indexPath.section])
            cell.baseView.setIcon = UIImage(named: self.iconArray[indexPath.section])!
            cell.baseView.title.textAlignment = .left
            cell.baseView.title.textColor = .white
            cell.baseView.leftContraintLogo.constant = 20
            cell.baseView.leftContraintTitle.constant = 20
            cell.baseView.rootView.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
            cell.baseView.layoutIfNeeded()
            cell.heightlightBoder = true
            cell.hideHightlightWhenClick = true
            cell.baseView.indexPath = indexPath
            cell.baseView.actionClosure = { [weak self] index in
                print(index.section)
                switch index.section {
                case 0:
                    let vc = TPBankAccountViewController()
                    self?.pushToViewController(vc, true)
                    break
                case 1:
                    
                    break
                case 2:
                    let vc = TPHistoryTransactionVC()
                    self?.pushToViewController(vc, true)
                    break
                case 3:
                    let vc = TPSettingsViewController()
                    self?.pushToViewController(vc, true)
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
            self.tbvView.layoutIfNeeded()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("-----versionApp \(versionApp)")
            
//        tbvView.tbv.reloadData()
//        self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
//        self.tbvView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullNameLabel.text = fullNameTemp
        mobileLabel.text = mobileTemp
        viewStatusKyc.backgroundColor = !status_verify_kyc ? UIColor(rgb: 0xF3D2D2) : UIColor(rgb: 0xD2F3D8)
        let titleKyc = viewStatusKyc.subviews.first! as! UILabel
        titleKyc.text = status_verify_kyc ? "✓ Đã xác thực" : "✓ Chưa xác thực"
        titleKyc.textColor = !status_verify_kyc ? .red : UIColor(rgb: 0x289B3C)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
        self.tbvView.layoutIfNeeded()
        
//        let Device = UIDevice.current
//        let iOSVersion = NSString(string: Device.systemVersion).doubleValue
//        if iOSVersion >= 15 {
//            self.heightTbvContraint.constant = self.tbvView.heightOfCell * CGFloat((nameArray.count))
//            self.tbvView.layoutIfNeeded()
//        } else {
//            self.heightTbvContraint.constant = self.tbvView.tbv.contentSize.height
//            self.tbvView.layoutIfNeeded()
//        }
    }
    
    
    
}
