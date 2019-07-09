//
//  Image.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/15/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
class Image: Codable {
   
    var photo1: String
    var photo2 : String
    var photo3 : String
    
    enum CodingKeys: String, CodingKey {
      
        case photo1 = "photo1"
        case photo2 = "photo2"
        case photo3 = "photo3"
        
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
      
        photo1 = try values.decodeIfPresent(String.self, forKey: .photo1) ?? "Unknown"
        photo2 = try values.decodeIfPresent(String.self, forKey: .photo2) ?? "Unknown"
        photo3 = try values.decodeIfPresent(String.self, forKey: .photo3) ?? "Unknown"
        
        
    }
    
    
    init(id: Int, photo1: String, photo2: String, photo3 : String){
      
        self.photo1 = photo1
        self.photo2 = photo2
        self.photo3 = photo3
    }
    
}
