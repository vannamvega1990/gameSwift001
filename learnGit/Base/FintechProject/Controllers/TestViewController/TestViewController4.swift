//
//  TestViewController4.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//


// animation Constraint By Code -----------------------------

import UIKit
//import PlaygroundSupport

class TestViewController4: UIViewController {

    let textView = UITextView()
    lazy var heightConstraint = textView.heightAnchor.constraint(equalToConstant: 50)
    lazy var topConstraint = textView.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 0)

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let lb = UILabel(frame: CGRect(x: 16, y: 98, width: 998, height: 198))
        lb.font = UIFont.boldSystemFont(ofSize: 98)
        let text = "YAAASSSSS!"
        lb.text = text
        print(text.sizeOfString(usingFont: lb.font))
        if lb.applyGradientWith(startColor: .red, endColor: .blue) {
            print("Gradient applied!")
        }
        else {
            print("Could not apply gradient")
            lb.textColor = .black
        }
        addSubViews([lb])
        
        let myText = "Your Text Here"
        if let font = UIFont(name: "Helvetica", size: 124) {
            let fontAttributes = [NSAttributedString.Key.font: font]
           
           let size = (myText as NSString).size(withAttributes: fontAttributes)
            print(size)
        }
        
        let string = "hello world!"
        let font = UIFont.systemFont(ofSize: 12)
        let width = string.size(OfFont: font) // size: {w: 98.912 h: 14.32}
        print(width)
        let size = myText.size(OfFont: UIFont(name: "Helvetica", size: 124)!) // size: {w: 98.912 h: 14.32}
        print(size)
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.backgroundColor = UIColor(named: "#289B3C")
        view.addSubview(textView)

        textView.backgroundColor = .orange
        textView.isEditable = false
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        heightConstraint.isActive = true
        topConstraint.isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doIt(_:)))
        textView.addGestureRecognizer(tapGesture)
    }

    @objc func doIt(_ sender: UITapGestureRecognizer) {
        //heightConstraint.constant = heightConstraint.constant == 50 ? 150 : 50
        topConstraint.constant = topConstraint.constant == 0 ? 150 : 0
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
}
