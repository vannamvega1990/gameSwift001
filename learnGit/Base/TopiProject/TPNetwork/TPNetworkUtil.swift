//
//  TPNetworkUtil.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class TPNetworkUtil: NSObject {
    
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
    
    static func createDataForVerifyDevice(mobile:String,device_id:String) -> String{
        //data= UrlEncode (TripleDES (mobile|device_id))
        let contentString = mobile + "|" + device_id
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString 
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
    // data cho xác thực email ----------------------------
    static func createDataForVerifyEmailOTP(access_token:String,email:String,otp:String) -> String{
        // data= UrlEncode (TripleDES (access_token|email|otp))
        let contentString = access_token + "|" + email + "|" + otp
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
    
    static func createDataForVerifyDeviceResendOTP(mobile:String, device_id:String) -> String{
        // data= UrlEncode (TripleDES (mobile|device_id))
        let contentString = mobile + "|" + device_id 
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    // data cho gửi lại mã otp xác thực email -----------------
    static func createDataForVerifyEmailResendOTP(access_token:String, email:String) -> String{
        // data= UrlEncode (TripleDES (access_token|email))
        let contentString = access_token + "|" + email
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForVerifyDeviceOTP(mobile:String,device_id:String,otp:String) -> String{
        // data= UrlEncode (TripleDES (mobile|device_id|otp))
        let contentString = mobile + "|" + device_id + "|" + otp
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString //?? ""
    }
    
    static func createDataForSocialRegisterResentOTP(_ socialId: String, _ socialType:String, _ mobile:String) -> String{
        // data= UrlEncode (TripleDES (SocialId|SocialType|Mobile))
        let contentString = socialId + "|" + socialType + "|" + mobile
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForLogin(mobile:String,password:String,device_token:String,biometric_token:String) -> String{
        //data= UrlEncode (TripleDES (mobile|md5_pwd|device_token))
        //data= UrlEncode (TripleDES (mobile|md5_pwd|device_token|biometric_token))
        let pwd_md5 = password.md5()
        let contentString = mobile + "|" + pwd_md5 + "|" + device_token + "|" + biometric_token
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    // data for get biometric_token ----------------------
    static func createDataForBiometricToken(mobile:String,password:String,device_token:String) -> String{
        //data= UrlEncode (TripleDES (mobile|md5_pwd|device_token))
        let pwd_md5 = password.md5()
        let contentString = mobile + "|" + pwd_md5 + "|" + device_token + "|"
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    // data for verify email ----------------------
    static func createDataForVerifyEmail(access_token:String,email:String) -> String{
        // data= UrlEncode (TripleDES (access_token|email))
        let contentString = access_token + "|" + email
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForRegisterViaSocial(_ mobile:String,_ sosialId:String,_ sosialType:String, _ sosialEmailOrMobile:String?,_ sosialName:String?,password:String) -> String{
        // data= UrlEncode (TripleDES (mobile|SosialId|SosialType|SosialEmailOrMobile|SosialName))
        //data= UrlEncode (TripleDES (mobile|SosialId|SosialType|SosialEmailOrMobile|SosialName|pwd_md5))
        var contentString = mobile + "|" + sosialId + "|" + sosialType + "|"
        let email = sosialEmailOrMobile ?? ""
        contentString = contentString  + email + "|"
        let fullName = sosialName ?? ""
        contentString = contentString + fullName + "|"
//        if let email = sosialEmailOrMobile {
//            contentString = contentString  + email + "|"
//        }
//        if let fullName = sosialName {
//            contentString = contentString + fullName + "|"
//        }
        let pwd_md5 = password.md5()
        contentString = contentString + pwd_md5
        //let contentString = mobile + "|" + sosialId + "|" + sosialType + "|" + sosialEmailOrMobile + "|" + sosialName
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    static func createDataForCheckAuthenSocial(_ SocialId:String,_ SocialType:Int,_ SocialEmailOrMobile:String?,_ SocialName:String?,_ device_token:String?) -> String{
        // data= UrlEncode (TripleDES (SocialId|SocialType|device_token))
        //SocialId|SocialType|SocialEmailOrMobile|SocialName|device_token
        //let contentString = SocialId + "|" + "\(SocialType)" + "|" + device_token
        var contentString = SocialId + "|" + "\(SocialType)"  + "|"
        let SocialEmailOrMobile1 = SocialEmailOrMobile ?? ""
        contentString += SocialEmailOrMobile1 + "|"
        let SocialName1 = SocialName ?? ""
        contentString += SocialName1 + "|"
        if let deviceToken = device_token {
            contentString += deviceToken
        }else{
            contentString += ""
        }
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    // data cho API lấy danh sách phương thức thanh toán của tài khoản ------------
    static func createDataForRequestGetListProfilePayment(_ access_token:String) -> String{
        // data= UrlEncode (TripleDES (access_token))
        let contentString = access_token
        let tripleDesString = CypherSwift.shared.tripleDesEncrypt(content: contentString)
        let dataString = CypherSwift.shared.urlEncode(string: tripleDesString)
        return dataString
    }
    
    // data cho API lấy danh sách phương thức thanh toán của tài khoản ------------
    static func createDataForProfileUpdateKYC(_ access_token:String) -> String{
        // data= UrlEncode (TripleDES (access_token))
        let contentString = access_token
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
    
    static func createDataForgetPasswordSendOTP(_ mobile:String) -> String{
        // data= UrlEncode (TripleDES (mobile))
        let contentString = mobile
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

