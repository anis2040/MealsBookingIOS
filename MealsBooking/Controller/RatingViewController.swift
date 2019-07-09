//
//  RatingViewController.swift
//  MealsBooking
//
//  Created by Anis on 5/9/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire

class RatingViewController: UIViewController {
    
    
    var ratingStars:Double = 3.0
    var serviceStars:Double = 3.0
    var ambienceStars:Double = 3.0
    var hygieneStars:Double = 3.0
    var restaurant_id:Int?
    var idUser : Int?
    var ratingM: [Rating] = []
    var ratingList : [Rating] = []
    @IBOutlet weak var foodRating: CosmosView!
    @IBOutlet weak var serviceRating: CosmosView!
    @IBOutlet weak var ambienceRating: CosmosView!
    @IBOutlet weak var hygieneRating: CosmosView!
    
    @IBOutlet weak var review: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        foodRating.rating = 3
        serviceRating.rating = 3
        ambienceRating.rating = 3
        hygieneRating.rating = 3
        rating()
        getCurrentUser()
    }
    
  
    
    func getCurrentUser() {
        ApiClient.getUser(onSuccess: { (user) in
            self.idUser = user[0].id
        }) { (error) in
            
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    func rating() {
        foodRating.didFinishTouchingCosmos = { rating in self.ratingStars = rating }
        serviceRating.didFinishTouchingCosmos = { rating in self.serviceStars = rating }
        ambienceRating.didFinishTouchingCosmos = { rating in self.ambienceStars = rating }
        hygieneRating.didFinishTouchingCosmos = { rating in self.hygieneStars = rating }
    }
    func getRatings() {
     
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        ApiClient.getRattings(onSuccess: { (rating) in
            rating.forEach({ (r) in
                if (r.restaurant?.id == self.restaurant_id && r.user?.id == self.idUser) {
                    ProgressHUD.showError("You can't review the same restaurant more than once!", interaction: true)
                }
                else {
                ApiClient.postRating(onSuccess: { (ratingM) in
                }, onFailure: { (error) in
                }, user_id: self.idUser!, restaurant_id: self.restaurant_id!, rating: String(self.ratingStars), s_rating: String(self.serviceStars), a_rating: String(self.ambienceStars), h_rating: String(self.hygieneStars), review: self.review.text)
                self.dismiss(animated: true, completion:nil)
                    
                }
            })
        }) { (Error) in
        }
      
    }
    

}

