//
//  Face2Face.swift
//  VegaFintecheKYC
//
//  Created by Dương Tú on 01/02/2021.
//

import Foundation

struct Face2Face : Codable {
    let status_code : Int?
    let match_score : Double?
    let predict : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case status_code = "status_code"
        case match_score = "match_score"
        case predict = "predict"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        match_score = try values.decodeIfPresent(Double.self, forKey: .match_score)
        predict = try values.decodeIfPresent(String.self, forKey: .predict)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
