//
//  TPEmptyView.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/15/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class TPEmptyView: UIView {
    @IBOutlet weak var title: UILabel!
    var rootView = UIView()
    
    func setTile(titleContent: String){
        title.text = titleContent
    }
    override init(frame:CGRect){
        super.init(frame: frame)
        configs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configs()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func configs(){
        guard let view = self.FTloadViewFromNib(nibName: "TPEmptyView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
    }
    
}
