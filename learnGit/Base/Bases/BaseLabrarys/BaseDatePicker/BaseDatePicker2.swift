//
//  BaseDatePicker2.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

import UIKit

class BaseDatePicker2Test: BaseViewControllers {
    
    let tf = UITextField(frame: .zero)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundColor()
        //CGRect(x: 0, y: 90, width: sizeScreen.width, height: 90)
        tf.backgroundColor = .red
        addSubViews([tf])
        showDatePickerForUITextfild2(tfDatePicker: tf)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tf.becomeFirstResponder()
    }
    
}



extension BaseViewControllers {
    
    @objc func donedatePicker2(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //print(formatter.string(from: (self.datePickerCustom! as! BaseDatePicker2).valueMonth ))
        print("----------------")
        //print((self.datePickerCustom! as! BaseDatePicker2).valueMonth)
        //print((self.datePickerCustom! as! BaseDatePicker2).valueYear)
        //txtDatePicker.text = formatter.string(from: datePicker.date)
        let moth = (self.datePickerCustom! as! BaseDatePicker2).valueMonth ?? curentMonth
        let year = (self.datePickerCustom! as! BaseDatePicker2).valueYear ?? curentYear
        let stringDate = "\(moth)/\(year)"
        print("----------------\(stringDate)")
        self.view.endEditing(true)
    }

    func showDatePickerForUITextfild2(tfDatePicker: UITextField){
        //let datePicker = datePicker1
        let datePicker = BaseDatePicker2()
        self.datePickerCustom = datePicker
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker2));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        datePicker.frame = CGRect(origin: CGPoint(x: 16, y: 156), size: CGSize(width: sizeScreen.width, height: 356))
        let row1 = datePicker.minutes1.firstIndex(of: curentMonth) ?? 0
        let row2 = datePicker.seconds1.firstIndex(of: curentYear) ?? 0
        //if let index = arrayTrumpViewPop.firstIndex(of: viewPop)
        

        //tfDatePicker1 = tfDatePicker
        
        tfDatePicker.inputAccessoryView = toolbar
        tfDatePicker.inputView = datePicker
        tfDatePicker.becomeFirstResponder()
        datePicker.setRow(row: row1, inComponent: 0)
        datePicker.setRow(row: row2, inComponent: 1)
        
        //myPicker.selectRow(row, inComponent: 0, animated: true)
    }
}


class BaseDatePicker2: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let minutes1 = Array(01...12)
    //let seconds1 = Array(2008...2090)
    
    let seconds1 = Array(curentYear-120...curentYear+120)
    
    var valueMonth: Int?
    var valueYear: Int?
    let picker = UIPickerView()
    
//    var minutes: [String] = [String]()
//    var seconds : [String] = [String]()
    
    let minutes = Array(1...12).map { (inVal) -> String in
        return "Tháng \(inVal)"
    }
    //let curentYear = Int(dateGlobal.yearCurrent)!
    let seconds = Array(curentYear-120...curentYear+120).map { (inVal) -> String in
        return "\(inVal)"
    }
    
    func setRow(row: Int, inComponent: Int){
        picker.selectRow(row, inComponent: inComponent, animated: true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return minutes.count
        }
        
        else {
            return seconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(minutes[row])
        } else {
            return String(seconds[row])
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component==0{
            var row = pickerView.selectedRow(inComponent: 0)
            print("this is the pickerView\(row): " + String(minutes[row]))
            valueMonth = minutes1[row]
        }else{
            var row = pickerView.selectedRow(inComponent: 1)
            print("this is the pickerView\(row): " + String(seconds[row]))
            valueYear = seconds1[row]
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(dateGlobal.monthCurrent)
        print(dateGlobal.yearCurrent)
        picker.backgroundColor = .lightGray
        //picker.frame = CGRect(x: 0, y: 90, width: sizeScreen.width, height: 390)
        picker.frame = bounds
        addSubview(picker)
        
        
        
        picker.delegate = self
        picker.dataSource = self
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        setBackgroundColor()
//        let picker = UIPickerView()
//        picker.backgroundColor = .lightGray
//        picker.frame = CGRect(x: 0, y: 90, width: sizeScreen.width, height: 390)
//        addSubViews([picker])
//        picker.delegate = self
//        picker.dataSource = self
//    }
    
    
    
    
    
    
}



