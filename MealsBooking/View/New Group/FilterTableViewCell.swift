//
//  FilterTableViewCell.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/9/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

  
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    

    
    var restoo : Restaurant!{
        didSet{
            self.name.text = restoo.name
            self.address.text = restoo.address
            self.photo.af_setImage(withURL: URL(string: restoo.photo!)!)
    
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
    
    
    
}

extension FilterTableViewCell
{    func shadowAndBorderForCell(FavorisTableViewCell : UITableViewCell){
        // SHADOW AND BORDER FOR CELL
        //yourTableViewCell.contentView.layer.cornerRadius = 5
        FavorisTableViewCell.contentView.layer.borderWidth = 0.5
        FavorisTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
    
//    FavorisTableViewCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
//    FavorisTableViewCell.contentView.layer.masksToBounds = true
//    yourTableViewCell.layer.shadowColor = UIColor.gray.cgColor
//    FavorisTableViewCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//    FavorisTableViewCell.layer.shadowRadius = 2.0
//    FavorisTableViewCell.layer.shadowOpacity = 1.0
//    yourTableViewCell.layer.masksToBounds = false
//    FavorisTableViewCell.layer.shadowPath = UIBezierPath(roundedRect:yourTableViewCell.bounds, cornerRadius:yourTableViewCell.contentView.layer.cornerRadius).cgPath
    }

    }
    
    
    
    
    

