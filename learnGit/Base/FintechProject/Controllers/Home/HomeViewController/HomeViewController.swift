//
//  HomeViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/13/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var ccqView: CCQView!
    
    init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenNavigation(isHidden: true)
        navigationController?.navigationBar.isHidden = true
        ccqView.tbvView.numberOfSections = 3
        ccqView.tbvView.numberRow = 1
        ccqView.tbvView.backgroundColor = UIColor.white
        ccqView.tbvView.registerCellWithNib(nib: UINib(nibName: "CCQTableViewCell", bundle: nil), idCell: "cell")
        ccqView.tbvView.hideSpactorCellVarible = true
        ccqView.tbvView.heightOfCell = 80
        ccqView.tbvView.heightForHeaderInSection = 6
        ccqView.tbvView.CreateCellClorsure = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CCQTableViewCell
            
            return cell
        }
    }



}
