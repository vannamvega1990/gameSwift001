//
//  UserDefaults.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/25/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

class CakeDefaults {
    
    static let shared = CakeDefaults()
    
    let keyAccessToken="keyAccessToken"
    let keyAppleFullName="keyAppleFullName"
    let keyAppleEmail="keyAppleEmail"
    
    let keyMobileLogin = "keyMobileLogin"

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


