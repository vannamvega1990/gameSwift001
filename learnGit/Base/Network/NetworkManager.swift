//
//  NetworkManager.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func requestRegister(mobile:String, password:String, full_name:String, email:String, device:String,
                         _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForRegister(mobile: mobile, password: password, full_name: full_name, email: email)
        let sign = NetworkUtil.createSignForRegister(data: data, request_time: request_time)
        
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.localizedModel
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let deviceString = "Device ID: \(deviceID) - Device Type: \(model) - OS Type: \(systemName) - OS Version: \(systemVersion)"
        //let manufacturePhone = "Apple"
        let stringBody = "data=\(data)&device=\(deviceString)&sign=\(sign)&request_time=\(request_time)"
        BaseNetwork.fragileHTTP(Constants.URLApiRegister, stringBody, callbak)
    }
    
    func requestVerifyOTP(mobile:String, otp:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForVerifyOTP(mobile: mobile, otp: otp)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let installed_app = ""
        let stringBody = "data=\(data)&installed_app=\(installed_app)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiVerifyOTP, stringBody, callbak)
    }
    
    func requestResendOTP(mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForResendOTP(mobile: mobile)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiResendOTP, stringBody, callbak)
    }
    
    func requestSocialRegisterResentOTP(_ socialId: String, _ socialType:String, _ mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForSocialRegisterResentOTP(socialId, socialType, mobile)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiSocialRegisterResentOTP, stringBody, callbak)
    }
    
    func requestForgetPasswordOTP(mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForResendOTP(mobile: mobile)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiForgetPasswordOTP, stringBody, callbak)
    }
    
    func requestLogin(mobile:String, password:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForLogin(mobile:mobile,password:password)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiLogin, stringBody, callbak)
    }
    
    func requestRegisterViaSocial(_ mobile:String,_ sosialId:String,_ sosialType:String,
    _ sosialEmailOrMobile:String,_ sosialName:String,
                         _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForRegisterViaSocial(mobile,sosialId,sosialType,
        sosialEmailOrMobile,sosialName)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.localizedModel
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let deviceString = "Device ID: \(deviceID) - Device Type: \(model) - OS Type: \(systemName) - OS Version: \(systemVersion)"
        //let manufacturePhone = "Apple"
        let stringBody = "data=\(data)&device=\(deviceString)&sign=\(sign)&request_time=\(request_time)"
        BaseNetwork.fragileHTTP(Constants.URLApiRegisterViaSocial, stringBody, callbak)
    }
    
    func requestCheckAuthenSocial(SocialId:String, SocialType:Int, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForCheckAuthenSocial(SocialId,SocialType)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiCheckAuthenSocial, stringBody, callbak)
    }
    
    func requestGetInfoUser(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForGetInfoUser(access_token)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiGetInfoUser, stringBody, callbak)
    }
    
    func requestLogout(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForLogout(access_token)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiLogout, stringBody, callbak)
    }
    
    func requestChangePassword(_ access_token:String,_ password:String,_ newPassword:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForChangePassword(access_token,password,newPassword)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiChangePassword, stringBody, callbak)
    }
    
    func requestResetPassword(_ mobile:String,_ otp:String,_ newPassword:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForResetPassword(mobile,otp,newPassword)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiResetPassword, stringBody, callbak)
    }
    
    func requestGetListLinkedSocial(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForGetInfoUser(access_token)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiGetListLinkedSocial, stringBody, callbak)
    }
    
    func requestLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String, _ SocialEmailOrMobile: String?, _ SocialName: String?, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForLinkSocial(access_token, SoscalId, SocialType, SocialEmailOrMobile, SocialName)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiLinkSocial, stringBody, callbak)
    }
    
    func requestDisLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = NetworkUtil.createDataForDisLinkSocial(access_token,SoscalId,SocialType)
        let sign = NetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(Constants.URLApiDisLinkSocial, stringBody, callbak)
    }
    
    
}
