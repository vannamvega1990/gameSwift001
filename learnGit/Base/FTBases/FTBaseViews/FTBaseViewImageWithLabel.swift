//
//  FTBaseViewImageWithLabel.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseViewImageWithLabel: FTBaseView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nail: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var leftContraintLogo: NSLayoutConstraint!
    @IBOutlet weak var leftContraintTitle: NSLayoutConstraint!
    
    var actionClosure:((IndexPath)->())?
    
    var indexPath:IndexPath?
    
    func setTitle(name:String){
        title.text = name
    }
    
    @IBInspectable var txtTitle: String = "" {
        didSet {
            title.text = txtTitle
        }
    }
    
    @IBInspectable var txtSize: CGFloat = 16 {
        didSet {
            title.font = title.font.withSize(txtSize)
        }
    }
    

    
    @IBInspectable var txtColor: UIColor = .black {
        didSet {
            title.textColor = txtColor
        }
    }
    
    @IBInspectable var hideNail: Bool = false {
        didSet {
            nail.isHidden = hideNail
        }
    }
    
    @IBInspectable var hideLogo: Bool = false {
        didSet {
            logo.isHidden = hideLogo
        }
    }
    
    @IBInspectable var setIcon: UIImage = UIImage() {
        didSet {
            logo.image = setIcon
        }
    }
    
    @IBInspectable var setNail: UIImage = UIImage() {
        didSet {
            nail.image = setNail
        }
    }
    
    func heighlightBorder(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func dropShadow(){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 3, height: 3)
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
        guard let view = self.FTloadViewFromNib(nibName: "FTBaseViewImageWithLabel") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        //self.addSubview(view)
        self.addSubview(rootView)
        //configs()
    }
    
    func setBackground(){
        backgroundColor = .red
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        subviews.forEach { (v:UIView) in
//            v.isHidden = true
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        subviews.forEach { (v:UIView) in
//            v.isHidden = false
//        }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        subviews.forEach { (v:UIView) in
//            v.isHidden = false
//        }
//    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        subviews.forEach { (v:UIView) in
//            v.isHidden = false
//        }
//        if indexPath != nil {
//            actionClosure?(indexPath!)
//            //print(indexPath?.section)
//        }
//    }
    override class func awakeFromNib() {
        super.awakeFromNib()
        //icon.image = UIImage(named: "ic_apple")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        isFakeUIButton = true
        actionFakeWhenTouchUp = {
            if self.indexPath != nil {
                currentVC.hideKeyboard()
                self.actionClosure?(self.indexPath!)
            }
        }
        //logo.image = UIImage(named: "ic_apple")
    }
    
}
