//
//  TPProductTypeObject.swift
//  VegaFintech
//
//  Created by tran dinh thong on 8/4/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation
import ObjectMapper

class TPProductTypeObjectArray: Mappable {

    //var animals: [Animals]?
    var code: Int?
    var data: [TPProductTypeObject]?
    var sessage: String?

    required init?(map: Map){
    }

    func mapping(map: Map) {
        code <- map["Code"]
        sessage <- map["Message"]
        data <- map["Data"]
    }
}

class TPProductTypeObject: Mappable {

    var ProductTypeId: Int?
    var ProductTypeParentId: Int?
    var Name: String?
    var Code: String?
    var Description:String?
    var Statis: Int?

    required init?(map: Map){
        
    }

    func mapping(map: Map) {
        ProductTypeId  <- map["ProductTypeId"]
        ProductTypeParentId <- map["ProductTypeParentId"]
        Name <- map["Name"]
        Code <- map["Code"]
        Description <- map["Description"]
        Statis <- map["Statis"]
    }
}

