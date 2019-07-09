//
//  User.swift
//  MealsBooking
//
//  Created by Anis on 5/2/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
class User: Codable {
    var id: Int
    var name: String
    var email : String
    var date : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case date = "created_at"
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? "Unknown"
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? "Unknown"


    }
    
    
    init(id: Int, name: String, email: String, date : String){
        self.id = id
        self.name = name
        self.email = email
        self.date = date
    }
    
}
