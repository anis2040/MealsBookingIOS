//
//  Reservation.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/8/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation

class ReservationList:Codable{
    var reservations : [Reservation]
    enum CodingKeys: String, CodingKey {
        case reservations = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reservations = try values.decodeIfPresent([Reservation].self, forKey: .reservations) ?? [Reservation]()
    }
    
}

class Reservation: Codable {
    
    var nbPerson: String
    var time : String
    var approved : String
    var resto : Restaurant?
    var user : User?
    
    enum CodingKeys: String, CodingKey {
        
        case nbPerson = "name"
        case time = "time"
        case approved = "approved"
        case resto = "restaurant"
        case user = "user"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nbPerson = try values.decodeIfPresent(String.self, forKey: .nbPerson) ?? "Unknown"
        time = try values.decodeIfPresent(String.self, forKey: .time) ?? "Unknown"
        approved = try values.decodeIfPresent(String.self, forKey: .approved) ?? "Unknown"
        resto = try values.decodeIfPresent(Restaurant.self, forKey: .resto)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }
    
    
    init(nbPerson: String, time: String, approved: String){
        self.nbPerson = nbPerson
        self.time = time
        self.approved = approved
}

}
