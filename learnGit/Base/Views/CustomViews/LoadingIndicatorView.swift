//
//  LoadingIndicatorView.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class LoadingIndicatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //showLoadingIndicator()
        //backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //showLoadingIndicator()
        //backgroundColor = .red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        showLoadingIndicator()
        backgroundColor = .red
    }
    
    func showLoadingIndicator(){
        let spinnerView = UIView.init(frame: self.bounds)
        spinnerView.backgroundColor = .orange//UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        var activityIndicator = UIActivityIndicatorView()
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 46))
        strLabel.text = "Hệ thống đang xử lý"
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: self.frame.midX - strLabel.frame.width/2, y: self.frame.midY - strLabel.frame.height/2 , width: 200, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            effectView.contentView.addSubview(activityIndicator)
            effectView.contentView.addSubview(strLabel)
            spinnerView.addSubview(effectView)
            self.addSubview(spinnerView)
        }
    }
}

