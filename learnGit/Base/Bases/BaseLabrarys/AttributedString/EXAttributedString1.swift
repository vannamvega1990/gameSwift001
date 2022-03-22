//
//  EXAttributedString1.swift
//  VegaFintech
//
//  Created by tran dinh thong on 9/10/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

@IBDesignable
class EXAttributedString1: UIView {
    
    @IBOutlet weak var btnNext: TPBaseViewImageWithLabel!
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var textView: UITextView!
    var rootView = UIView()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configs()
    }
    
    func setTitle(title: String){
        btnNext.txtTitle = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Bằng việc nhấn Đăng ký, đồng nghĩa việc bạn đã đồng ý với các Điều khoản của chúng tôi
//        let string1 = "Bằng việc nhấn Đăng ký, đồng nghĩa việc bạn đã đồng ý với các "
//        let attrString1 = NSMutableAttributedString(string: string1)
//        let string2 = "Điều khoản "
//        //let attribute2 = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
//        let attribute2: [NSAttributedString.Key: Any] = [
//            .font: titleContent.font!,
//            .foregroundColor: UIColor(rgb: 0xE98117),
//        ]
//        let attrString2 = NSAttributedString(string: string2, attributes: attribute2)
//        attrString1.append(attrString2)
//        let string3 = "của chúng tôi"
//        let attrString3 = NSMutableAttributedString(string: string3)
//        attrString1.append(attrString3)
//        titleContent.attributedText = attrString1
        
        let quote = "Bằng việc nhấn Đăng ký, đồng nghĩa việc bạn đã đồng ý với các Điều khoản của chúng tôi"
        let attributedQuote = NSMutableAttributedString(string: quote)
        //attributedQuote.addAttribute(.foregroundColor, value: UIColor(rgb: 0xE98117), range: NSRange(location: 57, length: 5))
        //attributedQuote.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: quote.length))
        let attribute: [NSAttributedString.Key: Any] = [
                    .font: textView.font!,
            .foregroundColor: UIColor.white,
        ]
        attributedQuote.addAttributes(attribute, range: NSRange(location: 0, length: quote.length))
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            .link: "signin", // khi click vào text
            //NSAttributedString.Key.kern: 10 // giản cách các chữ
        ]
        let linkRange = (attributedQuote.string as NSString).range(of: "Điều khoản")
        attributedQuote.addAttribute(NSAttributedString.Key.link, value: "signin", range: linkRange)
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xE98117),
            //NSAttributedString.Key.underlineColor: UIColor.lightGray,
            //NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView.linkTextAttributes = linkAttributes
        
        //attributedQuote.addAttributes(attributes, range: NSRange(location: 62, length: 10))
        titleContent.attributedText = attributedQuote
        textView.attributedText = attributedQuote
        textView.delegate = self
    }
    
    private func configs(){
        guard let view = self.FTloadViewFromNib(nibName: "TPLissenView") else {
            return
        }
        view.frame = self.bounds
        rootView = view
        self.addSubview(rootView)
        //configs()
    }
    
}

extension EXAttributedString1: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        // **Perform sign in action here**
        print("123 link")
        
        return false
    }
}
