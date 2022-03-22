//
//  BaseIndicator.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

struct Indicator {
    var indicator:UIView
}

var arrayIndicator: [Indicator] = [Indicator]()
let bg:UIView? = UIView()

extension UIViewController {
    func showIndicator(_ indicator:UIView? = nil ){
        bg?.backgroundColor = UIColor.lightGray.withAlphaComponent(0)
        bg?.frame = window.frame
        bg?.addToAllScreen()
        let indicatorShow = indicator ??  defultIndicator()
        indicatorShow.frame = CGRect(x: 16, y: 98, width: 58, height: 58)
        indicatorShow.center = view.center
        indicatorShow.addToAllScreen()
        arrayIndicator.append(Indicator(indicator: indicatorShow))
    }
    func stopIndicator(){
        arrayIndicator.last?.indicator.removeFromSuperview()
        if !arrayIndicator.isEmpty {
            arrayIndicator.removeLast()
        }
        
        if arrayIndicator.isEmpty {
            bg?.removeFromSuperview()
        }
    }
    func defultIndicator() -> UIView{
        let indicator = Spinner(frame: CGRect(x: 16, y: 98, width: 98, height: 98))
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        indicator.Style = .None
        indicator.enableInnerLayer = true
        indicator.outerStrokeColor = UIColor.green
        indicator.innerStrokeColor = UIColor.red
        indicator.labelTextColor = UIColor.gray
        indicator.labelText = "Loading"
        indicator.labelFontSize = 1
        return indicator
    }
}
