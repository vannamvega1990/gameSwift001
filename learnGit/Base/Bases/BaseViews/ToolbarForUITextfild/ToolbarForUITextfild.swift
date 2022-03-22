//
//  ToolbarForUITextfild.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/27/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class ToolbarForUITextfild: BaseView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ic_up: BaseUIImageView!
    @IBOutlet weak var ic_down: BaseUIImageView!
    @IBOutlet weak var btn_down: BaseButton!
    @IBOutlet weak var btn_up: BaseButton!
    var key:Int = 0
    var max:Int = 0
    
    var actionDown:(()->Void)?
    var actionUp:(()->Void)?
    var actionFinish:(()->Void)?
    
    func setTitle(content: String){
        title.text = content
    }
    @IBAction func btnDownPressed(_ sender: UIButton) {
        ic_down.setTintColor = key == max ? UIColor.lightGray : UIColor.systemBlue
        actionDown?()
    }
    @IBAction func btnUpPressed(_ sender: UIButton) {
        //ic_up.setTintColor = UIColor.systemBlue
        ic_up.setTintColor = key == 0 ? UIColor.lightGray : UIColor.systemBlue
        actionUp?()
    }
    @IBAction func btnFinish(_ sender: UIButton) {
        actionFinish?()
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        cauhinh()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    
    @objc func changeColor(_ sender: BaseButton){
        if sender == btn_up {
            ic_up.setTintColor = UIColor.lightGray
        }else{
            ic_down.setTintColor = UIColor.lightGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn_down.addTarget(self, action: #selector(changeColor(_:)), for: .touchDown)
        btn_up.addTarget(self, action: #selector(changeColor(_:)), for: .touchDown)
    }

    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "ToolbarForUITextfild") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
       
    }
}
