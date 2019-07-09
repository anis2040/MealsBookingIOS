//
//  FavouriteItemCell.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/8/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit


class FavorisTableViewCell: UITableViewCell {
    
    var favourites : Restaurant!{
        didSet{
            
            self.imageF.af_setImage(withURL: URL(string: favourites.photo!)!)
            self.nameF.text = favourites.name
            self.addressF.text = favourites.address
            
        }
    }
    
    
   
    @IBOutlet weak var cell: UIView!
    
    @IBOutlet weak var imageF: UIImageView!
    @IBOutlet weak var nameF: UILabel!
    @IBOutlet weak var addressF: UILabel!
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageF.layer.cornerRadius = 10
        self.imageF.clipsToBounds = true
  
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

    
    
    
}

