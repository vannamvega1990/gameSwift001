//
//  KeyChain.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/7/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

class KeyChain {
    
    static let shared = KeyChain()
    let wrapper = KeychainWrapper()

    var keychainMobile:String?{
        set{
            if newValue == nil{
                //UserDefaults.standard.removeObject(forKey: keyAccessToken)
                wrapper.mySetObject(newValue, forKey:Constants.KeyChain.KEY_MOBILE)
                
            }else{
                wrapper.mySetObject(newValue!, forKey:Constants.KeyChain.KEY_MOBILE)
                wrapper.writeToKeychain()
            }
        }
        get{
            return wrapper.myObject(forKey: Constants.KeyChain.KEY_MOBILE) as? String
        }
    }

}

