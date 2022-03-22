//
//  BaseString.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/5/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import UIKit

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}

extension String{ 
    static let ore=NSLocalizedString("All",comment:"")
    
    func validateString(_ pattern: String, str: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        return matches.count > 0
    }
    
    // check email ----------------------------------
    func checkEmail() -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return validateString(pattern, str: self)
    }
    // Passport ------------------------------
    func checkPassport() -> Bool {
        let pattern = "[a-zA-Z]{1}\\d{7}"
        return validateString(pattern, str: self)
    }
    
    // check phone -----------------------------------
    func checkPhone() -> Bool {
        //let pattern = "^0((16[2-9])|(9[0-9])|(12[0-9])|(199)|(186)|(188)|8(6|8|9))\\d{7}$"
        let pattern = "^0((16[2-9]|9[6-8]|3[2-9]|86)|(9[14]|12[3-579]|8[1-5]|88)|(9[03]|12[0-268]|7[06-9]|89)|(199|59|99)|(18[68]|92|5[268]))\\d{7}"
        return validateString(pattern, str: self)
    }
    
    func checkPhone4Register() -> Bool {
        let pattern = "^0((9[6-8]|3[2-9]|86)|(9[14]|8[1-5]|88)|(9[03]|7[06-9]|89)|(59|99)|(92|5[268]))\\d{7}"
        return validateString(pattern, str: self)
    }
    
    // check password ----------------------------------
    func checkPass() -> Bool {
        let pattern = "^(?=.*?[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ])(?=.*?[0-9]).{6,20}$"
        return validateString(pattern, str: self)
    }
    
    func checLengthkPass() -> Bool {
        let pattern = ".{6,20}$"
        return validateString(pattern, str: self)
    }
    
    // check special character --------------------------
    func checkSpecialCharacter() -> Bool {
        let pattern = "[$&+,:;=?@#|'<>^*()%!-.]"
        return validateString(pattern, str: self)
    }
    
    // replace ----------------------
    func replace(inCharactor:String,outCharactor:String) -> String{
        //let aString = "This is my string"
        //let newString = self.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        return self.replacingOccurrences(of: inCharactor, with: outCharactor, options: .literal, range: nil)
    }
    // removeWhitespace ---------------
    func removeWhitespaceBase() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    // trim chuẩn ---------------
    func trim() -> String {
        return self.removeBreakLine().removeWhitespaceBase()
        //return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removeBreakLine() -> String{
        return self.components(separatedBy: CharacterSet.newlines).joined(separator: " ")
    }
    
    
    
    // check special character --------------------------
    func checkBigCharacter() -> Bool {
        let pattern = "[A-Z]"
        return validateString(pattern, str: self)
    }
    
    // check special character --------------------------
    func checkHaveNumber() -> Bool {
        let pattern = "[0-9]"
        return validateString(pattern, str: self)
    }
    
    func getPrefix(_ length:Int)->String{
        if length<1{
            return self
        }
        return String(NSString(string:self).substring(to:length))
    }
    func getSuffix(_ length:Int)->String{
        if length<1{
            return self
        }
        let hhh=NSString(string:self)
        return String(hhh.substring(from:hhh.length-length))
    }
    func matches(_ regex:String)->Bool{
        return self.range(of:regex,options:.regularExpression,range:nil,locale:nil) != nil
    }
    
}
extension NSMutableData{
    func appendString(_ string:String){
        let data=string.data(using:.utf8,allowLossyConversion:true)
        append(data!)
    }
}





