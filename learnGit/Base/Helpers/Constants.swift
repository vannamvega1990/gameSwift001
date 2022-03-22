//
//  Constants.swift
//  FinTech
//
//  Created by Tu Dao on 5/20/21.
//  Copyright © 2021 vega. All rights reserved.
//

import Foundation
import UIKit

class Constants: NSObject {

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
        public static var appID: String                    = "19"
        //        static let accessToken: String              = "BpDzET7vZFJbugK8NVGMCSIAnOyaqdmX"
        //        static let appID: String              = "13"
        //public static var accessToken: String       = "BpDzET7vZFJbugK8NVGMCSIAnOyaqdmX"
        //public static var accessToken: String       = "NDz7GaRhY9LPTpydw3QIFUc1562qgVZu"
        public static var accessToken: String       = "vzceREw1JkujaxnHLbimPqpUBFlhIGrK"
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
    
    static let URLApiLogin = "http://nguyendev.amft.vn/Login"
    static let URLApiResendOTP = "http://nguyendev.amft.vn/RegisterProfileResentOTP"
    static let URLApiVerifyOTP = "http://nguyendev.amft.vn/RegisterProfileVerifyOTP"
    static let URLApiRegister = "http://nguyendev.amft.vn/RegisterProfile"
    static let URLApiRegisterViaSocial = "http://nguyendev.amft.vn/SocialRegisterProfile"
    
    //static let URLApiCheckAuthenSocial = "http://nguyendev.amft.vn/SocialCheckAuthen"
    
    static let URLApiCheckAuthenSocial = "http://devtopi.amft.vn/SocialCheckAuthen"
    
    static let URLApiGetInfoUser = "http://nguyendev.amft.vn/ProfileGetInfo"
    static let URLApiGetListLinkedSocial = "http://nguyendev.amft.vn/SocialListConnected"
    static let URLApiLogout = "http://nguyendev.amft.vn/Logout"
    static let URLApiChangePassword = "http://nguyendev.amft.vn/ProfileChangePwd"
    static let URLApiSocialRegisterResentOTP = "http://nguyendev.amft.vn/SocialRegisterResentOTP"
    static let URLApiLinkSocial = "http://nguyendev.amft.vn/SocialConnect"
    static let URLApiDisLinkSocial = "http://nguyendev.amft.vn/SocialDisconnect"
    static let URLApiForgetPasswordOTP = "http://nguyendev.amft.vn/ProfileForgotPwd"
    static let URLApiResetPassword = "http://nguyendev.amft.vn/ProfileResetPwd"

}
