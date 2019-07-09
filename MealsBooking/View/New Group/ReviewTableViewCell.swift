//
//  ReviewTableViewCell.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/16/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Cosmos

class ReviewTableViewCell: UITableViewCell {
    
    

    
    var rating : Rating!{
        didSet{
            
        
          //  self.reviewText.text = restoMenu.price
//            self.image.af_setImage(withURL: URL(string: restoMenu.photo)!)
            
        }
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var reviewText: UITextView!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
