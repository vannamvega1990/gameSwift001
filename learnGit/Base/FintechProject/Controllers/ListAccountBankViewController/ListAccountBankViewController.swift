//
//  AccountBankViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/17/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class ListAccountBankViewController: FTBaseViewController {

    @IBOutlet weak var tbvView: FTBaseTableView!
    
    init() {
        super.init(nibName: "ListAccountBankViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnAddNewAccountBankPressed(_ sender: UIButton) {
        let addAccountBankVC = AddAccountBankViewController()
        pushToViewController(addAccountBankVC, true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvView.numberOfSections = 1
        tbvView.numberRow = 1
        tbvView.backgroundColor = UIColor.white
        tbvView.registerCellWithNib(nib: UINib(nibName: "AccountBankTableViewCell", bundle: nil), idCell: "cell")
        //tbvView.registerCellWithNib(nib: UINib(nibName: "profileTableViewCell", bundle: nil), idCell: "cell")
        tbvView.hideSpactorCellVarible = true
        tbvView.heightOfCell = 80
        tbvView.heightForHeaderInSection = 16
        tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountBankTableViewCell
            return cell
        }
        tbvView.didSelectedRowClosure = {[weak self] tbv, indexPath in
            print(indexPath.section)
            switch indexPath.section {
            case 0:
                let editAccountBankViewVC = EditAccountBankViewController()
                self?.pushToViewController(editAccountBankViewVC, true)
                break
            default:
                break
            }
        }
    }



}
