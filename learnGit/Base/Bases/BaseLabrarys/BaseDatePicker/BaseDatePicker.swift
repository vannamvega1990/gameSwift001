//
//  BaseDatePicker.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit


extension BaseViewControllers {

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        print(formatter.string(from: self.datePicker!.date))
        //txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func showDatePickerForUITextfild(tfDatePicker: UITextField){
        //let datePicker = datePicker1
        let datePicker = UIDatePicker()
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datePicker.frame = CGRect(origin: CGPoint(x: 16, y: 156), size: CGSize(width: sizeScreen.width, height: 356))
        //datePicker.backgroundColor = .red
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            //datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.datePicker = datePicker
        //tfDatePicker1 = tfDatePicker
        
        tfDatePicker.inputAccessoryView = toolbar
        tfDatePicker.inputView = datePicker
    }
}

