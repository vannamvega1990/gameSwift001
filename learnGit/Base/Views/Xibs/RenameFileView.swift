//
//  RenameFileView.swift
//  Download98
//
//  Created by Eric Petter on 3/3/21.
//  Copyright © 2021 petter. All rights reserved.
//

import UIKit

protocol BtnDelegate {
    func btnokpressed(indexRow: IndexPath, txtOld: String, txtNew: String)
    func btncancelpressed(txt: String)
}

protocol BtnCancelDelegate {
    
}

class RenameFileView: UIView {
    
    var delegate:BtnDelegate?
    var txtOld:String?
    var txtNew:String?
    
    var indexRow: IndexPath?

//    class func instanceFromNib() -> UIView {
//        return UINib(nibName: "RenameFileView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RenameFileView
//    }
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var textfild: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
     @IBAction func btnOKPressed(_ sender: UIButton) {
        if textfild.text!.count > 6  {
            
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let fileManager = FileManager.default
            
            let appendingPath = self.textfild.text!
            let pathComponent = url.appendingPathComponent(appendingPath)
            let filePath = pathComponent!.path
            
            if fileManager.fileExists(atPath: filePath) {
                infoLabel.isHidden = false
            }else{
                delegate!.btnokpressed(indexRow: self.indexRow! , txtOld: self.txtOld!, txtNew: textfild.text!)
            }
        }
    }
    
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        guard (self.delegate != nil) else {
            return
        }
        delegate!.btncancelpressed(txt: "123")
    }
    
    override init(frame rec:CGRect){
        super.init(frame:rec)
        //commonInit()
        let _ = loadViewFromNib()
    }
    
    required init?(coder v:NSCoder){
        super.init(coder:v)
        //commonInit()
        let _ = loadViewFromNib()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func didAddSubview(_ subview: UIView) {
        //self.txtOld = self.textfild.text
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "RenameFileView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        view.layer.cornerRadius = 8
        addSubview(view)
        infoLabel.isHidden = true
        return view
        
    }

}
