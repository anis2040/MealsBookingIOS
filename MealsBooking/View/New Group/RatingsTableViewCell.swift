//
//  RatingsTableViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/15/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Cosmos

class RatingsTableViewCell: UITableViewCell {

    let size = CGSize(width: 60.0, height: 60.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileIV.layer.cornerRadius = self.profileIV.frame.size.width / 2
        self.profileIV.clipsToBounds = true
        // Initialization code
    }

    
    @IBOutlet weak var profileIV: UIImageView!
    @IBOutlet weak var reviewTV: UITextView!
    @IBOutlet weak var userL: UILabel!
    @IBOutlet weak var rating: CosmosView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        rating.settings.updateOnTouch = false

        
    }
    
    var ratings : Rating!{
        didSet{
            
            // self.profileIV.af_setImage(withURL: URL(string: ratings.!)!)
            rating.rating = (Double(ratings.rating)! + Double(ratings.a_rating)! + Double(ratings.h_rating)! + Double(ratings.s_rating)!)/4
            self.userL.text = ratings.user?.name
            self.reviewTV.text = ratings.review
            
        }
    }


}
