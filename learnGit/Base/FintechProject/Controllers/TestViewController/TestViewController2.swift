//
//  TestViewController2.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/11/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class TestViewController2: BaseViewControllers {
    
    @IBOutlet weak var testView: CircleProgress!
    @IBOutlet weak var testView2: UIButton!
    @IBOutlet weak var dashView: CustomDashedView!
    
    @IBOutlet weak var viewContainerCollection: BaseCollectionView!

    init() {
        super.init(nibName: "TestViewController2", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if let img = generateQRCode(from: "http://sex.com") {
//            let imgview = UIImageView(frame: CGRect(x: 16, y: 96, width: 96, height: 96))
//            view.addSubview(imgview)
//            let imgDog = UIImage(named: "dog-0.jpg")
//            imgview.image = img
//            //img.saveToPhotos(selector: #selector())
//            //saveImageToPhotos(imgData: imgview.image!)
//            gotoBaseCameraViewController()
//        }
        
        var fileInfo = FileInfo()
                fileInfo.nameFile = "appendingPath"
                fileInfo.typeFile = "unknown"
                fileInfo.dungluongFile = "0KB"
                fileInfo.diachiFile = "123"
                fileInfo.dateFile = "2/3/2021"
                CoreDataHandler.saveObject(fileInfo: fileInfo)
        
        let users = CoreDataHandler.fetchObject()
        print(users?.count)
        print("------" + users!.first!.dateFile! ?? "")
        

        testView.showProgress(percent: 60)
        print(testView2.frame.size)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("-----\(self.testView.widthConstraint?.constant)")
        //let contrainsView2 = self.testView2.getAllConstraintsCustom(viewArray: [self.dashView])
        let contrainsView2 = self.testView2.getAllConstraints()
        let left = contrainsView2.first(where: {
            $0.firstAttribute == .bottomMargin
                //&& $0.relation == .equal
        })
        print("-----testView2:\(contrainsView2.count)")
        print("-----testView2:\(contrainsView2.last?.constant)")
        print("-----testView2:\(left?.constant)")
        print("-----testView2:\(self.testView2.bottomConstraint?.constant)")
        
        //self.testView.widthConstraint!.constant = 558

//        viewContainerCollection.numberOfSections = 1
//        viewContainerCollection.numberItemsInSection = 16
//        viewContainerCollection.registerCellWithClass(ImageCell1: UICollectionViewCell(), idCell: "cell")
//        viewContainerCollection.CreateCellClorsure = {
//            clv,index in
//            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index)
//            cell.backgroundColor = .red
//            return cell
//        }
//        viewContainerCollection.setDelegateDatasource()
    }


}
