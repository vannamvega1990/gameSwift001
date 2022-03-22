//
//  OCRFront.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 26/01/2021.
//

import Foundation

struct OCRFront : Codable {
    let error_code : Int?
    let description : String?
    let data : OCRFrontData?
    
    enum CodingKeys: String, CodingKey {
        
        case error_code = "error_code"
        case description = "description"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error_code = try values.decodeIfPresent(Int.self, forKey: .error_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        data = try values.decodeIfPresent(OCRFrontData.self, forKey: .data)
    }
    
}

struct OCRFrontData : Codable {
    var id = "N/A"
    var name = "N/A"
    var dob = "N/A"
    var gender = "N/A"
    var hometown = "N/A"
    var address = "N/A"
    var expired = "N/A"
    var url = "N/A"
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case dob = "dob"
        case gender = "gender"
        case hometown = "hometown"
        case address = "address"
        case expired = "expired"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? "N/A"
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        dob = try values.decodeIfPresent(String.self, forKey: .dob) ?? "N/A"
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? "N/A"
        hometown = try values.decodeIfPresent(String.self, forKey: .hometown) ?? "N/A"
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? "N/A"
        expired = try values.decodeIfPresent(String.self, forKey: .expired) ?? "N/A"
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? "N/A"
    }
    
    init() {
    }
    
}
