//
//  FTBaseHeaderViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class FTBaseHeaderView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnback: UIButton!
    var actionBackClosure:(()->Void)?
    @IBInspectable var nameTitle: String = "" {
        didSet {
            title.text = nameTitle
        }
    }
    @IBInspectable var titleColor: UIColor = .white {
        didSet {
            title.textColor = titleColor
        }
    }
    @IBInspectable var btnBackIcon: UIImage = UIImage() {
        didSet {
            btnback.setImage(btnBackIcon, for: .normal)
        }
    }
    @IBInspectable var fontSize: CGFloat = 16 {
        didSet {
            title.font = UIFont(name: title.font.fontName, size: fontSize)
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
        guard let view = self.FTloadViewFromNib(nibName: "FTBaseHeaderView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //rootView.backgroundColor = .clear
        //configs()
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        actionBackClosure?()
        if let vc = self.getParentViewController(), let nav = vc.navigationController {
            nav.popViewController(animated: true)
        }
    }
    
}
