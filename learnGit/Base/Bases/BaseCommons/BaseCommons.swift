//
//  BaseCommons.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/2/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit
//import MBProgressHUD
//import SwiftMessages
//import KLCPopup

class BaseCommons: NSObject {
    
    static let instance = BaseCommons()
    
    func curentDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let myString = formatter.string(from: Date()) // string purpose I add here
        print(myString)
        return myString
    }
    
    // get current time -------------------------------------
    func getCurrentTime() -> String {
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: currentTime)
    }
    
    // Format money ------------------------------------
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 0
        
        return formatter
    }()
    
    class func formatCurrency(value: Int64) -> String {
        guard let number = currencyFormatter.string(from: NSNumber(value: value)) else {
            return "0 đ"
        }
        
        return number + " đ"
    }
    
    // get height of text --------------------------------
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height + 15
    }
    
    // NilOrEmpty ---------------------------
    class func stringIsNilOrEmpty(str: String?) -> Bool {
        return (str ?? "").isEmpty
    }
    
    // Passport ------------------------------
    class func checkPassport(str: String) -> Bool {
        let pattern = "[a-zA-Z]{1}\\d{7}"
        return validateString(pattern, str: str)
    }
    
    class func validateString(_ pattern: String, str: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        return matches.count > 0
    }
    
    // Keychain ------------------------------------
    class func setPassword(password: String) {
        let wrapper = KeychainWrapper()
        wrapper.mySetObject(password, forKey:kSecValueData)
        wrapper.writeToKeychain()
    }
    
    class func getPassword() -> String? {
        let wrapper = KeychainWrapper()
        return wrapper.myObject(forKey: "v_Data") as? String
    }
    
    class func getPassword1() -> String? {
        let wrapper = KeychainWrapper()
        return wrapper.myObject(forKey: kSecValueData) as? String
    }
    
    // check email ----------------------------------
    class func checkEmail(str: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return validateString(pattern, str: str)
    }
    
    // check phone -----------------------------------
    class func checkPhone(str: String) -> Bool {
        //let pattern = "^0((16[2-9])|(9[0-9])|(12[0-9])|(199)|(186)|(188)|8(6|8|9))\\d{7}$"
        let pattern = "^0((16[2-9]|9[6-8]|3[2-9]|86)|(9[14]|12[3-579]|8[1-5]|88)|(9[03]|12[0-268]|7[06-9]|89)|(199|59|99)|(18[68]|92|5[268]))\\d{7}"
        return validateString(pattern, str: str)
    }
    
    class func checkPhone4Register(str: String) -> Bool {
        let pattern = "^0((9[6-8]|3[2-9]|86)|(9[14]|8[1-5]|88)|(9[03]|7[06-9]|89)|(59|99)|(92|5[268]))\\d{7}"
        return validateString(pattern, str: str)
    }
    
    // check password ----------------------------------
    class func checkPass(str: String) -> Bool {
        let pattern = "^(?=.*?[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ])(?=.*?[0-9]).{6,20}$"
        return validateString(pattern, str: str)
    }
    
    class func checLengthkPass(str: String) -> Bool {
        let pattern = ".{6,20}$"
        return validateString(pattern, str: str)
    }
    
    // check special character --------------------------
    class func checkSpecialCharacter(str: String) -> Bool {
        let pattern = "[$&+,:;=?@#|'<>^*()%!-.]"
        return validateString(pattern, str: str)
    }
      
    // register transmit notification ---------------------
    class func registerTransmitNotificationcenter(_ name: String, _ object: Any?, _ userInfo:[AnyHashable : Any]? ){
        NotificationCenter.default.post(name: NSNotification.Name.init(name), object: object, userInfo: userInfo)
    }
    
    var actionNotificationcenter:(()->())?
    @objc func notificationCenterAction(){
        actionNotificationcenter?()
    }
    
    // register recrver notification ---------------------
    class func regisReceverNotificationcenter(_ observer: Any,_ name: String, _ object: Any?, selector: Selector ){
        let loadWeatherObserver = NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name.init(name), object: object)
        
    }
    
    // call ------------------------------------------
    func callSupport(phoneNumber: String) {
        //let phoneNumber = Constants.Support.PHONENUMBER
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneCallURL) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(phoneCallURL)
            } else {
                UIApplication.shared.openURL(phoneCallURL)
            }
        }
    }
    
    // Money -------------------------------------
    func formatMoney(money: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:money))
        return (formattedNumber?.replacingOccurrences(of: ",", with: "."))!
    }
    
    func formatMoneyToInt(money: String) -> Int {
        return Int(money.replacingOccurrences(of: ".", with: "")) ?? 0
    }
    
    func formatMoneyDouble(money: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:money))
        return (formattedNumber?.replacingOccurrences(of: ",", with: "."))!
    }
    
    // get version app
    func getVersionApp()-> String?{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    // get build app
    func getBuildApp() -> String? {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as? String
        let build = dictionary["CFBundleVersion"] as? String
        return build
    }
    
    // get app name -------------
    func getAppName() -> String? {
        let dictionary = Bundle.main.infoDictionary!
        let appName = dictionary["CFBundleDisplayName"] as? String
        return appName
    }
    
    
}
