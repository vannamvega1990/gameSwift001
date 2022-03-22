//
//  BaseTextFieldWithLabel.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit



@IBDesignable
class BaseTextFieldWithLabel: BaseTextField {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
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
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        superview?.layer.borderWidth = 1
        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
    }
    
    override func editingDidBegin() {
        superview?.superview?.layer.borderWidth = 1
        superview?.superview?.layer.borderColor = colorGood.cgColor
    }
    
    override func editingDidEnd() {
        superview?.layer.borderWidth = 1
        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
    }
}


