//
//  Rating.swift
//  MealsBooking
//
//  Created by Anis on 5/15/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//
import Foundation

class RatingList:Codable{
    var ratings : [Rating]
    enum CodingKeys: String, CodingKey {
        case ratings = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ratings = try values.decodeIfPresent([Rating].self, forKey: .ratings) ?? [Rating]()
    }
    
}
class Rating: Codable {
    var id: Int
    var user: User?
    var restaurant: Restaurant?
    var rating : String
    var s_rating : String
    var a_rating : String
    var h_rating : String
    var review : String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "user"
        case restaurant = "restaurant"
        case rating = "rating"
        case s_rating = "s_rating"
        case a_rating = "a_rating"
        case h_rating = "h_rating"
        case review = "review"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        user = try values.decodeIfPresent(User.self, forKey: .user)
        restaurant = try values.decodeIfPresent(Restaurant.self, forKey: .restaurant)
        rating = try values.decodeIfPresent(String.self, forKey: .rating) ?? "Unknown"
        s_rating = try values.decodeIfPresent(String.self, forKey: .s_rating) ?? "Unknown"
        a_rating = try values.decodeIfPresent(String.self, forKey: .a_rating) ?? "Unknown"
        h_rating = try values.decodeIfPresent(String.self, forKey: .h_rating) ?? "Unknown"
        review = try values.decodeIfPresent(String.self, forKey: .review) ?? "Unknown"
    
    }
    
    
    init(id: Int, user: User, restaurant: Restaurant,rating: String,s_rating: String,a_rating: String,h_rating: String, review: String){
        self.id = id
        self.user = user
        self.restaurant = restaurant
        self.rating = rating
        self.s_rating = rating
        self.a_rating = rating
        self.h_rating = rating
        self.review = review
    }
    
}
