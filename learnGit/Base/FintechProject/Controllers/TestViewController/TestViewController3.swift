//
//  TestViewController3.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/27/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TestViewController3: BaseViewControllers {
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet var v3: UIView!
    @IBOutlet weak var btnShowPopup: UIView!
    
    
    init() {
        super.init(nibName: "TestViewController3", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func btnShowPopupPressed(_ sender: UIButton) {
        let viewBackgroundForPopup = UIView() //BaseViewForPopup()
        let viewWantPop = UIView() //BaseViewForPopup()
        viewWantPop.backgroundColor = .green
        let frame = CGRect.init()
        let topConstraint = viewWantPop.topAnchor.constraint(equalTo: window.topAnchor)
        let heightConstraint = viewWantPop.heightAnchor.constraint(equalToConstant: 156)
        let centerConstraint = viewWantPop.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        let leftConstraint = viewWantPop.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 16)
        showPopup(viewBackgroundForPopup: viewBackgroundForPopup, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.red.withAlphaComponent(0.3), viewWantPop: viewWantPop, frame: frame, animationIn: {
            
            topConstraint.constant = 500
            UIView.animate(withDuration: 0.3) {
                viewWantPop.superview?.layoutIfNeeded()
            }
            
        }, animationOut: {
            topConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                viewWantPop.superview?.layoutIfNeeded()
            } completion: { (_) in
                viewWantPop.removeFromSuperview()
                viewBackgroundForPopup.removeFromSuperview()
            }
            
        }, constraintByCode: [topConstraint,heightConstraint,centerConstraint,leftConstraint])
        
        
        
        let viewBackgroundForPopup2 = UIView() //BaseViewForPopup()
        let viewWantPop2 = UIView() //BaseViewForPopup()
        viewWantPop2.backgroundColor = .yellow
        let frame2 = CGRect.init()
        let topConstraint2 = viewWantPop2.topAnchor.constraint(equalTo: window.topAnchor)
        let heightConstraint2 = viewWantPop2.heightAnchor.constraint(equalToConstant: 156)
        let centerConstraint2 = viewWantPop2.centerXAnchor.constraint(equalTo: window.centerXAnchor)
        let leftConstraint2 = viewWantPop2.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 16)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showPopup(viewBackgroundForPopup: viewBackgroundForPopup2, isTapBackgroundView: true, isTapPopView: false, backgroundCoor: UIColor.green.withAlphaComponent(0.3), viewWantPop: viewWantPop2, frame: frame2, animationIn: {
                
                topConstraint2.constant = 500
                UIView.animate(withDuration: 0.3) {
                    viewWantPop2.superview?.layoutIfNeeded()
                }
                
            }, animationOut: {
                topConstraint2.constant = 0
                UIView.animate(withDuration: 0.3) {
                    viewWantPop2.superview?.layoutIfNeeded()
                } completion: { (_) in
                    viewWantPop2.removeFromSuperview()
                    viewBackgroundForPopup2.removeFromSuperview()
                }
                
            }, constraintByCode: [topConstraint2,heightConstraint2,centerConstraint2,leftConstraint2])
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print("--- keyboard height \(keyboardHeight)")
            
            //            var f = self.view.frame
            //            f.origin.y = -(26)
            //            self.view.frame = f
            
            let frameCurrenTextfild = currentUITextfild.superview?.convert(currentUITextfild.frame.origin, to: self.view)
                //currentUITextfild.convert(currentUITextfild.frame, to: view)
            print("--- frameCurrenTextfild \(frameCurrenTextfild!.y)")
            print("--- sizeScreen \(sizeScreen.height)")
            let possitionFromBottom = sizeScreen.height - frameCurrenTextfild!.y
            
            print("--- possitionFromBottom \(possitionFromBottom)")
            
            if possitionFromBottom - (currentUITextfild.frame.size.height + 16) <= keyboardHeight {
                self.view.frame.origin.y = -(keyboardHeight - possitionFromBottom + currentUITextfild.frame.size.height + 36)
            }
            if possitionFromBottom - self.view.frame.origin.y > sizeScreen.height - 156{
                self.view.frame.origin.y = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(keyboardWillHide),
                    name: UIResponder.keyboardWillHideNotification,
                    object: nil
                )
        //let tf1 = stack.subviews.first! as! BaseTextField
        var arrTextFild = [BaseTextField]()
        for each in stack.subviews {
            if let tf = each as? BaseTextField {
                arrTextFild.append(tf)
            }
            each.convert(each.frame, to: view)
        }
        addCustomToolBarForUITextfild(arrTextFild: arrTextFild)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("-----x stack: \(self.stack.frame.origin.x)-----y stack: \(self.stack.frame.origin.y)")
            for each in self.stack.subviews {
                let frame = each.convert(each.frame, to: self.view)
                
                let globalPoint = each.superview?.convert(each.frame.origin, to: self.view)
                
                print("-----x: \(globalPoint!.x)-----y: \(globalPoint!.y)")
            }
        }
        
        
        
    }
}



