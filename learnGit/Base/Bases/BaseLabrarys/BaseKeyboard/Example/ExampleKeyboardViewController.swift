//
//  ExampleKeyboardViewController.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

class ExampleKeyboardViewController: UIViewController {
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet var v3: UIView!
    @IBOutlet weak var btnShowPopup: UIView!
    
    
    init() {
        super.init(nibName: "ExampleKeyboardViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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




