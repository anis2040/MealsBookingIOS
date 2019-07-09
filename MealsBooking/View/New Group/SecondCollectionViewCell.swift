//
//  CategoriesCollectionViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/1/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cPhoto: UIImageView!
    @IBOutlet weak var cName: UILabel!
    
    var onClickListner: (Restaurant) -> Void = {(Restaurant) -> Void in}
        
    var resto : String!{
        didSet{
            self.cName.text = resto
            
        }
    }
    
    var restoImage : String!{
        didSet{
            self.cPhoto.image = UIImage(named: restoImage)
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
