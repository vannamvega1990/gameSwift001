//
//  TPCakeDefaults.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

class TPCakeDefaults {
    
    static let shared = TPCakeDefaults()
    
    let keyAccessToken="TPkeyAccessToken"
    let keyAppleFullName="keyAppleFullName"
    let keyappleID = "keyappleID"
    let keyAppleEmail="keyAppleEmail"
    
    let keyDeviceToken="TPkeyDeviceToken"
    let TPkeyBiometricToken="TPkeyBiometricToken"
    
    let keyMobileLogin = "keyMobileLogin"
    let keyEmailLogin = "keyEmailLogin"
    let keyTouchIDOnOff = "keyTouchIDOnOff"
    let keyIsVerifyEmail = "keyIsVerifyEmail"
    let key_status_is_register_statement = "key_status_is_register_statement"
    
//    var biometric_token:String?{
//        set{
//            if let pass: String = newValue {
//                let cypher = CypherSwift.shared.tripleDesEncrypt(content: pass)
//                let data = Data(from: pass)
//                let _ = BaseKeyChain.save(key: TPkeyBiometricToken, data: data)
//            }
//        }
//        get{
//            if let receivedData = BaseKeyChain.load(key: TPkeyBiometricToken) {
//                //let result = receivedData.to(type: String.self)
//                let result = receivedData.toString()
//                //print(String(data: data, encoding: .utf8)!)
//                return result
//            }else{
//                return nil
//            }
//        }
//    }
    
    
//    var biometric_token:String?{
//        set{
//            if let pass: String = newValue {
//                let string_Data = BaseKeyChain.stringToDATA(string: pass)
//                BaseKeyChain.save(key: TPkeyBiometricToken, data: string_Data)
//            }
//        }
//        get{
//            if let RecievedDataStringAfterSave = BaseKeyChain.load(key: TPkeyBiometricToken) {
//                let NSDATAtoString = BaseKeyChain.DATAtoString(data: RecievedDataStringAfterSave)
//                print(NSDATAtoString)
//                return NSDATAtoString
//            }else{
//                return nil
//            }
//        }
//    }
    
    var device_token:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyDeviceToken)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyDeviceToken)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyDeviceToken) as? String
        }
    }

    var access_token:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyAccessToken)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyAccessToken)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyAccessToken) as? String
        }
    }
    
    var mobile:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyMobileLogin)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyMobileLogin)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyMobileLogin) as? String
        }
    }
    
    var email:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyEmailLogin)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyEmailLogin)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyEmailLogin) as? String
        }
    }
    
    var isVerifyEmail:Bool?{
        set{
            if newValue != nil{
                //UserDefaults.standard.removeObject(forKey: keyIsVerifyEmail)
                status_verify_email = newValue!
            }else{
                //UserDefaults.standard.set(newValue!, forKey: keyIsVerifyEmail)
                //UserDefaults.standard.synchronize()
            }
        }
        get{
            //return UserDefaults.standard.bool(forKey: keyIsVerifyEmail)
            return status_verify_email
        }
    }
    
    var status_is_register_statement:Bool?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: key_status_is_register_statement)
            }else{
                UserDefaults.standard.set(newValue!, forKey: key_status_is_register_statement)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.bool(forKey: key_status_is_register_statement)
        }
    }
    
    var isTouchID123:Bool?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyTouchIDOnOff)
            }else{
                let valueToSave = mobileTemp + "---@---" + (newValue! ? "1" : "0")
                //UserDefaults.standard.set(newValue!, forKey: keyTouchIDOnOff)
                UserDefaults.standard.set(valueToSave, forKey: keyTouchIDOnOff)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            //return UserDefaults.standard.bool(forKey: keyTouchIDOnOff)
            //return UserDefaults.standard.object(forKey: keyTouchIDOnOff) as? Bool
            if let val = UserDefaults.standard.object(forKey: keyTouchIDOnOff) as? String {
                let fullNameArr = val.components(separatedBy: "---@---")
                if let first    = fullNameArr.first, first == mobileTemp, let last    = fullNameArr.last {
                    return last == "1"
                }
            }
            return nil
        }
    }
    
    var isTouchID:Bool?{
        set{
            if newValue == nil{
                //UserDefaults.standard.removeObject(forKey: keyTouchIDOnOff)
                UserDefaults.standard.removeObject(forKey: mobileTemp)
            }else{
                //TPCoreData.saveTouchObject(value:newValue!)
                //UserDefaults.standard.set(newValue!, forKey: keyTouchIDOnOff)
                UserDefaults.standard.set(newValue!, forKey: mobileTemp)
                UserDefaults.standard.synchronize()
            }
        }
        get{
//            if let filterData = TPCoreData.filterData(), filterData.count >= 1 {
//                return filterData.first!.isTouch
//            }
            return UserDefaults.standard.bool(forKey: mobileTemp)
        }
    }
    
    var isFirstTouchID:Int?{
        set{
            let key = mobileTemp + "isFirstTouchID"
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: key)
            }else{
                UserDefaults.standard.set(newValue!, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            let key = mobileTemp + "isFirstTouchID"
            return UserDefaults.standard.object(forKey: key) as? Int
        }
    }
    
    var appleID:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyappleID)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyappleID)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyappleID) as? String
        }
    }
    
    var appleFullName:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyAppleFullName)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyAppleFullName)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyAppleFullName) as? String
        }
    }
    
    var appleEmail:String?{
        set{
            if newValue == nil{
                UserDefaults.standard.removeObject(forKey: keyAppleEmail)
            }else{
                UserDefaults.standard.set(newValue!, forKey: keyAppleEmail)
                UserDefaults.standard.synchronize()
            }
        }
        get{
            return UserDefaults.standard.object(forKey: keyAppleEmail) as? String
        }
    }
}



