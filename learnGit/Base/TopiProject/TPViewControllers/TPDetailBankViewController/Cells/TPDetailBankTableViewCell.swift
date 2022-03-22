//
//  TPDetailBankTableViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/22/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPDetailBankTableViewCell: TitleAndSubTitleTableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        //        baseView.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
        //        title.textColor = UIColor(rgb: 0x919191, alpha: 1)
        //        subTitle.textColor = UIColor(rgb: 0xEAEAEC, alpha: 1)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
        title.textColor = UIColor(rgb: 0x919191, alpha: 1)
        subTitle.textColor = UIColor(rgb: 0xEAEAEC, alpha: 1)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //        baseView.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
        //        title.textColor = UIColor(rgb: 0x919191, alpha: 1)
        //        subTitle.textColor = UIColor(rgb: 0xEAEAEC, alpha: 1)
    }
}
