//
//  UILabel+Extension.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

//import UIKit
//
//extension String {
//    // width Of String ------------------
//    func widthOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.width
//    }
//    // height Of String ------------------
//    func heightOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.height
//    }
//    // size Of String ------------------
//    func sizeOfString(usingFont font: UIFont) -> CGSize {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        return self.size(withAttributes: fontAttributes)
//    }
//    func size(OfFont font: UIFont) -> CGSize {
//        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
//    }
//}
//
//extension UILabel {
//
//    var height:CGFloat {
//        get{
//            return self.font.pointSize
//        }
//    }
//
//    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {
//
//        var startColorRed:CGFloat = 0
//        var startColorGreen:CGFloat = 0
//        var startColorBlue:CGFloat = 0
//        var startAlpha:CGFloat = 0
//
//        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
//            return false
//        }
//
//        var endColorRed:CGFloat = 0
//        var endColorGreen:CGFloat = 0
//        var endColorBlue:CGFloat = 0
//        var endAlpha:CGFloat = 0
//
//        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
//            return false
//        }
//
//        let gradientText = self.text ?? ""
//
//        //let name:String = NSAttributedString.Key.font.rawValue
//        //let textSize: CGSize = gradientText.size(attributes: [name:self.font])
//        let textSize: CGSize = gradientText.sizeOfString(usingFont: self.font)
//        let width:CGFloat = textSize.width
//        let height:CGFloat = self.height//textSize.height
//
//        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
//
//        guard let context = UIGraphicsGetCurrentContext() else {
//            UIGraphicsEndImageContext()
//            return false
//        }
//
//        UIGraphicsPushContext(context)
//
//        let glossGradient:CGGradient?
//        let rgbColorspace:CGColorSpace?
//        let num_locations:size_t = 2
//        let locations:[CGFloat] = [ 0.0, 1.0 ]
//        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
//        rgbColorspace = CGColorSpaceCreateDeviceRGB()
//        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
//        let topCenter = CGPoint.zero
//        let bottomCenter = CGPoint(x: 0, y: textSize.height)
//        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
//
//        UIGraphicsPopContext()
//
//        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
//            UIGraphicsEndImageContext()
//            return false
//        }
//
//        UIGraphicsEndImageContext()
//
//        self.textColor = UIColor(patternImage: gradientImage)
//
//        return true
//    }
//
//}
//
