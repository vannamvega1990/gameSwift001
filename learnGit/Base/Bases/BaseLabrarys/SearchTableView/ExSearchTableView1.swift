//
//  ExSearchTableView1.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/28/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class ExSearchTableView1: TPBaseViewController {
    
    override func cellShowListPopupPressed(indexpath: IndexPath) {
        
        let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
        hidePopupWithAnimTrump(typeAnimation: anim) {
            print(indexpath)
        }
    }
    
    let textFild1 = UITextField()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundColor()
        textFild1.frame = CGRect(x: 16, y: 16, width: 198, height: 46)
        textFild1.placeholder = "noi dung"
        view.addSubview(textFild1)
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        btn.frame = CGRect(x: 189, y: 196, width: 98, height: 46)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
    }
    @objc func editingChanged(){
        filteredData = textFild1.text!.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: textFild1.text!, options: .caseInsensitive) != nil
        })
        print(filteredData.count)
        tbv.numberOfSections = filteredData.count
        tbv.reload()
    }
    let data = ["noidung","noidung2", "kinhte"]
    var filteredData:[String] = []
    
    var tbv: FTBaseTableView!
    @objc func xuly(){
        let v = BaseView()
        v.backgroundColor = .green
        //showPopupTrumpCenter(viewWantPop: v, lef: 16, right: 16, height: 190)
        //showPopupTrumpAnyPosition(viewWantPop: v, top: 12, lef: 16, right: 16, height: 378)
        let nib = UINib(nibName: "TitleAndTitleTableViewCell", bundle: nil)
        let CreateCellClorsure1:((UITableView,IndexPath)->BaseTableViewCell)? = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleAndTitleTableViewCell
            cell.actionWhenClick = {
                self.cellShowListPopupPressed(indexpath: indexPath)
            }
            return cell
        }
        
        textFild1.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        filteredData = data
        tbv = self.showPopupTrumpList(dataArrayName: filteredData, topConstraint: 120, left: 0, right: 0, height: 376, customNibCell:nib, CreateCellClorsure: CreateCellClorsure1)
        textFild1.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let v = BaseView()
            v.backgroundColor = .yellow
            //self.showPopupTrumpBottom(viewWantPop: v, lef: 0, right: 0, height: 390)
            //self.showPopupTrumpList(dataArrayName:["1","2", "3"])
            //self.showPopupTrumpCenter(viewWantPop: v, lef: 16, right: 16, height: 390)
        }
    }
   
}
