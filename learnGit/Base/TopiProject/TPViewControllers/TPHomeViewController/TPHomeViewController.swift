//
//  TPHomeViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPHomeViewController: TPBaseViewController {
    
    @IBOutlet weak var tbvKhoaHocDauTu: BaseColectionViewHorizontal!
    @IBOutlet weak var tbvNewsInvest: BaseColectionViewHorizontal!
    @IBOutlet weak var viewCarot: BaseView!
    @IBOutlet weak var vKim: UIView!

    init() {
        super.init(nibName: "TPHomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTokenNoti(){
        //TPNetworkManager.shared.requestUpdateTokenNoti(FirebaseToken: "", coordbust)
    }
    func getInboxNotYetRead(){
        //TPNetworkManager.shared.requestGetInboxNotYetRead(coordbust)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vKim.setAnchorPoint1(CGPoint(x: 1, y: 1))
        vKim.transform = CGAffineTransform(rotationAngle:  CGFloat(45.degreesToRadians))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewCarot.layer.cornerRadius = viewCarot.bounds.width/2
        
        
        if TPCakeDefaults.shared.isFirstTouchID == nil {
            
            let v = TPFaceIDView()
            v.actionOK = {
                self.removeAllPopupTrump()
                TPCakeDefaults.shared.isFirstTouchID = 1
                let vc = TPBioTokenViewController()
                self.pushToViewController(vc, true)
            }
            v.actionCancel = {
                self.removeAllPopupTrump()
                TPCakeDefaults.shared.isFirstTouchID = 1
            }
            showPopupTrumpCenter(viewWantPop: v, isTapBg: false, typeAnimation: .Opacity, isBg: true, lef: 24, right: 24, height: 271)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //viewCarot.layer.cornerRadius = viewCarot.bounds.width/2
        let v = BaseView()
        
        //viewCarot.cornerTopRadius =  (sizeScreen.width - 2*26)
        
        let pathIn = UIBezierPath()
        pathIn.move(to: CGPoint(x: 0, y: viewCarot.bounds.maxY))
        //pathIn.addQuadCurve(to: CGPoint(x: viewCarot.bounds.maxX, y: viewCarot.bounds.maxY), controlPoint: CGPoint(x: viewCarot.bounds.midX, y: 0))
        pathIn.addArc(withCenter: CGPoint(x: viewCarot.bounds.width/2, y: viewCarot.bounds.height), radius: viewCarot.bounds.width/2, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + 180).degreesToRadians), clockwise: true)
        pathIn.addLine(to: CGPoint(x: 0, y: viewCarot.bounds.maxY))
        
//        pathIn.addLine(to: CGPoint(x: 16, y: v1.bounds.maxY))
//        //pathIn.addArc(withCenter: CGPoint(x: bounds.maxX, y: bounds.maxY), radius: bounds.maxY - 6, startAngle: 0, endAngle: .pi/2, clockwise: true)
//        pathIn.addArc(withCenter: CGPoint(x: v1.bounds.width, y: bounds.height), radius: v1.bounds.width-16, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + beta).degreesToRadians), clockwise: true)
//        pathIn.addLine(to: CGPoint(x: v1.bounds.maxX, y: v1.bounds.maxY))
        pathIn.fill()
        pathIn.close()
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = pathIn.cgPath
        shapeLayer3.fillRule = .evenOdd
        shapeLayer3.strokeColor = UIColor.brown.cgColor
        shapeLayer3.fillColor = UIColor.brown.cgColor
        shapeLayer3.lineWidth = 0
        
        let gradientLayer = CAGradientLayer()
        //gradientLayer.colors = [UIColor(rgb: 0x2E313D).cgColor, UIColor(rgb: 0x21232C).cgColor]
        gradientLayer.colors = [UIColor.black.cgColor, UIColor(rgb: 0x21232C).cgColor]
        gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        gradientLayer.frame = viewCarot.bounds
        viewCarot.layer.insertSublayer(gradientLayer, at:0)
        
        
        
        //viewCarot.setGradientBackground(colors: [UIColor(rgb: 0x2E313D), UIColor(rgb: 0x21232C)], locations: [0.1,0.0], isVertical: true)
        viewCarot.layer.mask = shapeLayer3
        //viewCarot.layer.borderWidth = 1
        //viewCarot.layer.borderColor = UIColor.white.cgColor
        let vBg = UIView()
        //vBg.backgroundColor = .red
        viewCarot.superview!.insertSubview(vBg, belowSubview: viewCarot)
        vBg.setConstraintByCode(constraintArray: [
            vBg.bottomAnchor.constraint(equalTo: viewCarot.bottomAnchor),
            vBg.leftAnchor.constraint(equalTo: viewCarot.leftAnchor, constant: -16),
            vBg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vBg.heightAnchor.constraint(equalToConstant: viewCarot.bounds.height+32)
        ])
        let pathIn1 = UIBezierPath()
        pathIn1.move(to: CGPoint(x: 0, y: vBg.bounds.maxY))
        pathIn.addArc(withCenter: CGPoint(x: vBg.bounds.width/2, y: vBg.bounds.height), radius: vBg.bounds.width/2, startAngle: -180.degreesToRadians, endAngle: CGFloat((-180.0 + 180).degreesToRadians), clockwise: true)
        pathIn.addLine(to: CGPoint(x: 0, y: vBg.bounds.maxY))
        pathIn.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pathIn1.cgPath
        shapeLayer.frame = vBg.bounds
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 6
        vBg.layer.addSublayer(shapeLayer)
        //vBg.layer.insertSublayer(shapeLayer, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvKhoaHocDauTu.widthCell = 299
        tbvKhoaHocDauTu.heightCell = tbvKhoaHocDauTu.heightConstraint!.constant
        tbvKhoaHocDauTu.nameArray = ["1","2","3"]
        tbvKhoaHocDauTu.nibCell = UINib(nibName: "ImageAndTitleCLVCell", bundle: nil)
        tbvKhoaHocDauTu.collectionView.collectionView.backgroundColor = .clear
        tbvKhoaHocDauTu.backgroundColor = .clear
        tbvKhoaHocDauTu.collectionView.backgroundColor = .clear
        tbvKhoaHocDauTu.collectionView.rootView.backgroundColor = .clear
        tbvKhoaHocDauTu.collectionView.CreateCellClorsure = {
            [weak self ] clv,index in
            guard let selfWeak = self else {
                return UICollectionViewCell()
            }
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! ImageAndTitleCLVCell
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.imgView.image = UIImage(named: "bg_courseInvest")
            return cell
        }
        //tbvKhoaHocDauTu.collectionView.setDelegateDatasource()
        
        tbvNewsInvest.widthCell = 299
        tbvNewsInvest.heightCell = tbvNewsInvest.heightConstraint!.constant
        tbvNewsInvest.nameArray = ["1","2","3"]
        tbvNewsInvest.nibCell = UINib(nibName: "ImageAndTitleCLVCell", bundle: nil)
        tbvNewsInvest.collectionView.collectionView.backgroundColor = .clear
        tbvNewsInvest.backgroundColor = .clear
        tbvNewsInvest.collectionView.backgroundColor = .clear
        tbvNewsInvest.collectionView.rootView.backgroundColor = .clear
        tbvNewsInvest.collectionView.CreateCellClorsure = {
            [weak self ] clv,index in
            guard let selfWeak = self else {
                return UICollectionViewCell()
            }
            let cell = clv.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as! ImageAndTitleCLVCell
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.imgView.image = UIImage(named: "img_newsInvest")
            return cell
        }
        
    }


}
