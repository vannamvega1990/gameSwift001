//
//  FTBaseAppleButton.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/26/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
@IBDesignable
class FTBaseAppleButton: ASAuthorizationAppleIDButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //ButtonType.continue
        layer.cornerRadius = 12
        
    
    }
    
    
    
    
}


