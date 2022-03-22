//
//  ViewNoteCompliteProfile.swift
//  FinTech
//
//  Created by Tu Dao on 5/13/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

@IBDesignable
class ViewNoteCompliteProfile: UIView {

    override init(frame:CGRect){
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config(){
        guard let view = self.FTloadViewFromNib(nibName: "ViewNoteCompliteProfile") else {
            return
        }
        view.frame = self.bounds
        self.addSubview(view)
        //configs()
    }
}
