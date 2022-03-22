//
//  BaseColectionViewHorizontal.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

@IBDesignable
class BaseColectionViewHorizontal: BaseView {
    
    var nameArray1: [String] = ["Vang", "Tichluy" , "Bat dong san", "kinh doanh", "chuwng khoan"]
    var nameArray: [Any] = []
    var nibCell: UINib?
    @IBInspectable var widthCell: CGFloat = 196
    @IBInspectable var heightCell: CGFloat = 196
    
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
        
        if let nibCell = nibCell {
            collectionView.registerCellWithNib(nib:nibCell, idCell:"cell")
        }else{
            self.collectionView.collectionView.register(cellBasePageTab.self, forCellWithReuseIdentifier: "cell")
        }
        //
        
        
        //collectionView.c.registerCellWithClass(ImageCell1: cellBasePageTab.self, idCell: "cell")
        
        
//        collectionView.CreateCellClorsure = {
//            [weak self ] clv,index in
//            guard let selfWeak = self else {
//                return UICollectionViewCell()
//            }
//
//
//            if selfWeak.nibCell != nil  {
//                let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! cellBasePageTab
//                cell.index = index
//                cell.clv = selfWeak.collectionView
//                cell.isHighlighted = true
//                if selfWeak.oldColor == nil {
//                    selfWeak.oldColor = cell.label.backgroundColor
//                }
//                //cell.backgroundColor = .red
//                cell.colorWhenHeightlight = .red
//                cell.fontLabel = selfWeak.fontLabel
//                cell.label.text = selfWeak.nameArray[index.item]
//                cell.actionTouch = {
//                    indexpath, clv in
//                    guard let indexpath = indexpath else { return  }
//                    print(indexpath.item)
//
//                    //let rect = clv.layoutAttributesForItem(at:IndexPath(row: indexpath.item, section: 0))
//                    cell.label.backgroundColor = .red
//                    selfWeak.cellSelected?.label.backgroundColor = selfWeak.oldColor
//                    selfWeak.cellSelected = cell
//                    print("self.indexSelected: \(selfWeak.indexSelected)")
//                    var rect = clv?.collectionView.layoutAttributesForItem(at:indexpath)?.frame
//                    if indexpath.item == 0 && selfWeak.indexSelected > 0 {
//                        rect?.origin.x = 0
//                    }else{
//                        if indexpath.item > selfWeak.indexSelected {
//                            rect?.origin.x += (selfWeak.size1.width - cell.bounds.width )/2//self.size1.width/4
//                        }else if indexpath.item < selfWeak.indexSelected {
//                            rect?.origin.x -= (selfWeak.size1.width - cell.bounds.width )/2 //self.size1.width/4
//                        }else{
//
//                        }
//                    }
//
//                    clv?.collectionView.scrollRectToVisible(rect!, animated: true)
//                    selfWeak.indexSelected = indexpath.item
//
//                }
//                return cell
//            }else{
//                let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index)
//                return cell
//            }
//
//        }
        
        
        collectionView.setFollowLayout(followLayout: ArabicCollectionFlow(size: CGSize(width: widthCell, height: heightCell)))
        collectionView.heightForCellClorsure = {
            [weak self ]clv,index in
            guard let selfWeak = self else {
                return .zero
            }
            
            let sizeCell = CGSize(width:selfWeak.widthCell, height: selfWeak.heightCell)
            return sizeCell
        }

        collectionView.setDelegateDatasource()
    }
}
