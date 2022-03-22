//
//  BaseKeyChain.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/13/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import Security

extension BaseKeyChain {

    class func stringToDATA(string : String)->Data
    {
        let _Data = (string as NSString).data(using: String.Encoding.utf8.rawValue)
        return _Data!
        
    }
    
    
    class func DATAtoString(data: Data)->String
    {
        let returned_string : String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        return returned_string
    }
    
    class func intToDATA(r_Integer : Int)->NSData
    {
        
        var SavedInt: Int = r_Integer
        let _Data = NSData(bytes: &SavedInt, length: Int.max) //length: sizeof(Int)
        return _Data
        
    }
    class func DATAtoInteger(_Data : NSData) -> Int
    {
        var RecievedValue : Int = 0
        //_Data.getBytes(&RecievedValue, length: sizeof(Int))
        _Data.getBytes(&RecievedValue, length: Int.max)
        return RecievedValue
        
    }
    
    //EXAMPLES
    //
    //    //Save And Parse Int
    
    
    //    var Int_Data = KeyChain.intToNSDATA(555)
    //    KeyChain.save("MAMA", data: Int_Data)
    //    var RecievedDataAfterSave = KeyChain.load("MAMA")
    //    var NSDataTooInt = KeyChain.NSDATAtoInteger(RecievedDataAfterSave!)
    //    println(NSDataTooInt)
    //
    //
    //    //Save And Parse String
    
    
    //    var string_Data = KeyChain.stringToNSDATA("MANIAK")
    //    KeyChain.save("ZAHAL", data: string_Data)
    //    var RecievedDataStringAfterSave = KeyChain.load("ZAHAL")
    //    var NSDATAtoString = KeyChain.NSDATAtoString(RecievedDataStringAfterSave!)
    //    println(NSDATAtoString)
}

class BaseKeyChain {
    
    func example(){
        let string_Data = BaseKeyChain.stringToDATA(string: "MANIAK")
        BaseKeyChain.save(key: "ZAHAL", data: string_Data)
        
        let RecievedDataStringAfterSave = BaseKeyChain.load(key: "ZAHAL")
        let NSDATAtoString = BaseKeyChain.DATAtoString(data: RecievedDataStringAfterSave!)
        print(NSDATAtoString)
    }

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    
    static func remove(serviceKey: String) -> OSStatus  {
        
        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrAccount: serviceKey]
        //kSecMatchSearchList: CFString
        SecItemDelete(keychainQuery as CFDictionary)
        return SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    // remove all keychain --------------------
    static func clearAllKeychain() -> OSStatus{
//        let query1: [String: Any] = [
//            kSecClass as String: kSecClassGenericPassword,
//            kSecAttrAccount as String: username
//        ]
        let query: [String: Any] = [kSecClass as String:  kSecClassGenericPassword]
        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess {
            //throw KeychainError.unhandledError(status: status)
            print("chưa xoá đc all Clear Keychain")
        }
        print("Clear all Keychain")
        return status
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    class func loadFix(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
  
    // create unique string --------------------
    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {
    func toString() -> String?{
        let stringInt = String.init(data: self, encoding: String.Encoding.utf8)
        //let int = Int.init(stringInt ?? "")
        return stringInt
    }

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.load(as: T.self) }
//    }
}
