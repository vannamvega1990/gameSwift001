//
//  Commons.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftMessages
import KLCPopup

class Commons: BaseCommons {
    
    static let shared = Commons()
    
    // Indicator Loading ------------------------------------
    class func showLoading(_ view: UIView) {
        //MBProgressHUD.showAdded(to: view, animated: true) // mac dinh
        //let loadingView = RSLoadingView()
        //loadingView.show(on: view)
        currentVC.showIndicator()
    }
    
    class func hideLoading(_ view: UIView) {
        // RSLoadingView.hide(from: view)
        //MBProgressHUD.hide(for: view, animated: true) // mac dinh
        currentVC.stopIndicator()
    }
    
    class func showDialogNetworkError() {
        //        Common.showDialogAlert(title: "MẤT KẾT NỐI", content: "Kiểm tra lại kết nối mạng", didFinishDismiss: nil)
        let view: MessageView = try! SwiftMessages.viewFromNib()
        view.configureContent(title: nil, body: "Không thể kết nối đến máy chủ", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.configureTheme(.warning)
        //view.backgroundView.backgroundColor = UIColor.black
        //view.bodyLabel?.textColor = UIColor.orange
        //view.titleLabel?.textColor = .orange
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.duration = .seconds(seconds: 4)
        statusConfig.interactiveHide = true
        statusConfig.ignoreDuplicates = true
        //statusConfig.
        SwiftMessages.show(config: statusConfig, view: view)
    }
    
    // Dialog Mesages ---------------------------
    class func showDialogJK(_ body:String) {
        //        Common.showDialogAlert(title: "MẤT KẾT NỐI", content: "Kiểm tra lại kết nối mạng", didFinishDismiss: nil)
        let view: MessageView = try! SwiftMessages.viewFromNib()
        view.configureContent(title: nil, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.configureTheme(.warning)
        //view.backgroundView.backgroundColor = UIColor.black
        //view.bodyLabel?.textColor = UIColor.orange
        //view.titleLabel?.textColor = .orange
        view.button?.isHidden = true
        view.titleLabel?.isHidden = true
        
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.duration = .seconds(seconds: 1)
        statusConfig.interactiveHide = true
        statusConfig.ignoreDuplicates = true
        //statusConfig.
        SwiftMessages.show(config: statusConfig, view: view)
    }
    
    // Dialog ---------------------------------------
    class func showDialogAlert(title: String, content: String, titleButton: String = "Đồng ý", inView: UIView? = nil, didFinishDismiss: (()->())? = nil) {
        //let dialog = AlertDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        let dialog = TPAlertDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        dialog.lbTitle.text = title.lowercased().capitalizedFirstLetter
        
        dialog.lbContent.text = content
        dialog.btnOk.setTitle(titleButton, for: .normal)
        let popup = KLCPopup(contentView: dialog)
        dialog.closeBlock = {
            popup?.dismiss(true)
        }
        popup?.shouldDismissOnBackgroundTouch = false
        popup?.shouldDismissOnContentTouch = true
        popup?.didFinishDismissingCompletion = didFinishDismiss
        popup?.show(atCenter: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY) , in: nil)
    }
    
    // Dialog Confirm---------------------------------------
    class func showDialogConfirm(title: String, content: String, confirmAction: (()->())?) {
        //let dialog = ConfirmDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        let dialog = TPConfirmDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        dialog.lbTitle.text = title.lowercased().capitalizedFirstLetter
        dialog.lbContent.text = content
        dialog.okBlock = {
            confirmAction!()
        }
        
        let popup = KLCPopup(contentView: dialog)
        dialog.closeBlock = {
            popup?.dismiss(true)
        }
        
        popup?.shouldDismissOnBackgroundTouch = false
        popup?.shouldDismissOnContentTouch = true
        popup?.show(atCenter: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY) , in: nil)
    }
    // Dialog Confirm---------------------------------------
    class func showDialogConfirm(title: String, content: String, titleButton: String, confirmAction: (()->())?) {
        //let dialog = ConfirmDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        let dialog = TPConfirmDialog(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: 0))
        dialog.lbTitle.text = title.lowercased().capitalizedFirstLetter
        dialog.lbContent.text = content
        dialog.btnOk.setTitle(titleButton, for: .normal)
        dialog.okBlock = {
            confirmAction!()
        }
        
        let popup = KLCPopup(contentView: dialog)
        dialog.closeBlock = {
            popup?.dismiss(true)
        }
        
        popup?.shouldDismissOnBackgroundTouch = false
        popup?.shouldDismissOnContentTouch = true
        popup?.show(atCenter: CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY) , in: nil)
    }
    // set badge---------------------------------------
    class func setBadge(badgeNumber: Int){
        UIApplication.shared.applicationIconBadgeNumber = badgeNumber
    }
    
    
}
