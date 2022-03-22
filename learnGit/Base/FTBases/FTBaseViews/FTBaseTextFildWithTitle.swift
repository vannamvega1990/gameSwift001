//
//  FTBaseTextFildWithTitle.swift
//  FinTech
//
//  Created by Tu Dao on 5/6/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseTextFildWithTitle: UIView {
    
    var defultHeightTField: CGFloat = 60
    
    @IBOutlet var textfield:FTBaseTextField!
    @IBOutlet var title:UILabel!
    @IBOutlet var stackView:UIStackView!
    @IBOutlet var heightOfTextfield:NSLayoutConstraint!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "FTBaseTextFildWithTitle") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }
    
    @IBInspectable var leftInsect: CGFloat = 0
    @IBInspectable var rightInsect: CGFloat = 0
    @IBInspectable var heightUITextfield: CGFloat{
        set{
            //heightOfTextfield.constant = newValue
        }
        get{
            return 123//heightOfTextfield.constant
        }
    }
    
    @IBInspectable var spaceValue: CGFloat{
        set{
            stackView.spacing = newValue
        }
        get{
            return stackView.spacing
        }
    }
    @IBInspectable var radius: CGFloat{
        set{
            textfield.borderStyle = .roundedRect
            textfield.clipsToBounds = true
            textfield.layer.cornerRadius = newValue
        }
        get{
            return textfield.layer.cornerRadius
        }
    }
    @IBInspectable var borderWidthTField: CGFloat{
        set{
            textfield.layer.borderWidth = newValue
        }
        get{
            return textfield.layer.borderWidth
        }
    }
    @IBInspectable var borderColorTField: UIColor{
        set{
            //textfield.layer.borderColor = newValue.cgColor
            textfield.borderColor = newValue
        }
        get{
            return UIColor.red
        }
    }
    @IBInspectable var backgroundOfTextfield: UIColor = .white{
        didSet{
            textfield.backgroundColor = backgroundOfTextfield
        }
    }
    @IBInspectable var titleName: String {
        set{
            title.text = newValue
        }
        get{
            return title.text!
        }
    }
    enum typeKeyboard {
        case numberPad
        case nomal
    }
    @IBInspectable var isSecurity: Bool = false {
        didSet {
            textfield.isSecureTextEntry = isSecurity
        }
    }
    @IBInspectable var isNumberPad: Bool = false {
        didSet {
            textfield.keyboardType = isNumberPad ? .numberPad : .default
        }
    }
    @IBInspectable var isTypeEmail: Bool = false {
        didSet {
            textfield.keyboardType = isTypeEmail ? .default : .default
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textfield.setLeftPaddingPoints(leftInsect)
        textfield.setRightPaddingPoints(rightInsect)
        textfield.placeholder = titleName //"123"
        textfield.delegate = self
    }
    override func didAddSubview(_ subview: UIView) {
        //textfield.placeholder = titleName //"123"
        
    }
}

extension FTBaseTextFildWithTitle: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      //textField.resignFirstResponder()
        return true
    }
}

