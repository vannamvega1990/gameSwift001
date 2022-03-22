//
//  UserInfoObject.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/26/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfoObject: Mappable {

    //var animals: [Animals]?
    var code: String?
    var data: DataUserInfo?
    var sessage: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        code <- map["Code"]
        sessage <- map["Message"]
        data <- map["Data"]
    }
}

class DataUserInfo: Mappable {

    var access_token: String?
    var device_token: String?
    var avatar_url: String?
    var profile_id: Int?
    var status_verify_email: Bool?
    var status_verify_kyc: Bool?
    var status_verified: Bool?
    var status_is_register_statement:Bool?
    var status_id: Int?
    var id_image_back: String?
    var id_image_front: String?
    var email: String?
    var mobile: String?
    var full_name: String?
    var birth_day: String?
    var gender: Int?
    var address: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        
        access_token  <- map["access_token"]
        device_token <- map["device_token"]
        avatar_url <- map["avatar_url"]
        profile_id <- map["profile_id"]
        status_verify_email <- map["status_verify_email"]
        status_verify_kyc <- map["status_verify_kyc"]
        status_verified <- map["status_verified"]
        status_is_register_statement <- map["status_is_register_statement"]
        status_id <- map["status_id"]
        id_image_back <- map["id_image_back"]
        id_image_front <- map["id_image_front"]
        email <- map["email"]
        mobile <- map["mobile"]
        full_name <- map["full_name"]
        birth_day <- map["birth_day"]
        gender <- map["gender"]
        address <- map["address"]
        
//        access_token <- map["access_token"]
//        email <- map["email"]
//        mobile <- map["mobile"]
//        full_name <- map["full_name"]
//        birth_day <- map["birth_day"]
//        gender <- map["gender"]
//        address <- map["address"]
    }
}
