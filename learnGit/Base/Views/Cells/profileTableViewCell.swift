//
//  profileTableViewCell.swift
//  FinTech
//
//  Created by Tu Dao on 5/7/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

class profileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseView: FTBaseViewImageWithLabel!
    var heightlightBoder:Bool = false
    var hideHightlightWhenClick:Bool = false{
        didSet{
            //selectionStyle = .blue
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //baseView.backgroundColor = .lightGray
//        baseView.title.superview?.backgroundColor = .lightGray
//        //baseView.backgroundColor = .red
//        print("123")
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //backgroundColor = .clear
//        baseView.title.superview?.backgroundColor = .white
//    }
    
    func setTitle(name:String){
        baseView.setTitle(name: name)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if heightlightBoder {
            self.addHeightlightBoder()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func addHeightlightBoder(){
        backgroundColor = UIColor.clear
        
        self.baseView.layer.borderWidth = 1
        self.baseView.layer.cornerRadius = 3
        self.baseView.layer.borderColor = UIColor.clear.cgColor
        self.baseView.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
