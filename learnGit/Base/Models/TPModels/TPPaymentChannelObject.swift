//
//  TPPaymentChannelObject.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/3/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import ObjectMapper

class TPPaymentChannelObjectArray: Mappable {

    //var animals: [Animals]?
    var code: Int?
    var data: [TPPaymentChannelObject]?
    var sessage: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        code <- map["Code"]
        sessage <- map["Message"]
        data <- map["Data"]
    }
}

class TPPaymentChannelObject: Mappable {

    var PaymentTypeId: Int?
    var PaymentChannelId: Int?
    var Name: String?
    var Description: String?
    var Fee:Double?
    var Image: String?
    var Status: Int?

    required init?(map: Map){
        
    }

    func mapping(map: Map) {
        PaymentTypeId  <- map["PaymentTypeId"]
        PaymentChannelId <- map["PaymentChannelId"]
        Name <- map["Name"]
        Description <- map["Description"]
        Fee <- map["Fee"]
        Image <- map["Image"]
        Status <- map["Status"]
    }
}

