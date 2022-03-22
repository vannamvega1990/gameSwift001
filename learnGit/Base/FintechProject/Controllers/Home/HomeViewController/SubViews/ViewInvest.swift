//
//  ViewInvest.swift
//  FinTech
//
//  Created by Tu Dao on 5/13/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class ViewInvest: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var percen: UILabel!
    @IBInspectable var settitle:String = "" {
        didSet{
            title.text = settitle
        }
    }
    @IBInspectable var hideIcon:Bool = false {
        didSet{
            icon.isHidden = hideIcon
        }
    }
    @IBInspectable var hidePercen:Bool = false {
        didSet{
            percen.isHidden = hidePercen
        }
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
        guard let view = self.FTloadViewFromNib(nibName: "ViewInvest") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }

}
