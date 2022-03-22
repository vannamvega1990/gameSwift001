//
//  TPTransactionProductObject.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

//
//  TPProductTypeObject.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import ObjectMapper

class TPTransactionProductObjectArray: Mappable {

    //var animals: [Animals]?
    var code: Int?
    var data: dataObj?
    var sessage: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        code <- map["Code"]
        sessage <- map["Message"]
        data <- map["Data"]
    }
}

class dataObj: Mappable {
    var TransactionProducts: [TPTransactionProductObject]?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        TransactionProducts  <- map["TransactionProducts"]
    }
}

class TPTransactionProductObject: Mappable {

    var ProfileProductTransId: Int?
    var ProductId: Int?
    var ProductName: String?
    var TransactionType: Int?
    var ProfileId:Int?
    var TransactionName: String?
    var OrderNo: String?
    var TotalValue: Double?
    var Quantity: Double?
    var Price: Int?
    var ApproveTime: String?
    var ApprovePrice: Int?
    var Fee: Double?
    var Slippage: Double?
    var CreateAt: String?
    var UpdateAt: String?
    var Status: Int?
    var ProductCode: Int?
    var TransactionTypeStr: String?
    var StatusStr: String?

    required init?(map: Map){
        
    }

    func mapping(map: Map) {
        ProfileProductTransId  <- map["ProfileProductTransId"]
        ProductId <- map["ProductId"]
        ProductName <- map["ProductName"]
        TransactionType <- map["TransactionType"]
        ProfileId <- map["ProfileId"]
        TransactionName <- map["TransactionName"]

        OrderNo  <- map["OrderNo"]
        TotalValue <- map["TotalValue"]
        Quantity <- map["Quantity"]
        Price <- map["Price"]
        ApproveTime <- map["ApproveTime"]
        ApprovePrice <- map["ApprovePrice"]
        
        Fee  <- map["Fee"]
        Slippage <- map["Slippage"]
        CreateAt <- map["CreateAt"]
        UpdateAt <- map["UpdateAt"]
        Status <- map["Status"]
        ProductCode <- map["ProductCode"]
        TransactionTypeStr <- map["TransactionTypeStr"]
        StatusStr <- map["StatusStr"]
    }
}


