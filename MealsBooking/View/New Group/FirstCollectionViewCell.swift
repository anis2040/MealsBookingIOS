//
//  RestoCollectionViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/1/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit


class FirstCollectionViewCell: UICollectionViewCell {
   
    var resto : Restaurant!{
        didSet{
            self.rName.text = resto.name
            self.rPhoto.af_setImage(withURL: URL(string: resto.photo!)!)
            self.rPrice.text = resto.minPrice
            self.rAddress.text = resto.address
            self.contentView.cornerRadius = 20
        }
    }
 
    var onClickListner: (Restaurant) -> Void = {(Restaurant) -> Void in}
    
    @IBAction func hearDidTapped(_ sender: Any) {
        self.onClickListner(resto)
    }
    
    @IBOutlet weak var rPhoto: UIImageView!
    @IBOutlet weak var rName: UILabel!
    @IBOutlet weak var rAddress: UILabel!
    @IBOutlet weak var rPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }
}

