//
//  TPBaseTextField.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/6/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPBaseTextField: FTBaseTextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setColorForPlaceHolder(color: UIColor.white.withAlphaComponent(0.6))
        borderColorWhenEdit = UIColor(rgb: 0xE98117, alpha: 1)
    }
    
    override func editingDidBegin() {
        super.editingDidBegin()
        if let stack = (self.superview as? UIStackView), let v = stack.subviews.last{
            v.isHidden = true
        }
    }
    
    func addCustomTPToolBar(title: String,action: @escaping() -> ()) {
        //let toolBar = TPConfirmView()
        let toolBar = TPConfirmView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 81)))
        toolBar.setTitle(title: title)
        addCustomToolBar(toolBar)
        toolBar.btnNext.indexPath = IndexPath(row: 1, section: 1)
        toolBar.btnNext.actionClosure = { indexPath in
            //self.goNext(index: btnView.tag)
            action()
        }
    }
    
    func addCustomTPToolBar1(title: String,action: @escaping() -> ()) {
        //let toolBar = TPConfirmView()
        let toolBar = TPLissenView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 126)))
        toolBar.setTitle(title: title)
        addCustomToolBar(toolBar)
        toolBar.btnNext.indexPath = IndexPath(row: 1, section: 1)
        toolBar.btnNext.actionClosure = { indexPath in
            //self.goNext(index: btnView.tag)
            action()
        }
    }
}


extension UITextField {
    func addCustomTPToolBarAll(title: String,action: @escaping() -> ()) {
        //let toolBar = TPConfirmView()
        let toolBar = TPLissenView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 126)))
        toolBar.setTitle(title: title)
        addCustomToolBar(toolBar)
        toolBar.btnNext.indexPath = IndexPath(row: 1, section: 1)
        toolBar.btnNext.actionClosure = { indexPath in
            //self.goNext(index: btnView.tag)
            action()
        }
    }
}



