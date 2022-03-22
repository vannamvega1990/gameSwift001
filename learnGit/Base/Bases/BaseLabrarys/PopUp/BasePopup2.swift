//
//  BasePopup2.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/8/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class BgPopupView: UIView {
    var actionTouch:(()->Void)?
    override func layoutSubviews() {
        super.layoutSubviews()
        print("-------")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        actionTouch?()
    }
    
}

var bgForPopup: [BgPopupView] = [BgPopupView]()
var arrayViewPopup: [UIView] = [UIView]()

var currentPopVC = UIViewController()

extension BaseViewControllers {
    
    
    func hidePopupSuko(typeAnimation:TypeAnimation, complete: @escaping (()-> Void)){
        
        if !arrayViewPopup.isEmpty {
            if let centerContrain = arrayViewPopup.last?.centerYConstraint {
                switch typeAnimation {
                case .Move:
                    centerContrain.constant = 150
                    UIView.animate(withDuration: 0.1) {
                        arrayViewPopup.last?.superview?.layoutIfNeeded()
                    } completion: { (flag) in
                        arrayViewPopup.last?.removeFromSuperview()
                        arrayViewPopup.removeLast()
                        
                        if arrayViewPopup.isEmpty {
                            bgForPopup.last?.removeFromSuperview()
                            if !bgForPopup.isEmpty {
                                bgForPopup.removeLast()
                            }
                            complete()
                        }
                    }
                    
                    break
                case .Opacity:
                    UIView.animate(withDuration: 0.3) {
                        arrayViewPopup.last?.layer.opacity = 0
                    } completion: { (flag) in
                        if !arrayViewPopup.isEmpty {
                            arrayViewPopup.last?.removeFromSuperview()
                            arrayViewPopup.removeLast()
                            if arrayViewPopup.isEmpty {
                                bgForPopup.last?.removeFromSuperview()
                                if !bgForPopup.isEmpty {
                                    bgForPopup.removeLast()
                                }
                                complete()
                            }
                        }
                    }
                    break
                case .None:
                    break
                }
            }
            
            if let botomContrain = arrayViewPopup.last?.bottomConstraint {
                switch typeAnimation {
                case .Move:
                    botomContrain.constant = 150
                    UIView.animate(withDuration: 0.1) {
                        arrayViewPopup.last?.superview?.layoutIfNeeded()
                    } completion: { (flag) in
                        arrayViewPopup.last?.removeFromSuperview()
                        arrayViewPopup.removeLast()
                        
                        if arrayViewPopup.isEmpty {
                            bgForPopup.last?.removeFromSuperview()
                            if !bgForPopup.isEmpty {
                                bgForPopup.removeLast()
                            }
                        }
                    }
                    break
                case .Opacity:
                    UIView.animate(withDuration: 0.3) {
                        arrayViewPopup.last?.layer.opacity = 0
                    } completion: { (flag) in
                        if !arrayViewPopup.isEmpty {
                            arrayViewPopup.last?.removeFromSuperview()
                            arrayViewPopup.removeLast()
                            if arrayViewPopup.isEmpty {
                                bgForPopup.last?.removeFromSuperview()
                                if !bgForPopup.isEmpty {
                                    bgForPopup.removeLast()
                                }
                            }
                        }
                    }
                    break
                case .None:
                    break
                }
            }
        }
    }

    func showPopupSukoCenter(viewWantPop: UIView, typeAnimation: TypeAnimation = .Move , isBg: Bool = true, bgColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3), lef: CGFloat, right: CGFloat, height: CGFloat?){
        currentPopVC = self
        if isBg {
            if bgForPopup.isEmpty {
                let bgForPopup1:BgPopupView? = BgPopupView()
                bgForPopup1!.backgroundColor = bgColor
                //bgForPopup!.addToAllScreen()
                bgForPopup1!.frame = bounds
                //addSubViews([bgForPopup1!])
                bgForPopup1!.addToAllScreen()
                bgForPopup1!.actionTouch = {
                    self.hidePopupSuko(typeAnimation: typeAnimation, complete: {
                        
                    })
                }
                //let tap = UITapGestureRecognizer(target: self, action: #selector(tapBG))
                //bgForPopup1!.addGestureRecognizer(tap)
                bgForPopup.append(bgForPopup1!)
            }
            
        }
        viewWantPop.addToAllScreen()
        viewWantPop.isHidden = true
        arrayViewPopup.append(viewWantPop)
        var heightConstraint: NSLayoutConstraint?
        if let height = height {
            heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: height)
        }
        var centerConstraint: NSLayoutConstraint!
        switch typeAnimation {
        case .Move:
            centerConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 150)
            break
        case .Opacity:
            centerConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 0)
            break
        case .None:
            centerConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 0)
            break
        }
        //let centerConstraint = viewWantPop.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 150)
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: lef)
        let rightConstraint = viewWantPop.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -right)
        var arrayContraints: [NSLayoutConstraint] = [centerConstraint, leftConstraint, rightConstraint ]
        if let heightConstraint = heightConstraint {
            arrayContraints.append(heightConstraint)
        }
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        queue.async(group: dispatchGroup, qos: .userInitiated) {
            semaphore.wait()
            viewWantPop.setConstraintByCode(constraintArray: arrayContraints)
            sleep(0)
            semaphore.signal()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                //animationIn()
                
                switch typeAnimation {
                case .Move:
                    viewWantPop.isHidden = false
                    centerConstraint.constant = 0
                    UIView.animate(withDuration: 0.1) {
                        viewWantPop.superview?.layoutIfNeeded()
                    }
                    break
                case .Opacity:
                    viewWantPop.layer.opacity = 0
                    viewWantPop.isHidden = false
                    UIView.animate(withDuration: 0.3) {
                        viewWantPop.layer.opacity = 1
                    }
                    break
                case .None:
                    break
                }
                
            }
        }
        
        
        
    }
    
    
    func showPopupSukoBottom(viewWantPop: UIView, typeAnimation: TypeAnimation = .Move, isBg: Bool = true, bgColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3), lef: CGFloat, right: CGFloat, height: CGFloat?){
        currentPopVC = self
        if isBg {
            if bgForPopup.isEmpty {
                let bgForPopup1:BgPopupView? = BgPopupView()
                bgForPopup1!.backgroundColor = bgColor
                //bgForPopup!.addToAllScreen()
                bgForPopup1!.frame = bounds
                //addSubViews([bgForPopup1!])
                bgForPopup1!.addToAllScreen()
                bgForPopup1!.actionTouch = {
                    self.hidePopupSuko(typeAnimation: typeAnimation, complete: {
                        
                    })
                }
                //let tap = UITapGestureRecognizer(target: self, action: #selector(tapBG))
                //bgForPopup1!.addGestureRecognizer(tap)
                bgForPopup.append(bgForPopup1!)
            }
            
        }
        viewWantPop.addToAllScreen()
        viewWantPop.isHidden = true
        arrayViewPopup.append(viewWantPop)
        var heightConstraint: NSLayoutConstraint?
        let bottomConstraint: NSLayoutConstraint!
            //viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 150)
        switch typeAnimation {
        case .Move:
            bottomConstraint = viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 150)
            break
        case .Opacity:
            bottomConstraint = viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0)
            break
        case .None:
            bottomConstraint = viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0)
            break
        }
        if let height = height {
            heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: height)
        }
        
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: lef)
        let rightConstraint = viewWantPop.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -right)
        var arrayContraints: [NSLayoutConstraint] = [bottomConstraint, leftConstraint, rightConstraint ]
        if let heightConstraint = heightConstraint {
            arrayContraints.append(heightConstraint)
        }
        
        let dispatchGroup = DispatchGroup()
        let queue = DispatchQueue.main
        let semaphore = DispatchSemaphore(value: 1)
        queue.async(group: dispatchGroup, qos: .userInitiated) {
            semaphore.wait()
            viewWantPop.setConstraintByCode(constraintArray: arrayContraints)
            sleep(0)
            semaphore.signal()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                //animationIn()
                switch typeAnimation {
                case .Move:
                    bottomConstraint.constant = 0
                    viewWantPop.isHidden = false
                    UIView.animate(withDuration: 0.1) {
                        viewWantPop.superview?.layoutIfNeeded()
                    }
                    break
                case .Opacity:
                    viewWantPop.layer.opacity = 0
                    viewWantPop.isHidden = false
                    UIView.animate(withDuration: 0.1) {
                        viewWantPop.layer.opacity = 1
                    }
                    break
                case .None:
                    bottomConstraint.constant = 0
                    viewWantPop.isHidden = false
                    UIView.animate(withDuration: 0.1) {
                        viewWantPop.superview?.layoutIfNeeded()
                    }
                    break
                }
                
                
            }
        }
        
        
        
    }
    
    func showListPopup2(){
        
    }
    func showListPopup2(dataArrayName:[String]){
        let viewWantPop = FTBaseTableView()
        //let viewWantPop = UIView()
        viewWantPop.backgroundColor = .white
        viewWantPop.cornerRadius = 8
        viewWantPop.clipsToBounds = true
        viewWantPop.borderWidth = 0.3
        viewWantPop.borderColor = UIColor.lightGray
        viewWantPop.numberOfSections = dataArrayName.count
        viewWantPop.numberRow = 1
        viewWantPop.hideSpactorCellVarible = false
        viewWantPop.heightOfCell = 48
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
                selfWeak.hidePopupSuko(typeAnimation: .Move, complete: {
                    selfWeak.cellShowListPopupPressed(indexpath: indexPath)
                })
            }
            return cell
        }
        
        viewWantPop.delegateDatasource {
        }
        self.showPopupSukoCenter(viewWantPop: viewWantPop, typeAnimation: .Move , isBg: true, lef: 12, right: 12, height: sizeScreen.height / 3)
    }
    
    @objc func tapBG(){

        
    }
    
}
