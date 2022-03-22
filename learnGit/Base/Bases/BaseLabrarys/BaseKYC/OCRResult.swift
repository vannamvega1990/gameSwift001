//
//  OCRResult.swift
//  VegaFintecheKYC
//
//  Created by Nguyễn Quang on 4/8/21.
//

import Foundation

public struct OCRResult : Codable {
    var id = "N/A" //id OCR
    var name = "N/A" //Họ và tên
    var dob = "N/A" //Ngày tháng năm sinh
    var gender = "N/A" //Giới tính
    var hometown = "N/A" //Quê quán
    var address = "N/A" //Địa chỉ
    var expired = "N/A" //Ngày hết hạn
    var nation = "N/A" //Quốc tịch
    var religion = "N/A" //
    var characteristic = "N/A" //Đặc điểm nhận dạng
    var issued_on = "N/A" //ngày tháng năm cấp CMT/CCCD
    var location = "N/A" //nơi cấp CMT/CCCD
    var imageResult = "N/A" //điểm số tỉ lệ giống nhau nếu nhận diện là real - fake thì sẽ không có gì
    var fakeOrReal = "N/A" //kết quả nhận diện khuôn mặt
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case dob = "dob"
        case gender = "gender"
        case hometown = "hometown"
        case address = "address"
        case expired = "expired"
        case nation = "nation"
        case religion = "religion"
        case characteristic = "characteristic"
        case issued_on = "issued_on"
        case location = "location"
        case imageResult = "imageResult"
        case fakeOrReal = "fakeOrReal"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? "N/A"
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        dob = try values.decodeIfPresent(String.self, forKey: .dob) ?? "N/A"
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? "N/A"
        hometown = try values.decodeIfPresent(String.self, forKey: .hometown) ?? "N/A"
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? "N/A"
        expired = try values.decodeIfPresent(String.self, forKey: .expired) ?? "N/A"
        nation = try values.decodeIfPresent(String.self, forKey: .nation) ?? "N/A"
        religion = try values.decodeIfPresent(String.self, forKey: .religion) ?? "N/A"
        characteristic = try values.decodeIfPresent(String.self, forKey: .characteristic) ?? "N/A"
        issued_on = try values.decodeIfPresent(String.self, forKey: .issued_on) ?? "N/A"
        location = try values.decodeIfPresent(String.self, forKey: .location) ?? "N/A"
        imageResult = try values.decodeIfPresent(String.self, forKey: .imageResult) ?? "N/A"
        fakeOrReal = try values.decodeIfPresent(String.self, forKey: .fakeOrReal) ?? "N/A"
    }
    
    public init() {
        
    }
}
