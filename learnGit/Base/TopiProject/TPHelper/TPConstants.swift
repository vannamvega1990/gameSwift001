//
//  TPConstants.swift
//  VegaFintech
//
//  Created by tran dinh thong on 7/29/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

//
//  Constants.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import Foundation
import UIKit

//let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJQcm9maWxlSWQiOiIxMDAwMTkiLCJNb2JpbGUiOiIwMzQ5ODM3MjM0IiwiQ3VzdG9tZXJEZXZpY2VJZCI6IjIwIiwibmJmIjoxNjI3NTQzNjI0LCJleHAiOjE2MzAxMzU2MjQsImlhdCI6MTYyNzU0MzYyNH0.BM903NeRe_lyOAejtSL6TEKO4hN0nYkD5_cV5OWmZWA"
var token: String{
    return "Bearer \(TPCakeDefaults.shared.access_token!)"
}
//let headers1 =  ["Authorization":token]
var headers: [String:String]{
    get{
        return ["Authorization":token]
    }
}

class TPConstants: NSObject {

    struct TripleDesKey {
        static let KEY: String                      = "CAF39842B3AD918EDC1144C03CA1C673"
    }
    
    struct NotificationCenterName {
        static let hidePopup: String                      = "hidePopup"
    }
    
    struct SocialType {
        static let Facebook: Int                      = 0
        static let Google: Int                      = 1
        static let Apple: Int                      = 2
    }
    
    struct KeyChain {
        static let KEY_MOBILE: String                      = "KEY_KEYCHAIN_MOBILE"
        static let KEY_PASSWORD: String                      = "KEY_KEYCHAIN_PASSWORD"
    }
    
    public struct KEY {
            public static var appID: String                    = ""
    //        static let accessToken: String              = "BpDzET7vZFJbugK8NVGMCSIAnOyaqdmX"
    //        static let appID: String              = "13"
            public static var accessToken: String       = ""
            public static var frontOCR: UIImage?
            public static var backOCR: UIImage?
            public static var faceOCR: [UIImage]?
            public static var resultOCR: OCRResult?
        }
    
    struct API {
        static let prefix: String                   = "https://api.vegafintech.vn/"
        static let OCRFRONT: String                 = "\(prefix)ekycdemoocr/v1/api/v1/card/ocr/front"
        static let OCRBACK: String                  = "\(prefix)ekycdemoocr/v1/api/v1/card/ocr/back"
        static let VERIFYFACEWITHCARD: String       = "\(prefix)ekycdemoface/v1/verify_face_with_identityCard"
        static let VERIFYFACEWITHVIDEO: String      = "\(prefix)ekycdemoface/v1/verify_faceSelfie_with_video"
        static let VERIFYFACEWITHHISTORY: String    = "\(prefix)verify_face_in_identityCard_with_history"
        static let FACEANALYTICS: String            = "\(prefix)ekycdemofaceanl/v1/stream/face_analytics"
        static let COMPARE2FACE: String             = "\(prefix)ekycdemofacereg/v1/stream/compare_two_face"
    }
    //static let TPprefix = "https://v1graph.topi.vn" // relese
    //static let TPprefixDemo = "http://devtopi.amft.vn" // Demo
    static let TPprefix:[String:String] = ["Relese": "https://v1graph.topi.vn",
                                           "Demo": "http://devtopi.amft.vn",]
    static let TPprefixChose: String =
        "Demo"
//        "Relese"
    
    static let URLApiLogin = "\(TPprefix[TPprefixChose]!)/Login" //"http://devtopi.amft.vn/Login"
    static let URLApiGetBiometricToken = "\(TPprefix[TPprefixChose]!)/RequestBiometricLogin" //"http://devtopi.amft.vn/RequestBiometricLogin"
    static let URLApiUpdateTokenFirebase = "\(TPprefix[TPprefixChose]!)/UpdateTokenFirebase"
    static let URLApiGetInboxNotYetRead = "\(TPprefix[TPprefixChose]!)/GetTotalInbox"
    static let URLApiHistoryTransaction = "\(TPprefix[TPprefixChose]!)/GetHistoryTransactionProduct"   //"http://devtopi.amft.vn/GetHistoryTransactionProduct"
    static let URLApiResendOTP = "\(TPprefix[TPprefixChose]!)/RegisterProfileResentOTP"
    static let URLApiVerifyDeviceResendOTP = "\(TPprefix[TPprefixChose]!)/ResentOTPConnectDevice"
    static let URLApiVerifyOTP = "\(TPprefix[TPprefixChose]!)/RegisterProfileVerifyOTP"
    static let URLApiRegister = "\(TPprefix[TPprefixChose]!)/RegisterProfile"
    static let URLApiRegisterViaSocial = "\(TPprefix[TPprefixChose]!)/SocialRegisterProfile"
    
    //static let URLApiCheckAuthenSocial = "http://nguyendev.amft.vn/SocialCheckAuthen"
    
    static let URLApiCheckAuthenSocial = "\(TPprefix[TPprefixChose]!)/SocialCheckAuthen"
    static let URLApiVerifyEmail = "\(TPprefix[TPprefixChose]!)/RequestVerifyEmail"
    static let URLApiRequestVerifyEmail = "\(TPprefix[TPprefixChose]!)/VerifyEmail"
    static let URLApiVerifyEmailResendOTP = "\(TPprefix[TPprefixChose]!)/ResentOTPVerifyEmail"
    
    static let URLApiGetInfoUser = "\(TPprefix[TPprefixChose]!)/ProfileGetInfo"
    static let URLApiGetListLinkedSocial = "\(TPprefix[TPprefixChose]!)/SocialListConnected"
    static let URLApiLogout = "\(TPprefix[TPprefixChose]!)/Logout"
    static let URLApiChangePassword = "\(TPprefix[TPprefixChose]!)/ProfileChangePwd"
    static let URLApiSocialRegisterResentOTP = "\(TPprefix[TPprefixChose]!)/SocialRegisterResentOTP"
    static let URLApiLinkSocial = "\(TPprefix[TPprefixChose]!)/SocialConnect"
    static let URLApiDisLinkSocial = "\(TPprefix[TPprefixChose]!)/SocialDisconnect"
    static let URLApiForgetPasswordOTP = "\(TPprefix[TPprefixChose]!)/ProfileForgotPwd"
    static let URLApiResetPassword = "\(TPprefix[TPprefixChose]!)/ProfileResetPwd"
    static let URLApiForgetPasswordSendOTP = "\(TPprefix[TPprefixChose]!)/ProfileForgotPwd"
    static let URLApiForgetPasswordReSendOTP = "\(TPprefix[TPprefixChose]!)/ResentOTPForgotPassword"
    
    static let URLApiRequestVerifyDevice = "\(TPprefix[TPprefixChose]!)/RequestVerifyDevice"
    static let URLApiRequestVerifyDeviceOTP = "\(TPprefix[TPprefixChose]!)/VerifyDevice"
    static let URLApiGetListProfilePayment = "\(TPprefix[TPprefixChose]!)/GetListProfilePayment"
    static let URLApiGetCreateProfilePayment = "\(TPprefix[TPprefixChose]!)/CreateProfilePayment"
    static let URLApiDeleteProfilePayment = "\(TPprefix[TPprefixChose]!)/DeleteProfilePayment"
    static let URLApiRegisterStatement = "\(TPprefix[TPprefixChose]!)/RegisterStatement"
    static let URLApiProfileUpdateKYC = "\(TPprefix[TPprefixChose]!)/ProfileUpdateKYC"
    static let URLApiGetListPaymentChannel = "\(TPprefix[TPprefixChose]!)/GetListPaymentChannel"
    static let URLApiGetListProductType = "\(TPprefix[TPprefixChose]!)/GetListProductType"
        //"http://devtopi.amft.vn/VerifyDevice"
        //
    
}

