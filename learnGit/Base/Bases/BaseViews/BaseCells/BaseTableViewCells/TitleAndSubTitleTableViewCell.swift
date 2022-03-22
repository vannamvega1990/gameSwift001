//
//  TitleAndSubTitleTableViewCell.swift
//  VegaFintech
//
//  Created by Tu Dao on 7/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TitleAndSubTitleTableViewCell: BaseTableViewCell {

    @IBOutlet weak var baseView: FTBaseView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        enableHeighlight = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
