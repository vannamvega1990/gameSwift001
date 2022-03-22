//
//  colorTableViewCell.swift
//  Download98
//
//  Created by Eric Petter on 3/5/21.
//  Copyright © 2021 petter. All rights reserved.
//

import UIKit

class colorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var namecolor: UILabel!
    @IBOutlet weak var viewcolor: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
