//
//  EXBaseCLVHorizontalVC2.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/14/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class EXBaseCLVHorizontalVC2: UIViewController {
    
    init() {
        super.init(nibName: "EXBaseCLVHorizontalVC2", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = BaseColectionViewHorizontal()
        test.frame = CGRect(x: 16, y: 196, width: 378, height: 196)
        test.widthCell = 46
        test.heightCell = 46
        test.nameArray = ["1","2","3"]
        addSubViews([test])
        test.nibCell = UINib(nibName: "EXBaseCLVCell", bundle: nil)
        test.collectionView.CreateCellClorsure = {
            [weak self ] clv,index in
            guard let selfWeak = self else {
                return UICollectionViewCell()
            }
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! EXBaseCLVCell
            return cell
        }
        
    }


}
