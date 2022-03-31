//
//  BaseViewControllers.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
import GoogleSignIn

class BaseViewControllers: UIViewController {
    
    
    var userSocial: SocialObject?
    
    var shitDic: [String:Any]?
    var code: Int?
    var sms: String?
    
    var datePicker: UIDatePicker?
    var datePickerCustom: UIView?
    
    
    var colorBorderNormal = 0xD6D6D6
    var colorBorderActive = 0x159B80
    var baseTableView: BaseTableView?
    var subViewController: UIViewController?
    
    var actionGetPhoto:((UIImage)->Void)?
    var closureAppleLogin:((SocialObject) -> Void)?
    
    var closureHidePopupTrump:(() -> Void)?
    
    var objectReciver:AnyObject?
    var objectTransmit:AnyObject?
    var fromViewController: BaseViewControllers?
    
    func cellShowListPopupPressed(indexpath: IndexPath){
        print(indexpath)
    }
    
    func setBackgroundColor(_ color: UIColor = .white){
        view.backgroundColor = color
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        fromViewController = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentVC = self
        bgPopTrumpView = viewParm()
        arrayTrumpViewPop = [BaseView]()
        
        if let subViewController = subViewController {
            setupBaseTableView(subViewController)
        }
        //NotificationCenter.default.addObserver(self, selector: #selector(statusManager),name: .flagsChanged, object: nil)
        //BaseCommons.registerTransmitNotificationcenter("checkNetwork", self, nil)
        BaseCommons.regisReceverNotificationcenter(self, "checkNetwork", nil, selector: #selector(statusManager))
    }
    
    // remove notification center AllObserver --------------------
    func removeAllObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentVC = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let baseTableView = baseTableView {
            baseTableView.frame = view.bounds
            let (topsafeArea, _) = getHeightOfSafeArea()
            let heightCell = view.bounds.height - topsafeArea
            baseTableView.heightForCellClorsure = {
                (tbv, indexpath) in
                return heightCell
            }
            addSubViews([baseTableView])
            baseTableView.setupDelegateDatasoucre()
        }
        
    }
    
    func setupBaseTableView(_ vc: UIViewController){
        baseTableView = BaseTableView(frame: .zero)
        baseTableView?.tbv.allowsSelection = false
        baseTableView!.numberOfSections = 1
        baseTableView!.numberRow = 1
        baseTableView!.heightForHeaderInSection = 0
        baseTableView!.backgroundColor = UIColor.white
        baseTableView!.hideSpactorCellVarible = true
        baseTableView!.showHorizontalIndicator = false
        
        baseTableView!.CreateCellClorsure = {
            tbv, indexPath in
            let cell = UITableViewCell()
            cell.contentView.backgroundColor = .red
            if indexPath.section == 0 {
                let startVC = vc
                self.addSubViewController(startVC, supperView: cell.contentView, frameOfSubVC: cell.contentView.bounds)
            }
            return cell
        }
        baseTableView!.didSelectedRowClosure = {(tbv,indexPath) in
            //self.baseTableView!.setColorForCellWhenClick(tbv, indexPath: indexPath, color: .clear)
        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func updateUserInterface() {
//        switch Network.reachability.status {
//        case .unreachable:
//            self.showToastFix(sms: "ko co internet")
//            break
//        case .wwan:
//            self.showToastFix(sms: "co wan")
//            break
//        case .wifi:
//            self.showToastFix(sms: "co wifi")
//            break
//        }
        if Network.reachability.isReachable {
            let txt = Network.reachability.isReachableViaWiFi ? "wifi" : "wan"
            self.showToastFix(sms: "co internet " + txt)
        }else{
            self.showToastFix(sms: "ko co internet")
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    //    func hiddenNavigation(isHidden:Bool){
    //        if let navigation = self.navigationController {
    //            navigation.navigationBar.isHidden = isHidden
    //        }
    //    }
    func pushToViewController(_ vc: UIViewController, _ animated:Bool){
        navigationController?.pushViewController(vc, animated: animated)
    }
    func popBackViewController(_ animated:Bool){
        navigationController?.popViewController(animated: animated)
    }
    func popToRootViewController(_ animated:Bool){
        navigationController!.popToRootViewController(animated: animated)
    }
    func pushToMainViewController(){
        let vc = TabBarViewController()
        self.pushToViewController(vc, true)
    }
    
    //    func signOutGoogle(){
    //        GIDSignIn.sharedInstance().signOut()
    //    }
    
    // Show dialog message ----------------------
    func showDialogJK(_ body:String){
        Commons.showDialogJK(body)
    }
    // add a view, uiview full screen ---------------
    //var viewFullScreen = BaseView()
    func addFullScreenView(){
        let viewFullScreen = BaseView(frame: UIScreen.main.bounds)
        viewFullScreen.backgroundColor = UIColor(white: 0, alpha: 0.3)
        viewFullScreen.addToAllScreen()
        viewFullScreen.addTapGesture()
        let pop = BaseView(frame: CGRect(x: 0, y: 0, width: 156, height: 67))
        pop.backgroundColor = .red
        pop.addToAllScreen()
        viewFullScreen.tapHanle = { (tapgesture: UITapGestureRecognizer) in
            viewFullScreen.removeFromSuperview()
            pop.removeFromSuperview()
        }
    }
    
    // show popup center, botton, any position ------------------
    enum PopupPosition {
        case center
        case botton
        case any
    }
    var pop: BaseView?
    var backgroundViewForPopupView:BaseView?
    // show popup ------------------------
    func showPopup(popupPosition: PopupPosition, popView: BaseView, isAnimation:Bool = true, isNoBackground:Bool = false){
        backgroundViewForPopupView = BaseView(frame: UIScreen.main.bounds)
        guard let backgroundViewForPopupView = backgroundViewForPopupView else{
            return
        }
        let alpha: CGFloat = isNoBackground ? 0.0 : 0.3
        backgroundViewForPopupView.backgroundColor = UIColor(white: 0, alpha: alpha)
        backgroundViewForPopupView.addToAllScreen()
        backgroundViewForPopupView.addTapGesture()
        
        pop = popView
        guard let pop = pop else{
            return
        }
        pop.addToAllScreen()
        
        let center = CGPoint(x: sizeScreen.width/2, y: sizeScreen.height/2)
        let pointBegin = center.moveToPoint(dx: 0, dy: 126)
        let time = isAnimation ? 0.1 : 0.0
        if popupPosition == .center {
            pop.center = pointBegin
            pop.addSimpleAnimation(time: time, delay: 0, options: [], action: {
                pop.center = center
            }, completion: nil)
        }
        else if popupPosition == .botton {
            popView.center = pointBegin
            pop.center.y = sizeScreen.height + pop.bounds.height/2
            pop.addSimpleAnimation(time: time, delay: 0, options: [], action: {
                pop.center.y = sizeScreen.height - pop.bounds.height/2
            }, completion: nil)
        }
        
        backgroundViewForPopupView.tapHanle = { (tapgesture: UITapGestureRecognizer) in
            pop.addSimpleAnimation(time: time, delay: 0, options: [], action: {
                if popupPosition == .center {
                    pop.center = pointBegin
                } else if popupPosition == .botton {
                    pop.center.y = sizeScreen.height + pop.bounds.height/2
                }
            }, completion: {_ in
                backgroundViewForPopupView.removeFromSuperview()
                pop.removeFromSuperview()
            })
        }
    }
    
    func removePopup(){
        backgroundViewForPopupView?.removeFromSuperview()
        pop?.removeFromSuperview()
    }
    
    
    var timeForToast: Int = 3
    var timeIntervalForToast: TimeInterval = 1.0
    var countForToast: Int = 0
    
    var timerForToast:Timer?
    // show Toast --------------
    var arrayViewToast:[ToastObject] = [ToastObject]()
    struct ToastObject {
        //var viewToast: Toast001
        var viewToast: TPToastView
        var index: Int
        var actionCompleted: (() -> Void)? = nil
    }
    
    // toast chuẩn
    func showToastFix(sms:String, icon: UIImage? = nil, backgroundcolor:UIColor = .red,textcolor:UIColor = .white,bottom:CGFloat=96, actionWhenCompleted: (() -> Void)? = nil){
        let toastView = TPToastView()   //Toast001()
        toastView.label.text = sms
        toastView.minWidth.constant = min(windowFix.bounds.width - 96, sms.widthOfString(usingFont: toastView.label.font))
        toastView.icon.isHidden = icon == nil
        toastView.icon.image = icon
        toastView.label.textColor = textcolor
        toastView.rootView.backgroundColor = backgroundcolor
        let toastObject: ToastObject = ToastObject(viewToast: toastView, index: arrayViewToast.count, actionCompleted: actionWhenCompleted)
        arrayViewToast.append(toastObject)
        toastView.layer.opacity = 0
        toastView.addToAllScreen()
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        queue.async(group: dispatchGroup, qos: .userInitiated) {
            semaphore.wait()
            toastView.setConstraintByCode(constraintArray: [
                toastView.centerXAnchor.constraint(equalTo: windowFix.centerXAnchor),//
                toastView.bottomAnchor.constraint(equalTo: windowFix.bottomAnchor, constant: -bottom)
//                toastView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//                toastView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottom)
            ])
            sleep(0)
            semaphore.signal()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                UIView.animate(withDuration: 0.6, animations:  {
                    toastView.layer.opacity = 1
                } ){ (flag) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        //let _ = self.createTimer(timeInterval: 1, selector: #selector(self.hadleToast), repeats: false)
                        let selector = #selector(self.moveToNextTextField(sender:))
                        Timer.scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: ["index": toastObject.index,"action": toastObject.actionCompleted  as Any], repeats: false)
                    }
                }
            }
        }
    }
    @objc func moveToNextTextField(sender: Timer) {
        if let data = sender.userInfo as? [String: Any], let index = data["index"] {
            print(index)
            if !arrayViewToast.isEmpty {
                arrayViewToast.first?.viewToast.removeFromSuperview()
                arrayViewToast.removeFirst()
                if let action = data["action"] as? (() -> Void) {
                    action()
                }
                //arrayViewToast[index-1].viewToast.removeFromSuperview()
                //arrayViewToast.remove(at: index-1)
            }
        }
    }
//    @objc func hadleToast(){
//        if !arrayViewToast.isEmpty {
//            arrayViewToast.first?.removeFromSuperview()
//            arrayViewToast.removeLast()
//        }
//    }
    func showToast(sms:String, backgroundcolor:UIColor = .red,textcolor:UIColor = .white,bottom:CGFloat=96){
        if timerForToast != nil {
            return
        }
        timeIntervalForToast = 0.3
        let toastView = Toast001()
        toastView.label.text = sms
        toastView.label.textColor = textcolor
        toastView.rootView.backgroundColor = backgroundcolor
        toastView.layer.opacity = 0
        //toastView.rootView.layer.cornerRadius = toastView.label.bounds.size.height/2
        //CGFloat(toastView.label.numberOfLines)*(toastView.label.font.pointSize)/2
        toastView.rootView.clipsToBounds = true
        //timerForToast = self.createTimer(timeInterval: timeIntervalForToast, selector: #selector(handleTimerToast), repeats: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            UIView.animate(withDuration: 0.3,animations:  {
                toastView.layer.opacity = 0
            }, completion: { (flag) in
                toastView.removeFromSuperview()
            })

        }
        let centerContrain = toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        let bottomContrain = toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor,constant: -bottom)
        showPopup(viewBackgroundForPopup: nil, viewWantPop: toastView, frame: .init(), animationIn: {
            UIView.animate(withDuration: 0.3) {
                toastView.layer.opacity = 1
            }
        }, animationOut: nil, constraintByCode: [centerContrain, bottomContrain])
        //showPopupStrechHeight(popView: toastView, width: nil, top: top, isNoBackground: true, isToast: true, alpha: 1, color: .red)
    }
    // show alert strech height ------------------
    func showPopupStrechHeight(popView: BaseView, width: CGFloat?, top:CGFloat,isNoBackground:Bool=false, isToast:Bool=false, alpha:CGFloat=0.3, color:UIColor = .white){
        backgroundViewForPopupView = BaseView(frame: UIScreen.main.bounds)
        guard let backgroundViewForPopupView = backgroundViewForPopupView else{
            return
        }
        //let alpha: CGFloat = isNoBackground ? 0.0 : 0.3
        backgroundViewForPopupView.backgroundColor = color.withAlphaComponent(alpha)
        if !isNoBackground {
            backgroundViewForPopupView.addToAllScreen()
        }
        backgroundViewForPopupView.addTapGesture()
        backgroundViewForPopupView.tapHanle = { (tapgesture: UITapGestureRecognizer) in
            backgroundViewForPopupView.removeFromSuperview()
            self.pop?.removeFromSuperview()
        }
        pop = popView
        guard let pop = pop else{
            return
        }
        pop.addToAllScreen()
        var constrains: [NSLayoutConstraint] = [
            //pop.widthAnchor.constraint(equalToConstant: width),
            pop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pop.topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        ]
        if let width = width {
            let cons = pop.widthAnchor.constraint(equalToConstant: width)
            constrains.append(cons)
        }
        pop.setConstraintByCode(constraintArray: constrains)
        if isToast {
            //            timerForToast = self.createTimer(timeInterval: timeIntervalForToast, selector: #selector(handleTimerToast), repeats: true)
        }
    }
    
    @objc func handleTimerToast(){
        if countForToast > timeForToast {
            countForToast = 0
            timerForToast?.invalidate()
            timerForToast = nil
            removePopup1()
        }
        countForToast += 1
    }
    func removePopup1(){
        backgroundViewForPopupView?.removeFromSuperview()
        self.pop?.removeFromSuperview()
    }
    // show alert strech height ------------------
    func showAlertStrechHeight1(){
        let popview = TestView()
        popview.backgroundColor = .yellow
        showPopup(popupPosition: .any, popView: popview, isAnimation: true)
        popview.translatesAutoresizingMaskIntoConstraints = false
        popview.widthAnchor.constraint(equalToConstant: 356).isActive = true
        popview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        popview.label.text = "Đó là điều chưa từng có trong lịch sử thị trường chứng khoán (TTCK) Việt Nam, giá trị giao dịch chỉ trong phiên buổi sáng đã vượt 20.000 tỷ đồng. Riêng sáng 1/6, giá trị giao dịch trên sàn HSX đã vượt mức 21.700 tỷ đồng Đó là điều chưa từng có trong lịch sử thị trường chứng khoán (TTCK) Việt Nam, giá trị giao dịch chỉ trong phiên buổi sáng đã vượt 20.000 tỷ đồng. Riêng sáng 1/6, giá trị giao dịch trên sàn HSX đã vượt mức 21.700 tỷ đồng"
    }
    
    // action when save image to photos -------------
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // save image to photos -------------
    func saveImageToPhotos(imgData: UIImage){
        //imgData.saveToPhotos(selector: #selector(image(_:didFinishSavingWithError:contextInfo:)))
        UIImageWriteToSavedPhotosAlbum(imgData, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func coordbustBase(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                }
            }
            return
        }
        guard let data = data else {
            Commons.hideLoading(self.view)
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Server không phản hồi", inView: self.view, didFinishDismiss: nil)
            return
        }
        //let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        self.shitDic = nil
        self.code = nil
        self.sms = nil
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            self.shitDic = shitDic
            self.code = code
            self.sms = sms
            
        }else{
            return
        }
    }
    
    func callbackBase(_ data:Data?,_ respawn:URLResponse?,_ errur:Error?)->Void{
        
        if let error=errur{
            Commons.showDialogNetworkError()
            Commons.hideLoading(self.view)
            let mesell=error as NSError
            if -1009==mesell.code{
                DispatchQueue.main.async{
                }
                DispatchQueue.main.asyncAfter(deadline:.now()+1.5){
                }
            }
            return
        }
        guard let data = data else {
            Commons.hideLoading(self.view)
            Commons.showDialogAlert(title: "THÔNG BÁO", content: "Server không phản hồi", inView: self.view, didFinishDismiss: nil)
            return
        }
        //let shit = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        let shit = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        print(shit)
        
        if let shitDic = shit as? [String:Any], let code = shitDic["Code"]  as? Int, let sms = shitDic["Message"]  as? String {
            Commons.hideLoading(self.view)
            self.shitDic = shitDic
            self.code = code
            self.sms = sms
            
        }else{
            self.shitDic = nil
            self.code = nil
            self.sms = nil
            return
        }
    }
    // popup setting -------------------------
    var animationOut: (()->Void)?
    typealias animationOutVar = (()->Void)?
    var arrayAnim: [animationOutVar] = [animationOutVar]()
    @objc func tapHandleForPopup(_ gesture:UITapGestureRecognizer ){
        if let v = gesture.view {
            //arrayAnim[v.tag]?()
            let dispatchGroup = DispatchGroup()
            let queue = DispatchQueue.main
            let semaphore = DispatchSemaphore(value: 1)
            queue.async(group: dispatchGroup, qos: .userInitiated) {
                semaphore.wait()
                self.arrayAnim[v.tag]?()
                sleep(0)
                semaphore.signal()
            }
            dispatchGroup.notify(queue: .main) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.arrayAnim.remove(at: v.tag)
                }
            }
        }
        
        //animationOut?()
    }
    // show Popup -----------------------------------
    func showPopup(target: Any? = nil,viewBackgroundForPopup: UIView?, isTapBackgroundView: Bool=true, isTapPopView: Bool=true, backgroundCoor:UIColor = .clear,viewWantPop:UIView, frame:CGRect,  animationIn: @escaping (()->Void), animationOut: (()->Void)?, constraintByCode: [NSLayoutConstraint]){
        if let vBackground =  viewBackgroundForPopup {
            
            vBackground.frame = UIScreen.main.bounds
            vBackground.backgroundColor = backgroundCoor
            vBackground.addToAllScreen()
            if isTapBackgroundView {
                //self.animationOut = animationOut
                arrayAnim.append(animationOut)
                vBackground.tag = arrayAnim.count-1 < 0 ? 0 : arrayAnim.count-1
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandleForPopup(_:)))
                vBackground.addGestureRecognizer(tap)
            }
        }
        viewWantPop.isHidden = true
        viewWantPop.addToAllScreen()
        if isTapPopView {
            self.animationOut = animationOut
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandleForPopup))
            viewWantPop.addGestureRecognizer(tap)
        }
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        queue.async(group: dispatchGroup, qos: .userInitiated) {
            semaphore.wait()
            viewWantPop.setConstraintByCode(constraintArray: constraintByCode)
            sleep(0)
            semaphore.signal()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                animationIn()
            }
        }
        
    }
}





