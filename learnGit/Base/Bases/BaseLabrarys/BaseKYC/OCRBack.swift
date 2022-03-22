//
//  OCRBack.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 26/01/2021.
//

import Foundation

struct OCRBack : Codable {
    let error_code : Int?
    let description : String?
    let data : OCRBackData?

    enum CodingKeys: String, CodingKey {

        case error_code = "error_code"
        case description = "description"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error_code = try values.decodeIfPresent(Int.self, forKey: .error_code)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        data = try values.decodeIfPresent(OCRBackData.self, forKey: .data)
    }

}

struct OCRBackData : Codable {
    var nation = "N/A"
    var religion = "N/A"
    var characteristic = "N/A"
    var issued_on = "N/A"
    var location = "N/A"
    var url = "N/A"

    enum CodingKeys: String, CodingKey {

        case nation = "nation"
        case religion = "religion"
        case characteristic = "characteristic"
        case issued_on = "issued_on"
        case location = "location"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nation = try values.decodeIfPresent(String.self, forKey: .nation) ?? "N/A"
        religion = try values.decodeIfPresent(String.self, forKey: .religion) ?? "N/A"
        characteristic = try values.decodeIfPresent(String.self, forKey: .characteristic) ?? "N/A"
        issued_on = try values.decodeIfPresent(String.self, forKey: .issued_on) ?? "N/A"
        location = try values.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? "N/A"
    }
    
    init() {
    }

}

