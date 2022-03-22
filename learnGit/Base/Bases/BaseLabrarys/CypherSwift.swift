//
//  CypherSwift.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import CommonCrypto
import CryptoSwift

class CypherSwift: NSObject {
    
    public static let shared = CypherSwift()
    
    func tripleDesEncrypt(content: String) -> String{
        let keyData                = toMD5(string: Constants.TripleDesKey.KEY)
        let data                   = content.data(using: .utf8)!
        let cryptData              = NSMutableData(length: data.count + kCCBlockSize3DES)!
        let keyLength              = size_t(kCCKeySize3DES)
        let operation:CCOperation  = UInt32(kCCEncrypt)
        let algoritm:CCAlgorithm   = UInt32(kCCAlgorithm3DES)
        let options:CCOptions      = UInt32(kCCOptionPKCS7Padding | kCCOptionECBMode)
        
        var numBytesEncrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation,
                                  algoritm,
                                  options,
                                  keyData,
                                  keyLength,
                                  nil,
                                  data.bytes,
                                  data.count,
                                  cryptData.mutableBytes, cryptData.length,
                                  &numBytesEncrypted)
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            cryptData.length = Int(numBytesEncrypted)
            let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
            return base64cryptString
        } else {
            print("Error: \(cryptStatus)")
        }
        return ""
    }
    
    
    
    func toMD5(string: String) -> [UInt8] {
        //md5 convert
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        //convert 16 bytes to 24 bytes
        var keyBytes = [UInt8]()
        keyBytes.append(contentsOf: digestData.bytes)
        for j in 0..<8 {
            keyBytes.append(keyBytes[j])
        }
        return keyBytes
    }
    
    func urlEncode(string: String) -> String{
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted)
        guard let encodeData = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            print("Error: Can't urlEncode this string")
            return string
        }
        return encodeData
    }
    
}
