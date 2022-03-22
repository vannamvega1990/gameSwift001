//
//  NetworkUtil.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}


class NetworkUtil: NSObject {
   
    static func createDataForRegister(mobile:String,password:String,full_name:String,email:String?) -> String{
        //data= UrlEncode (TripleDES (mobile|pwd_md5|full_name|email))
        //let pwd_md5 = MyCryptor.MD5(string: password)
        let pwd_md5 = password.md5()
        var contentString = mobile + "|" + pwd_md5 + "|" + full_name
        if let email1 = email {
            contentString = contentString + "|" + email1
        }
        //let contentString = mobile + "|" + pwd_md5 + "|" + full_name + "|" + email
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString //?? ""
    }
    
    static func createSignForRegister(data: String, request_time:String) -> String {
        //sign = MD5(DataDecode|request_time|key)
        let tripleDesString = data.decodeUrl() ?? ""
        let requestTime = request_time
        let signString = "\(tripleDesString)|\(requestTime)|\(Constants.TripleDesKey.KEY)"
        let signMD5 = signString.md5()
        return signMD5
    }
    
    static func createDataForVerifyOTP(mobile:String,otp:String) -> String{
        // data= UrlEncode (TripleDES (mobile|otp)) Trong đó:
        let contentString = mobile + "|" + otp
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString //?? ""
    }
    
    static func createDataForResendOTP(mobile:String) -> String{
        // data= UrlEncode (TripleDES (mobile))
        let contentString = mobile
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForSocialRegisterResentOTP(_ socialId: String, _ socialType:String, _ mobile:String) -> String{
        // data= UrlEncode (TripleDES (SocialId|SocialType|Mobile))
        let contentString = socialId + "|" + socialType + "|" + mobile
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForLogin(mobile:String,password:String) -> String{
        // data= UrlEncode (TripleDES (mobile|md5_pwd))
        let pwd_md5 = password.md5()
        let contentString = mobile + "|" + pwd_md5
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString 
    }
    
    static func createDataForRegisterViaSocial(_ mobile:String,_ sosialId:String,_ sosialType:String,
                                               _ sosialEmailOrMobile:String,_ sosialName:String) -> String{
        // data= UrlEncode (TripleDES (mobile|SosialId|SosialType|SosialEmailOrMobile|SosialName))
        let contentString = mobile + "|" + sosialId + "|" + sosialType + "|" + sosialEmailOrMobile + "|" + sosialName
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForCheckAuthenSocial(_ SocialId:String,_ SocialType:Int) -> String{
        // data= UrlEncode (TripleDES (SocialId|SocialType))
        let contentString = SocialId + "|" + "\(SocialType)"
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForGetInfoUser(_ access_token:String) -> String{
        // data= UrlEncode (TripleDES (access_token))
        let contentString = access_token
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForLogout(_ access_token:String) -> String{
        // data= UrlEncode (TripleDES (access_token))
        let contentString = access_token
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForChangePassword(_ access_token:String,_ password:String,_ newPassword:String) -> String{
        // data= UrlEncode (TripleDES (access_token|curpwd_md5|newpwd_md5))
        let curpwd_md5 = password.md5()
        let newpwd_md5 = newPassword.md5()
        let contentString = access_token + "|" + curpwd_md5 + "|" + newpwd_md5
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForResetPassword(_ mobile:String,_ otp:String,_ newPassword:String) -> String{
        // data= UrlEncode (TripleDES (mobile|otp|new_md5pwd))
        let newpwd_md5 = newPassword.md5()
        let contentString = mobile + "|" + otp + "|" + newpwd_md5
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String, _ SocialEmailOrMobile: String?, _ SocialName: String?) -> String{
        // data= UrlEncode (TripleDES (access_token|SoscalId|SocialType|SocialEmailOrMobile|SocialName))
        var contentString = access_token + "|" + SoscalId + "|" + SocialType
        if let _ = SocialEmailOrMobile {
            contentString +=   "|" + SocialEmailOrMobile!
        }
        if let _ = SocialName {
            contentString += "|" + SocialName!
        }
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForDisLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String) -> String{
        // data= UrlEncode (TripleDES (access_token|SocialId|SocialType))
        let contentString = access_token + "|" + SoscalId + "|" + SocialType
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createSign(data: String, request_time:String) -> String {
        // sign = MD5(DataDecode|request_time|key)
        let tripleDesString = data.decodeUrl() ?? ""
        let requestTime = request_time
        let signString = "\(tripleDesString)|\(requestTime)|\(Constants.TripleDesKey.KEY)"
        let signMD5 = signString.md5()
        return signMD5
    }

    
    
    
    private static func getAuditNumber() -> UInt32 {
        let min: UInt32 = 100000000
        let max: UInt32 = 999999999
        
        let randNum = arc4random() % (max - min) + min
        return randNum
    }
    
    private static func getSerialNumber() -> String {
        //return UUID().uuidString
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
