//
//  MyCryptor.swift
//  FinTech
//
//  Created by Tu Dao on 5/19/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
//import SCrypto
import CommonCrypto

class MyCryptor {
    
    static func MD5(string: String) -> String {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
    
    
//    static func TripleDes(text: String) -> String {
//        let plaintext = text.data(using: String.Encoding.utf8)!
//        let sharedSecretKey = getKey().data(using: String.Encoding.utf8)!
//        let IV = getIV().data(using: .utf8)
//        //let cipherText = try! plaintext.encrypt(.tripleDES, options: [], key: sharedSecretKey, iv: IV)
//        //let cipherText = "123"
//        //return cipherText.hexString().uppercased()
//        return "123"
//    }
    
//    private static func getKey() -> String {
//        let length1 = Constant.privateKeyAPI1.count
//        let length2 = Constant.publicKeyAPI1.count
//        return Constant.privateKeyAPI1.subStr(from: (length1 - 12) / 2, length: 12) + Constant.publicKeyAPI1.subStr(from: (length2 - 12) / 2, length: 12)
//    }
//
//    private static func getIV() -> String {
//        let length1 = Constant.privateKeyAPI1.count
//        let length2 = Constant.publicKeyAPI1.count
//        return Constant.privateKeyAPI1.subStr(from: (length1 - 4) / 2, length: 4) + Constant.publicKeyAPI1.subStr(from: (length2 - 4) / 2, length: 4)
//    }
    
    static func validatePassword(pass: String) -> String {
        if pass.lengthOfBytes(using: .utf8) == 8 {
            return pass
        }
        
        let actualSize = pass.lengthOfBytes(using: .utf8)
        if actualSize > 8 {
            //return validatePassword(pass: String(pass.prefix(8 - (actualSize - pass.length))))
            return validatePassword(pass: String(pass.prefix(8 - (actualSize - pass.count))))
        } else {
            let mod = 8 - pass.lengthOfBytes(using: .utf8)
            var appendString = ""
            for _ in 1 ... mod {
                appendString += " "
            }
            
            return appendString + pass
        }
    }
}
