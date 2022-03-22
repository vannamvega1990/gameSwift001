//
//  Extension.swift
//  Download98
//
//  Created by Eric Petter on 3/1/21.
//  Copyright © 2021 petter. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension UIViewController {
    
    typealias ClickHanle = (()-> Void)
    
    func playVideo(link: String) {
        //let videoURL = URL(string:"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let videoURL = URL(string:link)
        let player = AVPlayer(url: videoURL!)
        DispatchQueue.main.async {
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
    
    

    
    // MARK: popup message ======================

    func showPopupMessageView(smsString: String){
        
        //let popupVC = UIViewController()
        let mainWindow = UIApplication.shared.keyWindow!
//        popupVC.hideKeyboardWhenTappedAround()
//        popupVC.view.backgroundColor = UIColor.clear
//        popupVC.modalPresentationStyle = UIModalPresentationStyle.custom
//        popupVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
        
        let overlayview = UIView()
        overlayview.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        //overlayview.frame = popupVC.view.bounds
        //popupVC.view.addSubview(overlayview)
//        let viewPopup: MessageView = {
//            let view = MessageView()
//            view.infoLabel.text = smsString
//            return view
//        }()
        let viewPopup = MessageView1()
        viewPopup.infoLabel.text = smsString
        viewPopup.frame = CGRect(x: 0, y: 0, width: mainWindow.bounds.width, height: 56)
        viewPopup.frame.origin.y = -viewPopup.frame.height
        mainWindow.addSubview(viewPopup)
        
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            viewPopup.frame.origin.y = 0
            self?.view.layoutIfNeeded()
        }) { (state) in
            UIView.animate(withDuration: 0.5, delay: 1.0, animations: { [weak self] in
                viewPopup.frame.origin.y = -viewPopup.frame.height
                self?.view.layoutIfNeeded()
            }, completion: {(state) in
                viewPopup.removeFromSuperview()
            })
        }
    }
}







extension UIResponder {
    func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {return nil}
        }
    }
}

extension UIView {
    func FTloadViewFromNib(nibName: String)->UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}


extension UIView {
    
    // OUTPUT 1
    func dropShadow1(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow2(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius

      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

extension UIView
{
    //Get Parent View Controller from any view
    func parentViewController() -> UIViewController {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return (responder as? UIViewController)!
    }
}

extension UIApplication{
class func getPresentedViewController() -> UIViewController? {
    var presentViewController = UIApplication.shared.keyWindow?.rootViewController
    while let pVC = presentViewController?.presentedViewController
    {
        presentViewController = pVC
    }

    return presentViewController
  }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension String {
    
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }
    
    public func subStr(from: Int, length: Int) -> String {
        if from + length < from {
            return self
        }
        let start = self.index(startIndex, offsetBy: from)
        let end = self.index(startIndex, offsetBy: from + length)
        let range = start..<end
        return substring(with: range)
    }
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter
    }()
    
    
    var toLongDate: Date? {
        return String.dateFormatter.date(from: self)
    }
}

extension Date {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()
    
    private static let dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "ICT")
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    private static let dateFormatter3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return formatter
    }()
    
    private static let dateFormatter4: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss" //yyyyMMddHHmmss
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()
    
    var longDate: String {
        return Date.dateFormatter.string(from: self)
    }
    
    var dateSign: String {
        return Date.dateFormatter2.string(from: self)
    }
    
    var longDate2: String {
        return Date.dateFormatter3.string(from: self)
    }
    
}

