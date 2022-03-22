//
//  BaseCollectionViewCell.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseCollectionViewCell: UICollectionViewCell {
    
    var enableHeighlight = false
    //var actionWhenClick:(()->Void)?
    var actionTouch: ((IndexPath?,BaseCollectionView?) -> Void)?
    var clv: BaseCollectionView?
    var colorWhenHeightlight: UIColor? = UIColor.lightGray.withAlphaComponent(0.3)
    var index: IndexPath?
    var delay = 0.1
    @IBInspectable var cellCornerRds: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cellCornerRds
            //clipsToBounds = true
        }
    }
    var oldColor: UIColor? = UIColor()
    override func layoutSubviews() {
        super.layoutSubviews()
        oldColor = contentView.backgroundColor
    }
    private func changeColor(complite: @escaping ()->Void ){
        contentView.backgroundColor = colorWhenHeightlight
        complite()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enableHeighlight {
            contentView.backgroundColor = colorWhenHeightlight
            //sleep(1)
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if enableHeighlight {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { self.contentView.backgroundColor = self.oldColor
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.enableHeighlight {
                self.contentView.backgroundColor = self.oldColor
            }
            self.actionTouch?(self.index,self.clv)
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if enableHeighlight {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { self.contentView.backgroundColor = self.oldColor
            }
        }
    }
}
