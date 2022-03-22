//
//  CollectionViewCell.swift
//  test001
//
//  Created by THONG TRAN on 20/03/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .green
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

