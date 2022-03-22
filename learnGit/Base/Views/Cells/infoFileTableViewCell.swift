//
//  infoFileTableViewCell.swift
//  Download98
//
//  Created by Eric Petter on 3/2/21.
//  Copyright © 2021 petter. All rights reserved.
//

import UIKit

class infoFileTableViewCell: UITableViewCell {

    @IBOutlet weak var nameFile: UILabel!
    @IBOutlet weak var dungluongFile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
