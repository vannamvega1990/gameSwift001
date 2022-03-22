//
//  InfoTableViewCell.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 03/02/2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    @IBOutlet weak var naView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
