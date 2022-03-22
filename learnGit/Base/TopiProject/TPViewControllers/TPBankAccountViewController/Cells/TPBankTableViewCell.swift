//
//  TPBankTableViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPBankTableViewCell: BaseTableViewCell {

    @IBOutlet weak var nameBank: UILabel!
    @IBOutlet weak var numberBank: UILabel!
    @IBOutlet weak var logoBank: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        enableHeighlight = true
        //colorWhenHeightlight = .red
        colorWhenHeightlight = UIColor.white.withAlphaComponent(0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
