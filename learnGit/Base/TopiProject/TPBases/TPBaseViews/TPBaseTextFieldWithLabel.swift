//
//  TPBaseTextFieldWithLabel.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/27/21.
//  Copyright © 2021 Vega. All rights reserved.

import UIKit

@IBDesignable
class TPBaseTextFieldWithLabel: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var isSecurity: Bool  {
        set {
            isSecureTextEntry = newValue
        }
        get{
            return isSecureTextEntry
        }
    }
    @IBInspectable var leftInsect: CGFloat = 0
    @IBInspectable var rightInsect: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            if firstInit {
                oldBorderColor = borderColor
                firstInit = false
            }
            
        }
    }
    var oldBorderColor: UIColor = .lightGray
    var borderColorWhenEdit: UIColor = .green
    var firstInit: Bool = true
    
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
    
    func addCustomTPToolBar2(title: String,action: @escaping() -> ()) {
        //let toolBar = TPConfirmView()
        let toolBar = TPLissenView(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 81)))
        toolBar.setTitle(title: title)
        addCustomToolBar(toolBar)
        toolBar.btnNext.indexPath = IndexPath(row: 1, section: 1)
        toolBar.btnNext.actionClosure = { indexPath in
            //self.goNext(index: btnView.tag)
            action()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        autocorrectionType = .no
        
//        superview?.layer.borderWidth = 1
//        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
//        (superview?.subviews.first as! UILabel).textColor = colorWhitePlaceholder
        
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func setColorForPlaceHolder(color: UIColor){
        attributedPlaceholder =
        NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func showError(sms: String){
        ((superview as! UIStackView).superview as! FTBaseView).borderColor = .red
        superview?.superview?.superview?.subviews.last?.isHidden = false
        if let stack = superview?.superview?.superview?.subviews.last?.subviews.first as? UIStackView, let lable = stack.subviews.last as? UILabel {
            lable.text = sms
        }
    }
    
    @objc func editingDidBegin(){
        print("----------")
        superview?.superview?.layer.borderWidth = 1
        ((superview as! UIStackView).superview as! FTBaseView).borderColor = colorGood
        //superview?.superview?.layer.borderColor = colorGood.cgColor
        (superview?.subviews.first as! UILabel).textColor = colorGood
        if let stackV = superview?.superview?.superview as? UIStackView {
            stackV.subviews.last?.isHidden = true
        }
    }
    
    @objc func editingDidEnd(){
        superview?.layer.borderWidth = 1
        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
        (superview?.subviews.first as! UILabel).textColor = colorWhitePlaceholder
        superview?.superview?.superview?.subviews.last?.isHidden = true
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftInsect, bottom: 0, right: rightInsect)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftInsect, bottom: 0, right: rightInsect)
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftInsect, bottom: 0, right: rightInsect)
        return bounds.inset(by: padding)
    }
    var numberToolbar:UIToolbar = UIToolbar()
    var addItem:[UIBarButtonItem] = [UIBarButtonItem]()
    var nextItemAction:(()->())?
    func addToolBar(){
        numberToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:50))
        numberToolbar.barStyle = UIBarStyle.default
        numberToolbar.items = [
            UIBarButtonItem(title: ">", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelNumberPad)),
            UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelNumberPad))]
        //numberToolbar.items = addItem
        numberToolbar.sizeToFit()
        inputAccessoryView = numberToolbar
    }
    @objc func cancelNumberPad(){
        if let vc = UIApplication.getPresentedViewController() {
            vc.view.endEditing(true)
        }
    }
    @objc func nextNumberPad(){
        nextItemAction?()
    }
}



//@IBDesignable
//class TPBaseTextFieldWithLabel1: BaseTextField {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//    }
//
//
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        superview?.layer.borderWidth = 1
//        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
//    }
//
//    override func actionWhenDidBeginEditing() {
//        superview?.superview?.layer.borderWidth = 1
//        superview?.superview?.layer.borderColor = colorGood.cgColor
//        (superview?.subviews.first as! UILabel).textColor = colorGood
//    }
//
//    override func editingDidEnd() {
//        superview?.layer.borderWidth = 1
//        superview?.superview?.layer.borderColor = colorWhitePlaceholder.cgColor
//        (superview?.subviews.first as! UILabel).textColor = colorWhitePlaceholder
//    }
//}


