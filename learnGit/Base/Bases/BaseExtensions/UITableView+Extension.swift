//
//  UITableView+Extension.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

extension UITableView {
    
    // delete sections in tableview -----------------
    func deleteSectionsCustom(editActionsForRowAt: IndexPath, ani: UITableView.RowAnimation = .fade, completion: @escaping (() -> Void)){
        let indexSet = IndexSet(arrayLiteral: editActionsForRowAt.section)
        deleteSections(indexSet, with: ani)
        completion()
        
    }
    // delete cell in tableview -----------------
    func deleteRowsCustom(rows: [IndexPath], ani: UITableView.RowAnimation = .fade){
        deleteRows(at: rows, with: ani)
    }
    
    // add cell in tableview -----------------
    func addRowsCustom(rows: [IndexPath], ani: UITableView.RowAnimation = .fade){
        insertRows(at: rows, with: ani)
    }
    
    // add sections in tableview -----------------
    func addSectionsCustom(editActionsForRowAt: IndexPath, ani: UITableView.RowAnimation = .fade){
        let indexSet = IndexSet(arrayLiteral: editActionsForRowAt.section)
        insertSections(indexSet, with: ani)
    }
    
    // disable Heighlight Cell -----------------
    func disableHeighlightCell(){
        allowsSelection = false
    }
    
    // disable Heighlight Cell 2 -----------------
    func disableHeighlightCell2(index: IndexPath, animated: Bool){
        deselectRow(at: index, animated: animated)
    }
    
    // resize height ---------
    func resizeHeight(){
        reloadData()
        heightConstraint?.constant = contentSize.height
        layoutIfNeeded()
        //tbvView.tbv.reloadData()
        //heightTbvContraint.constant = tbvView.tbv.contentSize.height
        //tbvView.tbv.layoutIfNeeded()
        //tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    // enable Heighlight Cell -----------------
    func enableHeighlightCell(){
        allowsSelection = true
    }
    
    // disable scroll --------------------
    func disableScroll(){
        isScrollEnabled = false
    }
    
    // enable scroll --------------------
    func enableScroll(){
        isScrollEnabled = true
    }
    
   
}
