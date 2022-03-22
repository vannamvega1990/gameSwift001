//
//  TPPaymentObject.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/1/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import ObjectMapper

class TPPaymentObjectAray: Mappable {

    //var animals: [Animals]?
    var code: Int?
    var data: [TPPaymentObject]?
    var sessage: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        code <- map["Code"]
        sessage <- map["Message"]
        data <- map["Data"]
    }
}

class TPPaymentObject: Mappable {

    var ProfilePaymentId: Int?
    var PaymentChannelId: Int?
    var PaymentChannelName: String?
    var PaymentChannelImage: String?
    var ProfileId:Int?
    var PaymentName: String?
    var PaymentNumber: String?
    var Status: Int?

    required init?(map: Map){
        
    }

    func mapping(map: Map) {
        ProfilePaymentId  <- map["ProfilePaymentId"]
        PaymentChannelId <- map["PaymentChannelId"]
        PaymentChannelName <- map["PaymentChannelName"]
        PaymentChannelImage <- map["PaymentChannelImage"]
        ProfileId <- map["ProfileId"]
        PaymentName <- map["PaymentName"]
        PaymentNumber <- map["PaymentNumber"]
        Status <- map["Status"]
    }
}
