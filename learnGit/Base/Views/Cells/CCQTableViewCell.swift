//
//  CCQTableViewCell.swift
//  FinTech
//
//  Created by Tu Dao on 5/13/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class CCQTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //baseView.backgroundColor = .lightGray
        backgroundColor = .lightGray
        //baseView.backgroundColor = .red
        print("123")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //backgroundColor = .clear
        backgroundColor = .white
    }
    
}
