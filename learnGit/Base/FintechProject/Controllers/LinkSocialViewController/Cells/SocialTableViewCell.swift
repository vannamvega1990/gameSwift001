//
//  SocialTableViewCell.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {
   
    var SocialId: String?
    var SocialType: Int?
    var SocialTypeSub: String?
    var SocialEmailOrMobile: String?
    var SocialName: String?
    
    @IBOutlet weak var labelSocialId: UILabel!
    @IBOutlet weak var labelSocialType: UILabel!
    @IBOutlet weak var labelSocialTypeSub: UILabel!
    @IBOutlet weak var labelSocialEmailOrMobile: UILabel!
    @IBOutlet weak var labelSocialName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}

