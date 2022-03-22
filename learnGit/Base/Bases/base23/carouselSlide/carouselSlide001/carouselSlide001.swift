//
//  carouselSlide001.swift
//  test001
//
//  Created by THONG TRAN on 20/03/2022.
//

import UIKit

class carouselSlide001: UICollectionViewController {

    let collectionDataSource = CollectionDataSource()
    let flowLayout = ZoomAndSnapFlowLayout()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout.init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Zoomed & snapped cells"

        guard let collectionView = collectionView else { fatalError() }
        //collectionView.decelerationRate = .fast // uncomment if necessary
        collectionView.dataSource = collectionDataSource
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

}
