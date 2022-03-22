//
//  SocialObject.swift
//  VegaFintech
//
//  Created by Tu Dao on 6/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//


import Foundation
import ObjectMapper

class SocialArray: Mappable {

    var data: [SocialInfo]?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        
        data <- map["Data"]
    }

}

class SocialInfo: Mappable {

    var SocialId: String?
    var SocialType: Int?
    var SocialTypeSub: String?
    var SocialEmailOrMobile: String?
    var SocialName: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        SocialId <- map["SocialId"]
        SocialType <- map["SocialType"]
        SocialTypeSub <- map["SocialTypeSub"]
        SocialEmailOrMobile <- map["SocialEmailOrMobile"]
        SocialName <- map["SocialName"]

    }
}
