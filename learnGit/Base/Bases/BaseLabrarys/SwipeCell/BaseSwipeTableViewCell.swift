//
//  BaseSwipeTableViewCell.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BaseSwipeTableViewCell: UITableViewCell {
    
    var widthOfStack:CGFloat = 160
    
    @objc func handleTap(){
           UIView.animate(withDuration: 0.1) {
               self.contentView.frame.origin.x = 0
           }
       }
       @objc func handleSwipe(){
           UIView.animate(withDuration: 0.1) {
            self.contentView.frame.origin.x = -self.widthOfStack
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .orange
        contentView.backgroundColor = .white
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = [.left,.right]
        contentView.addGestureRecognizer(swipeGesture)
        contentView.addGestureRecognizer(tapGesture)
       
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupStack()
    
    }
    
    func setupStack(){
        let view1 = UIButton(frame: CGRect(x: contentView.bounds.width - 70, y: 0, width: 60, height: 60))
         
         let stackView = UIStackView()
         stackView.axis = .horizontal;
         stackView.distribution = .fillEqually;
         stackView.alignment = .fill;
         stackView.spacing = 1;
        stackView.frame = CGRect(x: sizeScreen.width - widthOfStack, y: 0, width: widthOfStack, height: contentView.bounds.height)
         
         
         addSubview(stackView)
         stackView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
             stackView.heightAnchor.constraint(equalTo: heightAnchor, constant: 0),
             stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
             stackView.widthAnchor.constraint(equalToConstant: widthOfStack)
         ])
         
         let subview1 = FTBaseButton()
         subview1.backgroundColor = .gray
         stackView.addArrangedSubview(subview1)
         //stackView.addSubview(subview1)
         
         let subview2 = FTBaseButton()
         subview2.backgroundColor = .green
         stackView.addArrangedSubview(subview2)
        subview2.addTarget(self, action: #selector(btnTap), for: .touchUpInside)
         //stackView.addSubview(subview2)
         
         let subview3 = FTBaseButton()
         subview3.backgroundColor = .yellow
         stackView.addArrangedSubview(subview3)
         //stackView.addSubview(subview3)
         
         
         
        
         view1.setBoderAndShadowStander()
         view1.addTarget(self, action: #selector(xuly), for: .touchUpInside)
         //addSubview(view1)
         bringSubviewToFront(contentView)
    }
    var actionEdit:(() -> Void)?
    @objc func btnTap(){
        actionEdit?()
    }
    
    @objc func xuly(){
        print("123")
    }
    
}
