//
//  BasePopup3.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TestTrumpPopupVC: FTBaseViewController {
    
    override func cellShowListPopupPressed(indexpath: IndexPath) {
        
        let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
        hidePopupWithAnimTrump(typeAnimation: anim) {
            print(indexpath)
        }
    }
    
    let textFild1 = UITextField()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setBackgroundColor()
        textFild1.frame = CGRect(x: 16, y: 16, width: 198, height: 46)
        textFild1.placeholder = "noi dung"
        view.addSubview(textFild1)
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("btn test", for: .normal)
        btn.frame = CGRect(x: 189, y: 196, width: 98, height: 46)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
        
        let view1 = UIView(frame: CGRect(x: 50, y: 50, width: 128, height: 128))
        let view2 = UIView(frame: CGRect(x: 200, y: 200, width: 128, height: 128))

        let tap = CGPoint(x: 10, y: 10)
        let convertedTap = view1.convert(tap, to: view2)
        //let convertedTap = view1.convert(tap, to: window)
        print(convertedTap)
        
    }
    @objc func editingChanged(){
        filteredData = textFild1.text!.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: textFild1.text!, options: .caseInsensitive) != nil
        })
        print(filteredData.count)
        tbv.numberOfSections = filteredData.count
        tbv.reload()
    }
    let data = ["noidung","noidung2", "kinhte"]
    var filteredData:[String] = []
    
    var tbv: FTBaseTableView!
    
    @objc func xuly(){
        let v = BaseView()
        v.backgroundColor = .green
        //showPopupTrumpCenter(viewWantPop: v, lef: 16, right: 16, height: 190)
        //showPopupTrumpAnyPosition(viewWantPop: v, top: 12, lef: 16, right: 16, height: 378)
        let nib = UINib(nibName: "TitleAndTitleTableViewCell", bundle: nil)
        let CreateCellClorsure1:((UITableView,IndexPath)->BaseTableViewCell)? = { tbv, indexPath in
            let cell = tbv.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TitleAndTitleTableViewCell
            cell.actionWhenClick = {
                self.cellShowListPopupPressed(indexpath: indexPath)
            }
            return cell
        }
        
        textFild1.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        filteredData = data
        tbv = self.showPopupTrumpList(dataArrayName: filteredData, topConstraint: 120, left: 0, right: 0, height: 376, customNibCell:nib, CreateCellClorsure: CreateCellClorsure1)
        textFild1.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let v = BaseView()
            v.backgroundColor = .yellow
            //self.showPopupTrumpBottom(viewWantPop: v, lef: 0, right: 0, height: 390)
            //self.showPopupTrumpList(dataArrayName:["1","2", "3"])
            //self.showPopupTrumpCenter(viewWantPop: v, lef: 16, right: 16, height: 390)
        }
    }
   
}


//let bgPopTrumpView = viewParm()
//var arrayTrumpViewPop: [UIView] = []

var bgPopTrumpView: viewParm!
var arrayTrumpViewPop: [BaseView]!

enum TypeAnimation {
    case Move
    case Opacity
    case None
}

extension BaseViewControllers {
    
    func showPopupTrump(viewWantPop: BaseView, isBg:Bool=true, isTapBg: Bool = true, bgColor: UIColor? = nil){
        bgPopTrumpView.backgroundColor = bgColor ?? UIColor.lightGray.withAlphaComponent(0.6)
        bgPopTrumpView.frame = window.bounds
        if isBg {
            bgPopTrumpView.addToAllScreen()
        }
        arrayTrumpViewPop.append(viewWantPop)
        viewWantPop.addToAllScreen()
        let selector3 = #selector(self.viewParamTouch(sender:))
        let tap = UITapGestureRecognizer(target: self, action: selector3)
        if isTapBg {
            bgPopTrumpView.addGestureRecognizer(tap)
        }
    }
    
    func hideAPopupTrump(at index: Int){
        arrayTrumpViewPop[index].removeFromSuperview()
        arrayTrumpViewPop.remove(at: index)
        if arrayTrumpViewPop.isEmpty {
            bgPopTrumpView.removeFromSuperview()
        }
    }
    
    func hideAPopupTrump(at viewPop: BaseView){
        
        if let index = arrayTrumpViewPop.firstIndex(of: viewPop) {
            arrayTrumpViewPop[index].removeFromSuperview()
            arrayTrumpViewPop.remove(at: index)
            if arrayTrumpViewPop.isEmpty {
                bgPopTrumpView.removeFromSuperview()
            }
        }
    }
    
    
    
    func removeAllPopupTrump(){
        for each in arrayTrumpViewPop {
            each.removeFromSuperview()
        }
        bgPopTrumpView.removeFromSuperview()
        arrayTrumpViewPop.removeAll()
        bgPopTrumpView.removeFromSuperview()
    }
    
    @objc func viewParamTouch(sender: UITapGestureRecognizer) {
        if let _ = sender.view{
            if !arrayTrumpViewPop.isEmpty {
                //hideAPopupTrump(at: arrayTrumpViewPop.last!) TypeAnimation
                closureHidePopupTrump?()
                let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
                hidePopupWithAnimTrump(typeAnimation: anim) {
                }
            }
        }
    }
    
    func hidePopupWithAnimTrump(typeAnimation:TypeAnimation, complete: @escaping (()-> Void)){
        if !arrayTrumpViewPop.isEmpty {
            if let centerContrain = arrayTrumpViewPop.last?.centerYConstraint {
                switch typeAnimation {
                case .Move:
                    centerContrain.constant = 150
                    UIView.animate(withDuration: 0.1) {
                        arrayTrumpViewPop.last?.superview?.layoutIfNeeded()
                    } completion: { (flag) in
                        arrayTrumpViewPop.last?.removeFromSuperview()
                        arrayTrumpViewPop.removeLast()
                        
                        if arrayTrumpViewPop.isEmpty {
                            bgPopTrumpView.removeFromSuperview()
                            
                            complete()
                        }
                    }
                    
                    break
                case .Opacity:
                    UIView.animate(withDuration: 0.3) {
                        arrayTrumpViewPop.last?.layer.opacity = 0
                    } completion: { (flag) in
                        if !arrayTrumpViewPop.isEmpty {
                            arrayTrumpViewPop.last?.removeFromSuperview()
                            arrayTrumpViewPop.removeLast()
                            if arrayTrumpViewPop.isEmpty {
                                bgPopTrumpView.removeFromSuperview()
                                
                                complete()
                            }
                        }
                    }
                    break
                case .None:
                    break
                }
            }
            
            if let botomContrain = arrayTrumpViewPop.last?.bottomConstraint {
                switch typeAnimation {
                case .Move:
                    botomContrain.constant = 150
                    UIView.animate(withDuration: 0.1) {
                        arrayTrumpViewPop.last?.superview?.layoutIfNeeded()
                    } completion: { (flag) in
                        arrayTrumpViewPop.last?.removeFromSuperview()
                        arrayTrumpViewPop.removeLast()
                        
                        if arrayTrumpViewPop.isEmpty {
                            bgPopTrumpView.removeFromSuperview()
                            
                            complete()
                        }
                    }
                    break
                case .Opacity:
                    UIView.animate(withDuration: 0.3) {
                        arrayTrumpViewPop.last?.layer.opacity = 0
                    } completion: { (flag) in
                        if !arrayTrumpViewPop.isEmpty {
                            arrayTrumpViewPop.last?.removeFromSuperview()
                            arrayTrumpViewPop.removeLast()
                            if arrayTrumpViewPop.isEmpty {
                                bgPopTrumpView.removeFromSuperview()
                                
                                complete()
                            }
                        }
                    }
                    break
                case .None:
                    break
                }
            }
            
            if let topContrain = arrayTrumpViewPop.last?.topConstraint {
                switch typeAnimation {
                case .Move:
                    topContrain.constant = topContrain.constant + 150
                    UIView.animate(withDuration: 0.1) {
                        arrayTrumpViewPop.last?.superview?.layoutIfNeeded()
                    } completion: { (flag) in
                        arrayTrumpViewPop.last?.removeFromSuperview()
                        arrayTrumpViewPop.removeLast()
                        
                        if arrayTrumpViewPop.isEmpty {
                            bgPopTrumpView.removeFromSuperview()
                            
                            complete()
                        }
                    }
                    break
                case .Opacity:
                    UIView.animate(withDuration: 0.3) {
                        arrayTrumpViewPop.last?.layer.opacity = 0
                    } completion: { (flag) in
                        if !arrayTrumpViewPop.isEmpty {
                            arrayTrumpViewPop.last?.removeFromSuperview()
                            arrayTrumpViewPop.removeLast()
                            if arrayTrumpViewPop.isEmpty {
                                bgPopTrumpView.removeFromSuperview()
                                
                                complete()
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
    
    func showPopupTrumpAnyPosition(viewWantPop: BaseView, typeAnimation: TypeAnimation = .Move, isBg: Bool = true, bgColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3), top: CGFloat, lef: CGFloat, right: CGFloat, height: CGFloat?){
        
        viewWantPop.object = typeAnimation
        showPopupTrump(viewWantPop: viewWantPop, isBg:isBg, bgColor: bgColor)
        viewWantPop.isHidden = true
        var heightConstraint: NSLayoutConstraint?
        let topConstraint: NSLayoutConstraint!
            //viewWantPop.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 150)
        switch typeAnimation {
        case .Move:
            topConstraint = viewWantPop.topAnchor.constraint(equalTo: window.topAnchor, constant: top + 150)
            break
        case .Opacity:
            topConstraint = viewWantPop.topAnchor.constraint(equalTo: window.topAnchor, constant: top)
            break
        case .None:
            topConstraint = viewWantPop.topAnchor.constraint(equalTo: window.topAnchor, constant: top)
            break
        }
        if let height = height {
            heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: height)
        }
        
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: lef)
        let rightConstraint = viewWantPop.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -right)
        var arrayContraints: [NSLayoutConstraint] = [topConstraint, leftConstraint, rightConstraint ]
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
                    topConstraint.constant = top
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
                    topConstraint.constant = top
                    viewWantPop.isHidden = false
                    UIView.animate(withDuration: 0.1) {
                        viewWantPop.superview?.layoutIfNeeded()
                    }
                    break
                }
            }
        }
    }
    
    func showPopupTrumpBottom(viewWantPop: BaseView, typeAnimation: TypeAnimation = .Move, isBg: Bool = true, bgColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3), lef: CGFloat, right: CGFloat, height: CGFloat?){
        
        viewWantPop.object = typeAnimation
        showPopupTrump(viewWantPop: viewWantPop, isBg:isBg)
        
        
        viewWantPop.isHidden = true

         
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
    
    func showPopupTrumpCenter(viewWantPop: BaseView, isTapBg: Bool = true,  typeAnimation: TypeAnimation = .Move , isBg: Bool = true, bgColor: UIColor = UIColor.lightGray.withAlphaComponent(0.3), lef: CGFloat, right: CGFloat, height: CGFloat?){
        viewWantPop.object = typeAnimation
        showPopupTrump(viewWantPop: viewWantPop, isBg:isBg, isTapBg: isTapBg)
//        let selector3 = #selector(self.viewParamTouch(sender:))
//        let tap = UITapGestureRecognizer(target: self, action: selector3)
//        bgPopTrumpView.addGestureRecognizer(tap)
        
        viewWantPop.isHidden = true
        
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
    
    func showPopupTrumpList(tbv: FTBaseTableView? = nil,bgColor:UIColor? = nil,  dataArrayName:[String]=[],subArrayName:[String]=[String](), topConstraint: CGFloat? = nil, left: CGFloat = 12, right: CGFloat = 12, height: CGFloat? = window.bounds.height / 3, customNibCell:UINib? = nil, CreateCellClorsure:((UITableView,IndexPath)->UITableViewCell)? = nil) -> FTBaseTableView{
        var viewWantPop = FTBaseTableView()
        //let viewWantPop = UIView()
        if let tbv1 = tbv {
            viewWantPop = tbv1
        }else{
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
        }
        if let customNibCell1 = customNibCell {
            viewWantPop.registerCellWithNib(nib: customNibCell1, idCell: "cell")
            viewWantPop.CreateCellClorsure = CreateCellClorsure
        }else{
            viewWantPop.CreateCellClorsure = {[weak self ] tbv, indexPath in
                guard let selfWeak = self else {
                    return BaseTableViewCell()
                }
                //let cell = BaseTableViewCell()
                //cell.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
                let cell = BaseTableViewCell(style: .subtitle, reuseIdentifier: nil)
                //cell.backgroundColor = UIColor(rgb: 0x21232C, alpha: 1)
                cell.textLabel?.text = dataArrayName[indexPath.section]
                cell.textLabel?.font = .boldSystemFont(ofSize: 16)
                if !subArrayName.isEmpty {
                    cell.detailTextLabel?.text = subArrayName[indexPath.section]
                    cell.detailTextLabel?.font = .systemFont(ofSize: 14)
                }
                cell.enableHeighlight = true
                cell.actionWhenClick = {
    //                let anim = arrayTrumpViewPop.last!.object as! TypeAnimation
    //                selfWeak.hidePopupWithAnimTrump(typeAnimation: anim) {
    //                    selfWeak.cellShowListPopupPressed(indexpath: indexPath)
    //                }
                    selfWeak.cellShowListPopupPressed(indexpath: indexPath)
                }
                return cell
            }
        }
        viewWantPop.delegateDatasource {
        }
        if let topConstraint1 = topConstraint {
            //self.showPopupTrumpCenter(viewWantPop: viewWantPop, lef: 12, right: 12, height: window.bounds.height / 3)
            let bgcolor = bgColor ?? UIColor.lightGray.withAlphaComponent(0.3)
            self.showPopupTrumpAnyPosition(viewWantPop: viewWantPop, bgColor: bgcolor, top: topConstraint1, lef: left, right: right, height: height)
        }else{
            self.showPopupTrumpCenter(viewWantPop: viewWantPop, lef: left, right: right, height: height)
        }
        return viewWantPop
    }
 
    
    
}
