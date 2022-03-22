//
//  BasePopUp.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BaseViewForPopup: BaseView {
    var actionWhenTouchUp: (() -> Void)?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actionWhenTouchUp?()
    }
}

//class BasePopUpViewController: TPBaseViewController {
//    static let  shared = BasePopUpViewController()
//    var animationOut: (()->Void)?
//    @objc func tapHandleForPopup(){
//        animationOut?()
//    }
//    // show Popup -----------------------------------
//        func showPopup(target: Any? = nil,viewBackgroundForPopup: UIView?, isTapBackgroundView: Bool=true, isTapPopView: Bool=true, backgroundCoor:UIColor = .clear,viewWantPop:UIView, frame:CGRect,  animationIn: @escaping (()->Void), animationOut: (()->Void)?, constraintByCode: [NSLayoutConstraint]){
//            if let vBackground =  viewBackgroundForPopup {
//                vBackground.frame = UIScreen.main.bounds
//                vBackground.backgroundColor = backgroundCoor
//                vBackground.addToAllScreen()
//                if isTapBackgroundView {
//                    self.animationOut = animationOut
//                    let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandleForPopup))
//                    vBackground.addGestureRecognizer(tap)
//                }
//            }
//            viewWantPop.addToAllScreen()
//            if isTapPopView {
//                self.animationOut = animationOut
//                let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandleForPopup))
//                viewWantPop.addGestureRecognizer(tap)
//            }
//            let dispatchGroup = DispatchGroup()
//            let queue = DispatchQueue.main
//            let semaphore = DispatchSemaphore(value: 1)
//            queue.async(group: dispatchGroup, qos: .userInitiated) {
//                semaphore.wait()
//                viewWantPop.setConstraintByCode(constraintArray: constraintByCode)
//                sleep(0)
//                semaphore.signal()
//            }
//            dispatchGroup.notify(queue: .main) {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    animationIn()
//                }
//            }
//
//        }
//}

extension UIViewController {
    
//    func showPopup(viewBackgroundForPopup: UIView?, isTapBackgroundView: Bool=true, isTapPopView: Bool=true, backgroundCoor:UIColor = .clear,viewWantPop:UIView, frame:CGRect,  animationIn: @escaping (()->Void), animationOut: (()->Void)?, constraintByCode: [NSLayoutConstraint]){
//        BasePopUp().showPopup(target: self, viewBackgroundForPopup: viewBackgroundForPopup, isTapBackgroundView: isTapBackgroundView, isTapPopView: isTapPopView, backgroundCoor: backgroundCoor, viewWantPop: viewWantPop, frame: frame, animationIn: animationIn, animationOut: animationOut, constraintByCode: constraintByCode)
//    }
    
    // show Popup -----------------------------------
    func showPopup1(viewBackgroundForPopup: BaseViewForPopup?, isTapBackgroundView: Bool=true, isTapPopView: Bool=true, backgroundCoor:UIColor = .clear,viewWantPop:BaseViewForPopup, frame:CGRect,  animationIn: @escaping (()->Void), animationOut: (()->Void)?, constraintByCode: [NSLayoutConstraint]){
        if let vBackground =  viewBackgroundForPopup {
            vBackground.frame = UIScreen.main.bounds
            vBackground.backgroundColor = backgroundCoor
            vBackground.addToAllScreen()
            if isTapBackgroundView {
                vBackground.actionWhenTouchUp = {
                    animationOut?()
                }
            }
        }
        viewWantPop.addToAllScreen()
        if isTapPopView {
            viewWantPop.actionWhenTouchUp = {
                animationOut?()
            }
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


extension BaseViewControllers {
    
    
    func showPopupCenter(viewWantPop: UIView, height: CGFloat?, lef: CGFloat, right: CGFloat){
        let viewBackgroundForPopup:UIView? = UIView()
        //let viewWantPop = UIView()
        let frame = CGRect.init()
        
        var heightConstraint: NSLayoutConstraint?
        if let height = height {
            heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: height)
        }
        let centerConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 150)
        
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: lef)
        let rightConstraint = viewWantPop.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -right)
        var arrayContraints: [NSLayoutConstraint] = [centerConstraint, leftConstraint, rightConstraint ]
        if let heightConstraint = heightConstraint {
            arrayContraints.append(heightConstraint)
        }
        
        
        showPopup(viewBackgroundForPopup: viewBackgroundForPopup, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.lightGray.withAlphaComponent(0.3), viewWantPop: viewWantPop, frame: frame, animationIn: {
            viewWantPop.isHidden = false
            centerConstraint.constant = 0
                UIView.animate(withDuration: 0.1) {
                    viewWantPop.superview?.layoutIfNeeded()
                }
        }, animationOut: {
            centerConstraint.constant = 150
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                viewWantPop.superview?.layoutIfNeeded()
            }, completion: { flg in
                viewWantPop.removeFromSuperview()
                viewBackgroundForPopup?.removeFromSuperview()
            })
        }, constraintByCode: arrayContraints)
    }
    
    func showPopupBootom(viewWantPop: UIView, height: CGFloat?, lef: CGFloat, right: CGFloat){
        let viewBackgroundForPopup:UIView? = UIView()
        //let viewWantPop = UIView()
        let frame = CGRect.init()
        
        var heightConstraint: NSLayoutConstraint?
        let bottomConstraint = viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 150)
        if let height = height {
            heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: height)
        }
        
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: lef)
        let rightConstraint = viewWantPop.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -right)
        var arrayContraints: [NSLayoutConstraint] = [bottomConstraint, leftConstraint, rightConstraint ]
        if let heightConstraint = heightConstraint {
            arrayContraints.append(heightConstraint)
        }
        
        
        showPopup(viewBackgroundForPopup: viewBackgroundForPopup, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.lightGray.withAlphaComponent(0.3), viewWantPop: viewWantPop, frame: frame, animationIn: {
            viewWantPop.isHidden = false
            bottomConstraint.constant = 0
                UIView.animate(withDuration: 0.1) {
                    viewWantPop.superview?.layoutIfNeeded()
                }
        }, animationOut: {
            bottomConstraint.constant = 150
            //bottomConstraint.constant = 0
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                viewWantPop.superview?.layoutIfNeeded()
            }, completion: { flg in
                viewWantPop.removeFromSuperview()
                viewBackgroundForPopup?.removeFromSuperview()
            })
        }, constraintByCode: arrayContraints)
    }
    
    func showListPopup(dataArrayName:[String]){
        let viewWantPop = FTBaseTableView()
        //let viewWantPop = UIView()
        viewWantPop.backgroundColor = .white
        viewWantPop.cornerRadius = 8
        viewWantPop.clipsToBounds = true
        viewWantPop.borderWidth = 0.3
        viewWantPop.borderColor = UIColor.lightGray
        
        //viewWantPop.tbv.estimatedRowHeight=64
        //viewWantPop.tbv.rowHeight=UITableView.automaticDimension
        hiddenNavigation(isHidden: true)
        viewWantPop.numberOfSections = dataArrayName.count
        viewWantPop.numberRow = 1
        //viewWantPop.setBackgroundColor(color: .clear)
        //viewWantPop.tbv.disableScroll()
        //viewWantPop.registerCellWithNib(nib: UINib(nibName: "TitleAndSubTitleTableViewCell", bundle: nil), idCell: "cell")
        viewWantPop.hideSpactorCellVarible = false
        viewWantPop.heightOfCell = 48
        //tbvView.heightForHeaderInSection = 1
        viewWantPop.heightForHeaderInSectionClorsure = { tbv, session in
            let height: CGFloat = session == 0 ? 0 : 0
            return height
        }
        let vHeader = UIView()
        vHeader.backgroundColor = .red
        viewWantPop.viewForHeaderInSection = 1
        viewWantPop.CreateCellClorsure = {[weak self ] tbv, indexPath in
            guard let selfWeak = self else {
                return BaseTableViewCell()
            }
            let cell = BaseTableViewCell()
            //cell.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
            cell.textLabel?.text = dataArrayName[indexPath.section]
            cell.enableHeighlight = true
            cell.actionWhenClick = {
                selfWeak.cellShowListPopupPressed(indexpath: indexPath)
            }
            return cell
        }
        
        viewWantPop.delegateDatasource {
            
        }
    
        
        
        let frame = CGRect(x: 23, y: 56, width: sizeScreen.width - 46, height: 378)
        
        
//        let viewBackgroundForPopup = BaseViewForPopup()
//        let viewWantPop = BaseViewForPopup()
//        viewWantPop.backgroundColor = .green
//        let frame = CGRect.init()
        //let topConstraint = viewWantPop.topAnchor.constraint(equalTo: window.topAnchor)
        let centerYConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 150)
        let heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: 218)
        let centerConstraint = viewWantPop.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 16)
        let viewBackgroundForPopup:UIView? = UIView()
        
        func removePop(){
            centerYConstraint.constant = 150
            UIView.animate(withDuration: 0.3) {
                viewWantPop.superview?.layoutIfNeeded()
            } completion: { (_) in
                viewWantPop.removeFromSuperview()
                viewBackgroundForPopup?.removeFromSuperview()
                //removePop()
            }
        }
        
        showPopup(viewBackgroundForPopup: viewBackgroundForPopup, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.lightGray.withAlphaComponent(0.3), viewWantPop: viewWantPop, frame: frame, animationIn: {
            
            viewWantPop.isHidden = false
            centerYConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                viewWantPop.superview?.layoutIfNeeded()
            }
            
        }, animationOut: {
            centerYConstraint.constant = 150
            UIView.animate(withDuration: 0.3) {
                viewWantPop.superview?.layoutIfNeeded()
            } completion: { (_) in
                viewWantPop.removeFromSuperview()
                viewBackgroundForPopup?.removeFromSuperview()
                //removePop()
            }
            
        }, constraintByCode: [centerYConstraint,heightConstraint,centerConstraint,leftConstraint])
        
        
        
//        showPopup(isHaveBackground: true, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.lightGray.withAlphaComponent(0.3), viewWantPop: viewWantPop, frame: frame, animationIn: { (viewPop) in
//            //viewPop.frame.origin.y = sizeScreen.height
//            viewPop.layer.opacity = 0
//            UIView.animate(withDuration: 0.3) {
//                viewPop.layer.opacity = 1
//            }
//        }, animationOut: { (viewPop) in
//            //viewPop.frame.origin.y = sizeScreen.height
//            viewPop.layer.opacity = 0
//        }, constraintByCode: {
//            viewPopup!.setConstraintByCode(constraintArray: [
//                viewPopup!.centerYAnchor.constraint(equalTo: window.centerYAnchor),
//                viewPopup!.centerXAnchor.constraint(equalTo: window.centerXAnchor),
//                viewPopup!.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 16),
//                viewPopup!.heightAnchor.constraint(lessThanOrEqualToConstant: sizeScreen.height/3),
//                viewPopup!.heightAnchor.constraint(equalToConstant: 298)
//                //viewPopup!.heightAnchor.constraint(greaterThanOrEqualToConstant: 198)
//            ])
//        }
//        )
        
    }
}
