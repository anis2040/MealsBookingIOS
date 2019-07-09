//
//  MenuCollectionViewCell.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/16/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import AlamofireImage

class MenuCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
 
    
    var restoMenu : Menu!{
        didSet{
            
            self.name.text = restoMenu.name
            self.price.text = restoMenu.price
            self.image.af_setImage(withURL: URL(string: restoMenu.photo)!)
            
        }
    }
    
}
