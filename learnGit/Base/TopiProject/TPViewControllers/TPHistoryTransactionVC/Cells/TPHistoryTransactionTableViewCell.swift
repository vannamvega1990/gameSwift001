//
//  TPHistoryTransactionTableViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/23/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPHistoryTransactionTableViewCell: BaseTableViewCell {

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var state: UILabel!
    
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
