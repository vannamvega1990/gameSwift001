//
//  Objects.swift
//  VegaFintech
//
//  Created by Tu Dao on 5/26/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var dateFile: String
}

extension User: CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        ID: \(id)
        FirstName: \(firstName)
        LastName: \(lastName)
        Email: \(email)
        """
    }
}

struct UserInfo: Codable {
    let email: String
    let name: String
}

struct Person: Codable {
    var name: String
    var age: Int
}

struct User1: Codable {
     var id: String
     var name: String
     var username: String

}

class Mapper<T: Codable> {
     
     private var json: [String: Any]?

     public init(_ json: [String: Any]) {
          self.json = json
     }

     func map() -> T? {
          
          guard let _json = json, JSONSerialization.isValidJSONObject(_json) else { return nil }
          guard let data = try? JSONSerialization.data(withJSONObject: _json) else { return nil }
          return try? JSONDecoder().decode(T.self, from: data)

     }

}
