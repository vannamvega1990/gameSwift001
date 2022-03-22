//
//  BaseCollectionView.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/11/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class BaseCollectionView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var numberItemsInSection:Int?
    var numberOfSections:Int?
    var CreateCellClorsure:((UICollectionView,IndexPath)->UICollectionViewCell)?
    var heightForCellClorsure:((UICollectionView,IndexPath)->CGSize)?
    var didSelectItemAt:((UICollectionView,IndexPath)->Void)?
    
    var isPagingEnabled: Bool = true {
        didSet{
            collectionView.isPagingEnabled = isPagingEnabled
        }
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        cauhinh()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        cauhinh()
    }
    var rootView = UIView()
    private func cauhinh(){
        guard let view = self.FTloadViewFromNib(nibName: "BaseCollectionView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //collectionView.collectionViewLayout = ArabicCollectionFlow()
        setFollowLayout(followLayout: nil)
    }
    
    // register cell ---------------------------
    func registerCellWithNib(nib:UINib, idCell:String){
        collectionView.register(nib, forCellWithReuseIdentifier: idCell)
    }
    // register cell with class ---------------------------
    class ImageCell: UICollectionViewCell{
        
    }
    func registerCellWithClass(ImageCell1:UICollectionViewCell, idCell:String){
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: idCell)
    }
    
    func scroll(at: IndexPath, atPos: UICollectionView.ScrollPosition, animated: Bool){
        collectionView.scrollToItem(at: at, at: atPos, animated: animated)
    }
    
    // setup follow layout ----------------------
    func setFollowLayout(followLayout: UICollectionViewFlowLayout?){
        if let followLayout = followLayout {
            collectionView.collectionViewLayout = followLayout
        }else{
            collectionView.collectionViewLayout = ArabicCollectionFlow()
        }
        
    }
   
    fileprivate func configs() {
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 6
            layout.itemSize = CGSize(width: 56, height: 56)
            layout.scrollDirection = .horizontal
            layout.invalidateLayout()
            layout.finalizeLayoutTransition()
        }
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //collectionView.isPagingEnabled = true
        
    }
    
    func setDelegateDatasource(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}


   class ArabicCollectionFlow: UICollectionViewFlowLayout {
       override func prepare() {
           super.prepare()
           self.scrollDirection = .horizontal
           self.itemSize = CGSize(width: 96, height: 76)
       }
       override var flipsHorizontallyInOppositeLayoutDirection: Bool {
           return true
       }
   }
   

extension BaseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberItemsInSection ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CreateCellClorsure?(collectionView, indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath)
        
        didSelectItemAt?(collectionView, indexPath)
        
        //collectionView.scrollToItem(at: IndexPath(item: 5, section: 0), at: .left , animated: false)
        
        //var rect = self.collectionView.layoutAttributesForItem(at:IndexPath(row: indexPath.item, section: 0))?.frame
        //collectionView.scrollRectToVisible(rect!, animated: true)
        
        //        let rect = self.collectionView.layoutAttributesForItem(at: indexPath)?.frame
        //         self.collectionView.scrollRectToVisible(rect!, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = heightForCellClorsure?(collectionView,indexPath) ?? CGSize(width: 60, height: 60)
        return size
    }
    
    
}







// example ----------------------

import UIKit

class TestViewController123: UIViewController {
    
    @IBOutlet weak var viewContainerCollection: BaseCollectionView!

    init() {
        super.init(nibName: "TestViewController2", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewContainerCollection.numberOfSections = 1
        viewContainerCollection.numberItemsInSection = 16
        viewContainerCollection.registerCellWithClass(ImageCell1: UICollectionViewCell(), idCell: "cell")
        viewContainerCollection.CreateCellClorsure = {
            clv,index in
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index)
            cell.backgroundColor = .red
            return cell
        }
        viewContainerCollection.setDelegateDatasource()
    }


}
