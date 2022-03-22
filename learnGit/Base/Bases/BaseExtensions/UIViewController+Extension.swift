//
//  UIViewController+Extension.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/31/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

var imgViewTest: UIImageView?
var btnTest: FTBaseButton?


extension UIViewController {
    
    func hiddenNavigation(isHidden:Bool){
        if let navigation = self.navigationController {
            navigation.navigationBar.isHidden = isHidden
        }
    }
    var bounds:CGRect{
        get{
            return view.bounds
        }
    }
    
    func addSubViews(_ views: [UIView]){
        for each in views {
            view.addSubview(each)
        }
    }
    func hideViews(_ views: [UIView]){
        for each in views {
            each.isHidden = true
        }
    }
    func showViews(_ views: [UIView]){
        for each in views {
            each.isHidden = false
        }
    }
    func removeViews(_ views: [UIView]){
        for each in views {
            each.removeFromSuperview()
        }
    }
    // viewcontroller add viewcontroller ---------------------
    func addSubViewController(_ subVC: UIViewController, supperView: UIView?, frameOfSubVC:CGRect){
        self.addChild(subVC)
        subVC.didMove(toParent: self)
        subVC.view.frame = frameOfSubVC
        if let supperV = supperView{
            supperV.addSubview(subVC.view)
        }else{
            self.view.addSubview(subVC.view)
        }
    }
    // create timer --------------
    func createTimer(timeInterval: TimeInterval, selector: Selector, repeats: Bool) -> Timer{
        let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: selector, userInfo: nil, repeats: repeats)
        return timer
    }
    // change root viewcontroller ---------
    func changeRootViewController(_ vc: UIViewController){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootView(newRootView: vc)
    }
    // safe area --------------------------
    func getHeightOfSafeArea() -> (CGFloat, CGFloat){
        var topSafeArea: CGFloat = .zero
        var bottomSafeArea: CGFloat = .zero
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        return (topSafeArea, bottomSafeArea)
    }
    
    // present ViewController -----------------
    func presentViewController(_ viewController: UIViewController, transitionStyle: UIModalTransitionStyle = .flipHorizontal, modalPresentationStyle: UIModalPresentationStyle = .fullScreen ){
        let vc = viewController
        //vc.view.backgroundColor = .green
        vc.modalTransitionStyle = transitionStyle   //.flipHorizontal
        vc.modalPresentationStyle =  modalPresentationStyle   //.overFullScreen
        if let nav = self.navigationController {
            //nav.present(vc, animated: true, completion: nil)
            self.present(vc, animated: true, completion: nil)
        }else{
            self.present(vc, animated: true, completion: nil)
        }
    }
    // hide keyboard -------------------------
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // back to n viewcontroller ----------------
    func backToAnyViewController(n:Int) {
        if let navigationController = self.navigationController {
            let viewControllers: [UIViewController] = navigationController.viewControllers
            self.navigationController?.popToViewController(viewControllers[viewControllers.count - n-1], animated: true)
        }
    }
    // back to n viewcontroller ----------------
    func backToAnyViewController2(vc:UIViewController) {
        if let navigationController = self.navigationController {
            let viewControllers: [UIViewController] = navigationController.viewControllers
            if viewControllers.contains(vc){
                navigationController.popToViewController(vc, animated: true)
            }else{
                showSimpleAlert(title: "info", ms: "ko co viewcontroller thoa man")
            }
            
        }
    }
    
    // set Status Bar Style-------------
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = style == .lightContent ? UIColor.red : .white
            statusBar.setValue(style == .lightContent ? UIColor.white : .red, forKey: "foregroundColor")
        }
    }
    // custom Toolbar for UIItextfild (thay the iqkeyboard) ---------
    func addCustomToolBarForUITextfild(arrTextFild:[BaseTextField]){
        AppDelegate.disableIQKeyboard()
        for (key, each) in arrTextFild.enumerated() {
            let nd = each.placeholder ?? ""
            each.tag = key
            let toolBar = ToolbarForUITextfild(frame: CGRect(origin: .zero, size: CGSize(width: sizeScreen.width-32, height: 48)))
            toolBar.key = each.tag
            toolBar.max = arrTextFild.count-1
            toolBar.setTitle(content: nd)
            toolBar.ic_up.setTintColor = key == 0 ? UIColor.lightGray : UIColor.systemBlue
            toolBar.ic_down.setTintColor = key == arrTextFild.count-1 ? UIColor.lightGray : UIColor.systemBlue
            toolBar.actionFinish = {
                self.view.endEditing(true)
            }
            toolBar.actionDown = {
                if (each.tag + 1) < arrTextFild.count {
                    arrTextFild[each.tag + 1].becomeFirstResponder()
                }
            }
            toolBar.actionUp = {
                if (each.tag - 1) >= 0 {
                    arrTextFild[each.tag - 1].becomeFirstResponder()
                }
            }
            each.addCustomToolBar(toolBar)
        }
    }
    // Get Camera Permission ------------------------------
    func getCamPermission(completion: @escaping(Bool) -> ()) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
            if granted {
                completion(true)
            } else {
                self.showAlertGetPermission(title: "Vui lòng cấp quyền sử dụng máy ảnh", message: "Lendbox cần cung cấp quyền sử dụng camera để chụp ảnh và quay video xác minh khoản vay")
                completion(false)
            }
        }
    }
    
    // Get camera permission 2 ------------------
    func getCameraPermission(){
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            // Already Authorized
            print("Already Authorized")
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    // User granted
                    print("User granted")
                } else {
                    // User rejected
                    print("User rejected")
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        Commons.showDialogConfirm(title: "Thông báo", content: "cần truy cập camera", titleButton: "Đồng ý") {
                            if let url = URL(string:UIApplication.openSettingsURLString) {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    // Get PhotoLib Permission --------------------------------
    func getPhotoLibPermission(completion: @escaping(Bool) -> ()) {
        PHPhotoLibrary.requestAuthorization { (granted) in
            if granted == PHAuthorizationStatus.authorized {
                completion(true)
            } else {
                self.showAlertGetPermission(title: "Vui lòng cấp quyền xem thư viện", message: "Lendbox cần cung cấp quyền sử dụng thư viện để người dùng cập nhật thông tin thanh toán và chứng từ")
                completion(false)
            }
        }
    }
    
    func showSettingsForApp(){
        if let url = URL(string:UIApplication.openSettingsURLString) {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func showAlertGetPermission(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let url = URL(string:UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    // simple alert -------------------------
    func showSimpleAlert(title:String, ms:String){
        let alert = UIAlertController(title: title, message: ms, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Show simple alert type 2 -----------------------------------
    func showSimpleAlertWithBtn(title:String, ms:String,btn001Title: String?, btn001Style: UIAlertAction.Style = .default, btn002Style: UIAlertAction.Style = .default ,btn002Title: String? , clickHanle001:ClickHanle?, clickHanle002:ClickHanle?){
        let alert = UIAlertController(title: title, message: ms, preferredStyle: UIAlertController.Style.alert)
        if btn001Title != nil {
            alert.addAction(UIAlertAction(title: btn001Title, style: btn001Style, handler: { (alertAction:UIAlertAction) in
                if clickHanle001 != nil {
                    clickHanle001!()
                }
            }))
        }
        if btn002Title != nil {
            alert.addAction(UIAlertAction(title: btn002Title, style: btn002Style, handler: { (alertAction:UIAlertAction) in
                if clickHanle002 != nil {
                    clickHanle002!()
                }
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    // alert with textfild -----------------------
    func showAlertWithTextfild(location: URL){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Download completed", message: "Enter a name file", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "set your file name..."
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
        }))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    // add gradient for navigationbar -----------------
    func setGradientForNavigationBar(){
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navigationBar.bounds
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        // Render the gradient to UIImage
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        let btn = UIButton()
    }
    
    struct AlertAction {
        var title: String
        var style: UIAlertAction.Style
        var action:(()->Void)?
    }
    
    // show action sheet ---------------
    func createActionSheet(title:String, message:String?, subTitles: [AlertAction]){
        let alrController = UIAlertController(title: title, message:message , preferredStyle: UIAlertController.Style.actionSheet)
        
        for each in subTitles {
            let someAction = UIAlertAction(title: each.title, style: each.style, handler: {(alert: UIAlertAction!) in
                each.action?()
            })
            alrController.addAction(someAction)
        }
        self.present(alrController, animated: true, completion:{})
    }
    
    // show test image ----------
    func testImage(img: UIImage){
        imgViewTest = UIImageView(frame: view.frame.resizeAtCenter(offsetX: 6, offsetY: 6))
        addSubViews([imgViewTest!])
        imgViewTest!.contentMode = .scaleAspectFit
        imgViewTest!.backgroundColor = .green
        imgViewTest!.image = img
        btnTest = FTBaseButton(frame: CGRect(x: 156, y: 367, width: 56, height: 56))
        btnTest!.backgroundColor = .green
        btnTest!.borderColor = .red
        btnTest!.borderWidth = 6
        btnTest!.addTarget(self, action: #selector(clearTestImage), for: .touchUpInside)
        addSubViews([btnTest!])
    }
    
    @objc func clearTestImage(){
        imgViewTest?.removeFromSuperview()
        btnTest?.removeFromSuperview()
    }
    
    
    
    
    

}
