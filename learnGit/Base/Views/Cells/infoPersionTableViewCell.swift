//
//  ProfileTableViewCell1.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class infoPersionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var baseInfoView: FTBaseInfoView!
    
    func setTitle(name: String){
        baseInfoView.setTitle(name: name)
    }
    
    func setTextField(name: String){
        baseInfoView.setTextField(name: name)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let mainString = baseInfoView.title.text ?? ""
        let stringToColor = "*"
        let range = (mainString as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        baseInfoView.title.attributedText = mutableAttributedString
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
