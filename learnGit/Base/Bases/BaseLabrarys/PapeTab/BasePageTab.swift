//
//  BasePageTab.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BasePageTab: BaseView {
    
    var nameArray: [String] = ["Vang", "Tichluy" , "Bat dong san", "kinh doanh", "chuwng khoan"]
    var fontLabel: UIFont = .systemFont(ofSize: 28)
    
    var size1:CGSize = .zero
    let collectionView = BaseCollectionView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cauhinh()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cauhinh()
    }
    
    private func cauhinh(){
        //self.collectionView.collectionView.register(cellBasePageTab.self, forCellWithReuseIdentifier: "reuseIdentifier")
    }
    
    override func layoutSubviews() {
        collectionView.frame = self.bounds
        size1 = self.bounds.size
        setupCollectionView()
        self.addSubview(collectionView)
    }

    class ArabicCollectionFlow: UICollectionViewFlowLayout {
        var sizeCell:CGSize = .zero
        init(size:CGSize) {
            super.init()
            self.sizeCell = size
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func prepare() {
            super.prepare()
            self.scrollDirection = .horizontal
            //self.itemSize = CGSize(width: 96, height: 76)
            //self.itemSize = sizeCell
        }
        override var flipsHorizontallyInOppositeLayoutDirection: Bool {
            return true
        }
    }
    var indexSelected: Int = 0
    var cellSelected: cellBasePageTab?
    var oldColor: UIColor?
    fileprivate func setupCollectionView() {
        collectionView.numberOfSections = 1
        collectionView.numberItemsInSection = nameArray.count
        collectionView.isPagingEnabled = false
        
        //let nibCell = UINib(nibName: "TPFaceImageCollectionViewCell", bundle: nil)
        //collectionView.registerCellWithNib(nib:nibCell, idCell:"cell")
        
        self.collectionView.collectionView.register(cellBasePageTab.self, forCellWithReuseIdentifier: "cell")
        //collectionView.c.registerCellWithClass(ImageCell1: cellBasePageTab.self, idCell: "cell")
        collectionView.CreateCellClorsure = {
            clv,index in
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! cellBasePageTab
            cell.index = index
            cell.clv = self.collectionView
            cell.isHighlighted = true
            if self.oldColor == nil {
                self.oldColor = cell.label.backgroundColor
            }
            //cell.backgroundColor = .red
            cell.colorWhenHeightlight = .red
            cell.fontLabel = self.fontLabel
            cell.label.text = self.nameArray[index.item]
            cell.actionTouch = {
                indexpath, clv in
                guard let indexpath = indexpath else { return  }
                print(indexpath.item)
                
                //let rect = clv.layoutAttributesForItem(at:IndexPath(row: indexpath.item, section: 0))
                cell.label.backgroundColor = .red
                self.cellSelected?.label.backgroundColor = self.oldColor
                self.cellSelected = cell
                print("self.indexSelected: \(self.indexSelected)")
                var rect = clv?.collectionView.layoutAttributesForItem(at:indexpath)?.frame
                if indexpath.item == 0 && self.indexSelected > 0 {
                    rect?.origin.x = 0
                }else{
                    if indexpath.item > self.indexSelected {
                        rect?.origin.x += (self.size1.width - cell.bounds.width )/2//self.size1.width/4
                    }else if indexpath.item < self.indexSelected {
                        rect?.origin.x -= (self.size1.width - cell.bounds.width )/2 //self.size1.width/4
                    }else{
                        
                    }
                }
                
                clv?.collectionView.scrollRectToVisible(rect!, animated: true)
                self.indexSelected = indexpath.item
                
            }
            return cell
        }
        collectionView.setFollowLayout(followLayout: ArabicCollectionFlow(size: CGSize(width: 98, height: size1.height)))
        collectionView.heightForCellClorsure = {
            clv,index in
            let sizeCell = CGSize(width: self.nameArray[index.item].widthOfString(usingFont: self.fontLabel) + 32, height: self.size1.height)
            return sizeCell
        }
//        collectionView.didSelectItemAt = {
//            clv,indexpath in
//            print(indexpath)
//            //self.collectionView.scroll(at: index, atPos: .centeredHorizontally, animated: true)
//            var rect = clv.layoutAttributesForItem(at:indexpath)?.frame
//            if indexpath.item > self.indexSelected {
//                rect?.origin.x += self.size1.width/4
//            }else if indexpath.item < self.indexSelected {
//                rect?.origin.x -= self.size1.width/4
//            }else{
//                
//            }
//            clv.scrollRectToVisible(rect!, animated: true)
//            self.indexSelected = indexpath.item
//            
//        }
        collectionView.setDelegateDatasource()
    }
}


class cellBasePageTab: BaseCollectionViewCell {
    //var index: IndexPath?
    //var clv: BaseCollectionView?
    var fontLabel: UIFont = .systemFont(ofSize: 8)
    //var actionTouch: ((IndexPath?,BaseCollectionView?) -> Void)?
    let label:UILabel = {
        let lb = UILabel()
        lb.text = "123"
        lb.textColor = .white
        lb.backgroundColor = UIColor(rgb: 0x289B3C)//UIColor(named: "CL#289B3C")
        return lb
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        label.font = fontLabel
        label.textAlignment = .center
        addSubview(label)
        label.setConstraintByCode(constraintArray: [
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -8),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -8),
            //label.widthAnchor.constraint(equalToConstant: label.text!.widthOfString(usingFont: label.font) + 16),
            //label.heightAnchor.constraint(equalToConstant: label.heightWrap + 6)
        ])
        label.layer.cornerRadius = (label.frame.height)/2
        label.layer.masksToBounds = true
        //label.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width, height: label.heightWrap))
        //label.center = center
        
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        actionTouch?(index,clv)
//    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}


