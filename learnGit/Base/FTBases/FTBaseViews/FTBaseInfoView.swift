//
//  FTBaseInfoView1.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseInfoView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func setTitle(name: String){
        title.text = name
    }
    
    func setTextField(name: String){
        textField.text = name
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "FTBaseInfoView") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        print("123")
    }
    
}
