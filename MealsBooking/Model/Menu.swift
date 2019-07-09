//
//  Image.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/15/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
class Menu: Codable {
    
    var name: String
    var price : String
    var photo : String
    
    enum CodingKeys: String, CodingKey {
        
        case name = "food_name"
        case price = "price"
        case photo = "photo"
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        price = try values.decodeIfPresent(String.self, forKey: .price) ?? "Unknown"
        photo = try values.decodeIfPresent(String.self, forKey: .photo) ?? "Unknown"
        
        
    }
    
    
    init(id: Int, name: String, price: String, photo : String){
        
        self.name = name
        self.price = price
        self.photo = photo
    }
    
}
