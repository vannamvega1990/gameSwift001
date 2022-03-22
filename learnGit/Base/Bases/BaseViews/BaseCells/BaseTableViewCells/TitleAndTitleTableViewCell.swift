//
//  TitleAndTitleTableViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/24/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TitleAndTitleTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        enableHeighlight = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
