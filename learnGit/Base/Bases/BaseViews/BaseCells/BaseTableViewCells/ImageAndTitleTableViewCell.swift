//
//  ImageAndTitleTableViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/28/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class ImageAndTitleTableViewCell: BaseTableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
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
