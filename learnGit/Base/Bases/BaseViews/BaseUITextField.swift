//
//  BaseTextField.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

var currentUITextfild = BaseTextField()

@IBDesignable
class BaseTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var isSecurity: Bool {
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
    override func layoutSubviews() {
        super.layoutSubviews()
        autocorrectionType = .no
        if #available(iOS 12, *) {
            // iOS 12 & 13: Not the best solution, but it works.
            textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            // For more information see the explanation below.
            textContentType = .init(rawValue: "")
            textContentType = .init(rawValue: "")
        }
        //addToolBar()
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    func setColorForPlaceHolder(color: UIColor){
        attributedPlaceholder =
        NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func actionWhenDidBeginEditing(){
        currentUITextfild = self
        borderColor = borderColorWhenEdit
    }
    
    @objc func editingDidBegin(){
        actionWhenDidBeginEditing()
    }
    
    @objc func editingDidEnd(){
        borderColor = oldBorderColor
    }

    func addCustomBasicToolBar(title: String) {
        AppDelegate.disableIQKeyboard()
        let toolBar = ToolbarForUITextfild(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 81)))
        toolBar.setTitle(content: title)
        addCustomToolBar(toolBar)
        
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


extension UIViewController {
//    func addCustomToolBarForUITextfild(arrTextFild:[BaseTextField]){
//        AppDelegate.disableIQKeyboard()
//        for (key, each) in arrTextFild.enumerated() {
//            let nd = each.placeholder ?? ""
//            each.tag = key
//            let toolBar = ToolbarForUITextfild(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 56)))
//            toolBar.setTitle(content: nd)
//            toolBar.actionFinish = {
//                self.view.endEditing(true)
//            }
//            toolBar.actionDown = {
//                if (each.tag + 1) < arrTextFild.count {
//                    arrTextFild[each.tag + 1].becomeFirstResponder()
//                }
//            }
//            toolBar.actionUp = {
//                if (each.tag - 1) >= 0 {
//                    arrTextFild[each.tag - 1].becomeFirstResponder()
//                }
//            }
//            each.addCustomToolBar(toolBar)
//        }
//    }
}




