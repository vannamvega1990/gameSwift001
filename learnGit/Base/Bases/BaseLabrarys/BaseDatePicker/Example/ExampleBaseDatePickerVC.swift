//
//  ExampleBaseDatePickerVC.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit


class ExampleBaseDatePickerVC: BaseViewControllers {
    override func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        print(formatter.string(from: self.datePicker!.date))
        txtDatePicker.text = formatter.string(from: self.datePicker!.date)
        self.view.endEditing(true)
        
    }
    
    let txtDatePicker = UITextField()
    //let datePicker = UIDatePicker()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //showDatePicker()
        
        txtDatePicker.frame = CGRect(x: 16, y: 156, width: 367, height: 98)
        txtDatePicker.placeholder = "ngay tháng"
        view.addSubview(txtDatePicker)
        showDatePickerForUITextfild(tfDatePicker: txtDatePicker)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //showDatePicker()
    }
 
}

