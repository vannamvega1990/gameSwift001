//
//  BaseTableViewCanEdit.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseTableViewCanEdit: UITableViewController {
    
    var CreateCellClorsure:((UITableView,IndexPath)->UITableViewCell)?
    var heightOfCell:CGFloat = 0
    var heightForHeaderInSection:CGFloat?
    var heightForFooter:CGFloat?
    var heightForCellClorsure:((UITableView,IndexPath)->CGFloat)?
    var numberRow:Int?
    var numberOfSections:Int?
    
    var enableEditCell: Bool = true
    var enableEditCell1: Bool = false
    
    var onOffEditing:Bool = true {
        didSet{
            tableView.isEditing = onOffEditing
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.tableView.sectionHeaderHeight = 70
//        let viewHeader = FTBaseHeaderView(frame: CGRect(x: 0, y: 0, width: sizeScreen.width, height: 68))
//        viewHeader.backgroundColor = .red
//        self.view.addSubview(viewHeader)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideSpactorCell()
    }
    @IBInspectable
    var hideSpactorCellVarible: Bool = false {
        didSet{
            tableView.separatorStyle = hideSpactorCellVarible ? .none : .singleLine
        }
    }
    
    // register cell ---------------------------
    func registerCellWithNib(nib:UINib, idCell:String){
        tableView.register(nib, forCellReuseIdentifier: idCell)
    }
    // delegate datasure -------------------
    func setupDelegateDatasoucre(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    // hide spactor cell -----------------------
    func hideSpactorCell(){
        tableView.separatorStyle = .none
    }
    
    // init ---------------------------
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberRow ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooter ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = BaseView(frame: CGRect(x: 0, y: 0, width: 567, height: 1.8))
        v.createDashLine(color: .orange)
        //v.backgroundColor = .lightGray
        return v
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CreateCellClorsure?(tableView, indexPath)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellClorsure?(tableView, indexPath) ?? heightOfCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        if tableView.isEditing {
//            //return true
//            return true
//        }
//        return false
        return true
    }
    
    var actionEditRowArray: [UITableViewRowAction]?
    var editRowAt: IndexPath?
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        
        editRowAt = editActionsForRowAt
        
        if let actionEditRowArray = actionEditRowArray {
            return actionEditRowArray
        }else{
            let more = UITableViewRowAction(style: .normal, title: "Rename") { action, index in
                print("more button tapped")
    
            }
            more.backgroundColor = .lightGray
    
            let favorite = UITableViewRowAction(style: .normal, title: "More") { action, index in
                print("favorite button tapped")
            }
            favorite.backgroundColor = .red
    
            let share = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
                print("share button tapped")
    
                //self.deleteSections(tableView, editActionsForRowAt: editActionsForRowAt)
                tableView.deleteSectionsCustom(editActionsForRowAt: index, completion: {
                    
                })
            }
            share.backgroundColor = .red

            return [share, favorite, more]
        }
    }
    
//    func deleteSections(_ tableView: UITableView, editActionsForRowAt: IndexPath){
//        self.numberOfSections = self.numberOfSections! - 1
//        let indexSet = IndexSet(arrayLiteral: editActionsForRowAt.section)
//        tableView.deleteSections(indexSet, with: .fade)
//    }
    
    func deleteRow(_ tableView: UITableView, editActionsForRowAt: IndexPath){
        self.numberRow = self.numberRow! - 1
        tableView.deleteRows(at: [editActionsForRowAt], with: UITableView.RowAnimation.fade)
    }
    
    
    
}


