//
//  TPNetworkManager.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

let utm_source = "IOS"

class TPNetworkManager: NSObject {
    
    static let shared = TPNetworkManager()
    
    func getInfoDevice() -> String {
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.localizedModel
        let deviceName = UIDevice.current.name
        let device_imei = "nil" //ko the lay imei
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        let version = Commons.shared.getVersionApp() ?? "nil"
        let build = Commons.shared.getBuildApp() ?? "nil"
        let platform = "IOS"
        //let stringBody = "device_id=\(deviceID)&device_model=\(model)&device_name=\(deviceName)&app_version=\(version)&os_version=\(systemVersion)"
        let stringBody = "log_device=\(deviceID)&log_platform=\(platform)&log_device_name=\(deviceName)&log_app_version=\(version)&log_ios_version=\(systemVersion)"
        return stringBody
        
        
    }
    
    func requestRegister(mobile:String, password:String, full_name:String, email:String?, device:String,
                         _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRegister(mobile: mobile, password: password, full_name: full_name, email: email)
        let sign = TPNetworkUtil.createSignForRegister(data: data, request_time: request_time)
        
        let systemName = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion
        let model = UIDevice.current.localizedModel
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        //let deviceString = "Device ID: \(deviceID) - Device Type: \(model) - OS Type: \(systemName) - OS Version: \(systemVersion)"
        let platform = "Ios"
        let installed_app = ""
        //let manufacturePhone = "Apple"
        //let stringBody = "data=\(data)&device=\(deviceString)&sign=\(sign)&request_time=\(request_time)"
        let stringBody = "data=\(data)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)&installed_app=\(installed_app)&utm_source=\(utm_source)&" + getInfoDevice()
        BaseNetwork.fragileHTTP(TPConstants.URLApiRegister, stringBody, callbak)
    }
    
    func requestVerifyDevice(mobile:String,device_id:String,
                         _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyDevice(mobile: mobile, device_id: device_id)
        let sign = TPNetworkUtil.createSignForRegister(data: data, request_time: request_time)
       
        let platform = "Ios"
        let stringBody = "data=\(data)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)&utm_source=\(utm_source)&" + getInfoDevice()
        BaseNetwork.fragileHTTP(TPConstants.URLApiRequestVerifyDevice, stringBody, callbak)
    }
    // api xác thực email --------------------
    func requestVerifyEmailOTP(access_token:String, email:String, otp:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyEmailOTP(access_token: access_token, email: email, otp: otp)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let is_register_statement = false
        let stringBody = "data=\(data)&is_register_statement=\(is_register_statement)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiRequestVerifyEmail, stringBody, callbak)
    }
    
    func requestVerifyOTP(mobile:String, otp:String, device_id:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyOTP(mobile: mobile, otp: otp)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let installed_app = ""
        let stringBody = "data=\(data)&installed_app=\(installed_app)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)&device_id=\(device_id)&" + getInfoDevice()
        
        BaseNetwork.fragileHTTP(TPConstants.URLApiVerifyOTP, stringBody, callbak)
    }
    
    func requestResendOTP(mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForResendOTP(mobile: mobile)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiResendOTP, stringBody, callbak)
    }
    
    func requestVerifyDeviceResendOTP(mobile:String,device_id:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyDeviceResendOTP(mobile:mobile, device_id:device_id)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiVerifyDeviceResendOTP, stringBody, callbak)
    }
    
    // api yêu cầu gửi lại otp xác thực email -------------------------
    func requestVerifyEmailResendOTP(access_token:String, email:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyEmailResendOTP(access_token: access_token, email: email)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiVerifyEmailResendOTP, stringBody, callbak)
    }
    
    func requestVerifyDeviceOTP(mobile:String,device_id:String,otp:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyDeviceOTP(mobile: mobile, device_id: device_id, otp: otp)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let is_active_trust_device = true

        //let stringBody = "data=\(data)&is_active_trust_device=\(is_active_trust_device)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)"
        
        let stringBody = "data=\(data)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)"
        
        BaseNetwork.fragileHTTP(TPConstants.URLApiRequestVerifyDeviceOTP, stringBody, callbak)
    }
    
    func requestSocialRegisterResentOTP(_ socialId: String, _ socialType:String, _ mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForSocialRegisterResentOTP(socialId, socialType, mobile)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiSocialRegisterResentOTP, stringBody, callbak)
    }
    
    func requestForgetPasswordOTP(mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForResendOTP(mobile: mobile)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiForgetPasswordOTP, stringBody, callbak)
    }
    
    func requestLogin(mobile:String, password:String,device_token:String,biometric_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForLogin(mobile:mobile,password:password, device_token: device_token, biometric_token: biometric_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)&utm_source=\(utm_source)&" + getInfoDevice()
        BaseNetwork.fragileHTTP(TPConstants.URLApiLogin, stringBody, callbak)
    }
    
    // api get biometric_token: Token sinh trác học --------------------
    func requestBiometricToken(mobile:String, password:String,device_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForBiometricToken(mobile:mobile,password:password, device_token: device_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        //BaseNetwork.fragileHTTP(TPConstants.URLApiGetBiometricToken, stringBody, callbak)
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetBiometricToken, stringBody, callbak, headers: headers)
    }
    
    // api lịch sử giao dịch --------------------
    func requestHistoryTransaction(page:Int, count:Int, from_date:String?, to_date:String?,search:String?, product_type_id: Int?, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        //let stringBody = "page=\(page)&count=\(count)&from_date=\(from_date)&to_date=\(to_date)&search=\(search)"
        var stringBody = "page=\(page)&count=\(count)"
        if let productTypeId = product_type_id {
            stringBody += "&product_type_id=\(productTypeId)"
        }
        if let from_date = from_date {
            stringBody += "&from_date=\(from_date)"
        }
        if let to_date = to_date {
            stringBody += "&to_date=\(to_date)"
        }
        
        let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJQcm9maWxlSWQiOiIxMDAwMTkiLCJNb2JpbGUiOiIwMzQ5ODM3MjM0IiwiQ3VzdG9tZXJEZXZpY2VJZCI6IjIwIiwibmJmIjoxNjI3NTQzNjI0LCJleHAiOjE2MzAxMzU2MjQsImlhdCI6MTYyNzU0MzYyNH0.BM903NeRe_lyOAejtSL6TEKO4hN0nYkD5_cV5OWmZWA"
        BaseNetwork.fragileHTTP(TPConstants.URLApiHistoryTransaction, stringBody, callbak, headers:  headers, method: "POST")
        
    }
    
    // api GetListProductType --------------------
    func requestGetListProductType( _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        //let stringBody = "page=\(page)&count=\(count)&from_date=\(from_date)&to_date=\(to_date)&search=\(search)"
        //let stringBody = "page=\(page)&count=\(count)"
        //BaseNetwork.fragileHTTP(TPConstants.URLApiHistoryTransaction, stringBody, callbak)
        let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJQcm9maWxlSWQiOiIxMDAwMTkiLCJNb2JpbGUiOiIwMzQ5ODM3MjM0IiwiQ3VzdG9tZXJEZXZpY2VJZCI6IjIwIiwibmJmIjoxNjI3NTQzNjI0LCJleHAiOjE2MzAxMzU2MjQsImlhdCI6MTYyNzU0MzYyNH0.BM903NeRe_lyOAejtSL6TEKO4hN0nYkD5_cV5OWmZWA"
        //BaseNetwork.fragileHTTPNobody(TPConstants.URLApiGetListProductType, callbak)
        
        //BaseNetwork.fragileHTTPNobody(TPConstants.URLApiGetListProductType, callbak, headers: ["Authorization":token])
        BaseNetwork.fragileHTTPNobody(TPConstants.URLApiGetListProductType, callbak, headers: headers)
        
        //BaseNetwork.fragileHTTP(TPConstants.URLApiHistoryTransaction, "stringBody", callbak, headers:  ["Authorization":token], method: "POST")
    }
    
    // api verify email --------------------
    func requestVerifyEmail(access_token:String,email:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForVerifyEmail(access_token: access_token, email: email)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiVerifyEmail, stringBody, callbak)
    }
    
    
    func requestRegisterViaSocial(_ mobile:String,_ sosialId:String,_ sosialType:String,
    _ sosialEmailOrMobile:String?,_ sosialName:String?,_ password:String,
                         _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRegisterViaSocial(mobile,sosialId,sosialType,
                                                                sosialEmailOrMobile,sosialName, password: password)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        
        let platform = "Ios"
        let installed_app = ""
        let utm_source = "IOS"
        //let stringBody = "data=\(data)&device=\(deviceString)&sign=\(sign)&request_time=\(request_time)"
        
        let stringBody = "data=\(data)&sign=\(sign)&request_time=\(request_time)&platform=\(platform)&installed_app=\(installed_app)&utm_source=\(utm_source)&" + getInfoDevice()
        BaseNetwork.fragileHTTP(TPConstants.URLApiRegisterViaSocial, stringBody, callbak)
    }
    
    func requestCheckAuthenSocial(SocialId:String, SocialType:Int,_ SocialEmailOrMobile:String?,_ SocialName:String?,device_token:String?, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        //let data = TPNetworkUtil.createDataForCheckAuthenSocial(SocialId,SocialType, device_token)
        let data = TPNetworkUtil.createDataForCheckAuthenSocial(SocialId, SocialType, SocialEmailOrMobile, SocialName, device_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let application_key = ""
        let stringBody = "data=\(data)&application_key=\(application_key)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)&utm_source=\(utm_source)&" + getInfoDevice()
        BaseNetwork.fragileHTTP(TPConstants.URLApiCheckAuthenSocial, stringBody, callbak)
    }
    
    func requestUpdateTokenNoti(FirebaseToken:String, Platform:String = "IOS", _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let stringBody = "FirebaseToken=\(FirebaseToken)&Platform=\(Platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiUpdateTokenFirebase, stringBody, callbak, headers: headers)
    }
    
    func requestGetInboxNotYetRead( _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        //BaseNetwork.fragileHTTP(TPConstants.URLApiUpdateTokenFirebase, stringBody, callbak, headers: headers)
        BaseNetwork.fragileHTTPNobody(TPConstants.URLApiGetInboxNotYetRead, callbak, headers: headers)
    }
    
    // api lấy danh sách  kênh thanh toán --------------
    func requestGetListPaymentChannel(_ access_token:String,payment_type_id:Int, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRequestGetListProfilePayment(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let payment_type_id: Int = 1
        let stringBody = "data=\(data)&payment_type_id=\(payment_type_id)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetListPaymentChannel, stringBody, callbak)
    }
    
    // api lấy danh sách phương thức thanh toán của tài khoản --------------
    func requestGetListProfilePayment(_ access_token:String,payment_channel_id:Int, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRequestGetListProfilePayment(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&payment_channel_id=\(payment_channel_id)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetListProfilePayment, stringBody, callbak)
    }
    
    // api xóa phương thức thanh toán cho tài khoản --------------
    func requestDeleteProfilePayment(_ access_token:String,profile_payment_id:Int, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRequestGetListProfilePayment(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&profile_payment_id=\(profile_payment_id)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiDeleteProfilePayment, stringBody, callbak)
    }
    
    // api tạo phương thức thanh toán cho tài khoản --------------
    func requestCreateProfilePayment(_ access_token:String,payment_channel_id:Int,payment_name:String, payment_number:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRequestGetListProfilePayment(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&payment_channel_id=\(payment_channel_id)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)&payment_name=\(payment_name)&payment_number=\(payment_number)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetCreateProfilePayment, stringBody, callbak)
    }
    
    // api Đăng ký nhận sao kê hàng tháng --------------
    func requestRegisterStatement(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForRequestGetListProfilePayment(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiRegisterStatement, stringBody, callbak)
    }
    
    // api cập nhật kyc --------------
    func requestProfileUpdateKYC(access_token:String,
                                 fullname:String,
                                 id_number:String,
                                 date_of_birth:String,
                                 sex:String,
                                 nationality:String,
                                 place_of_origin:String,
                                 place_of_residence:String,
                                 date_of_expired:String,
                                 ethnic:String,
                                 religion:String,
                                 personal_identification:String,
                                 date_of_issue:String,
                                 place_of_issue:String,
                                 image_front:String,
                                 image_back:String,
                                 kyc_score:String,
                                 _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForProfileUpdateKYC(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        var stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        let subBody = "&fullname=\(fullname)&id_number=\(id_number)&date_of_birth=\(date_of_birth)&sex=\(sex)&nationality=\(nationality)&place_of_origin=\(place_of_origin)&place_of_residence=\(place_of_residence)&date_of_expired=\(date_of_expired)&ethnic=\(ethnic)&religion=\(religion)&personal_identification=\(personal_identification)&date_of_issue=\(date_of_issue)&place_of_issue=\(place_of_issue)&image_front=\(image_front)&image_back=\(image_back)&kyc_score=\(kyc_score)"
        stringBody = stringBody + subBody
        BaseNetwork.fragileHTTP(TPConstants.URLApiProfileUpdateKYC, stringBody, callbak)
    }
    
    func requestGetInfoUser(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForGetInfoUser(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetInfoUser, stringBody, callbak)
    }
    // api đăng xuất logout tài khoản -------------------------
    func requestLogout(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForLogout(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiLogout, stringBody, callbak)
    }
    
    func requestChangePassword(_ access_token:String,_ password:String,_ newPassword:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForChangePassword(access_token,password,newPassword)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiChangePassword, stringBody, callbak)
    }
    
    func requestResetPassword(_ mobile:String,_ otp:String,_ newPassword:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForResetPassword(mobile,otp,newPassword)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiResetPassword, stringBody, callbak)
    }
    
    func requestForgetPasswordSendOTP(_ mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForgetPasswordSendOTP(mobile)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiForgetPasswordSendOTP, stringBody, callbak)
    }
    
    func requestForgetPasswordReSendOTP(_ mobile:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForgetPasswordSendOTP(mobile)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiForgetPasswordReSendOTP, stringBody, callbak)
    }
    
    func requestGetListLinkedSocial(_ access_token:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForGetInfoUser(access_token)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiGetListLinkedSocial, stringBody, callbak)
    }
    
    func requestLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String, _ SocialEmailOrMobile: String?, _ SocialName: String?, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForLinkSocial(access_token, SoscalId, SocialType, SocialEmailOrMobile, SocialName)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiLinkSocial, stringBody, callbak)
    }
    
    func requestDisLinkSocial(_ access_token:String,_ SoscalId:String,_ SocialType:String, _ callbak:@escaping (Data?,URLResponse?,Error?)->Void){
        let request_time = Commons.shared.getCurrentTime()
        let data = TPNetworkUtil.createDataForDisLinkSocial(access_token,SoscalId,SocialType)
        let sign = TPNetworkUtil.createSign(data: data, request_time: request_time)
        let platform = "Ios"
        let stringBody = "data=\(data)&request_time=\(request_time)&sign=\(sign)&platform=\(platform)"
        BaseNetwork.fragileHTTP(TPConstants.URLApiDisLinkSocial, stringBody, callbak)
    }
    
    
}

