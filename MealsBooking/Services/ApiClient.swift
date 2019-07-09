//
//  ApiClient.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 01/05/2019.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    struct Api {
        enum BaseURL : String{
            
            case prod = "http://mealsbooking.online/api/"
            case preprod = "http://172.16.1.12:3000/api/"
            case local = "http://127.0.0.1:2000/api/"
          
        }
        static let  baseUrl : String = BaseURL.prod.rawValue
    }
    
    enum Route : String {
        case fetchRestaurants = "restaurants"
        case fetchUser = "user"
        case detailsResoutrant = "details"
        case fetchReservation = "reservations"
        case postRating = "rating"
        case fetchRatings = "ratings"
        var url : String{
            return "\(Api.baseUrl)\(self.rawValue)"
        }
    }
    
    static func getAllResto(
        onSuccess successCallback:  ((_ restos: [Restaurant]) -> Void)?,
        onFailure failureCallback: ((_ error: Error) -> Void)?) {
        
        let url = Route.fetchRestaurants.url
        Alamofire.request( url , method: .get , headers: nil)
            .responseJSON{
                reponse in
                switch reponse.result{
                case .success( _ ):
                    do {
                        let list  = try JSONDecoder().decode(RestaurantList.self, from: reponse.data!)
                        successCallback?(list.restaurants)
                    }
                    catch {
                        print("Unexpected error: \(error).")                        
                        failureCallback?(error)
                    }
                    break
                case .failure(let error):
                    failureCallback?(error)
                    break
                }
        }
        
    }
    
    static func getUser(
        onSuccess successCallback:  ((_ user: [User]) -> Void)?,
        onFailure failureCallback: ((_ error: Error) -> Void)?) {
        
        let url = Route.fetchUser.url
        let token = UserDefaults.standard.string(forKey: "token")
        Alamofire.request(url,headers: ["Authorization": "Bearer " + token!])
            .responseJSON{
                reponse in
                switch reponse.result{
                case .success( let value ):
                    do {
                       // print("result: \(value)." )
                        let user  = try JSONDecoder().decode(User.self, from: reponse.data!)
                        print(user)
                        successCallback?([user])
                    }
                    catch {
                        print("Unexpected error: \(error).")
                        failureCallback?(error)
                    }
                    break
                case .failure(let error):
                    failureCallback?(error)
                    break
                }
        }
         
        }

    
    static func getAllReservations(
        onSuccess successCallback:  ((_ reservation: [Reservation]) -> Void)?,
        onFailure failureCallback: ((_ error: Error) -> Void)?) {
        
        let url = Route.fetchReservation.url
        Alamofire.request( url , method: .get , headers: nil)
            .responseJSON{
                reponse in
                switch reponse.result{
                case .success( _ ):
                    do {
                        let list  = try JSONDecoder().decode(ReservationList.self, from: reponse.data!)
                        successCallback?(list.reservations)
                    }
                    catch {
                        print("Unexpected error: \(error).")
                        failureCallback?(error)
                    }
                    break
                case .failure(let error):
                    failureCallback?(error)
                    break
                }
        }
    }
    
    static func postRating(
        onSuccess successCallback:  ((_ rating: [Rating]) -> Void)?,
        onFailure failureCallback: ((_ error: Error) -> Void)?,user_id:Int,restaurant_id:Int,rating:String,s_rating:String,a_rating:String,h_rating:String,review:String) {
        let url = Route.postRating.url
        let userParametre = ["user_id" : user_id , "restaurant_id" :restaurant_id,"rating" : rating,"s_rating":s_rating,"a_rating":a_rating,"h_rating":h_rating,"review":review] as [String : Any]
        Alamofire.request(url, method: .post, parameters: userParametre, encoding: JSONEncoding.default )
            .responseJSON { (response) in
                
                switch(response.result)
                {
                case .success( _):
                    ProgressHUD.showSuccess("Success !", interaction: true)
                    
                    
                case .failure(_):
                    ProgressHUD.showError("Wrong credantials", interaction: true)
                    
                }
                
        }
    }
    
    static func getRattings(
        onSuccess successCallback:  ((_ reservation: [Rating]) -> Void)?,
        onFailure failureCallback: ((_ error: Error) -> Void)?) {
        
        let url = Route.fetchRatings.url
        Alamofire.request( url , method: .get , headers: nil)
            .responseJSON{
                reponse in
                switch reponse.result{
                case .success( _ ):
                    do {
                        let list  = try JSONDecoder().decode(RatingList.self, from: reponse.data!)
                        successCallback?(list.ratings)
                    }
                    catch {
                        print("Unexpected error: \(error).")
                        failureCallback?(error)
                    }
                    break
                case .failure(let error):
                    failureCallback?(error)
                    break
                }
        }
    }
    

        
    }
