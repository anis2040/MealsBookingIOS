//
//  ReservationTableViewCell.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/14/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageR: UIImageView!
    @IBOutlet weak var nameR: UILabel!
    @IBOutlet weak var addressR: UILabel!
    @IBOutlet weak var approved: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    
    var id : Int?
    var userId : Int!{
        didSet{
            id = userId
            
        }
    }
   
    
    var reservation : Reservation!{
        didSet{
            
            if id == reservation.user?.id
            {
                self.imageR.af_setImage(withURL: URL(string: (reservation.resto?.photo!)!)!)
                self.nameR.text = reservation.resto?.name
                self.date.text = reservation.user?.date
                
                if reservation.approved == "1"{
                    approved.image = UIImage(named: "approved")
                }
                else {
                    approved.image = UIImage(named: "denied")
                }
                self.addressR.text = reservation.resto?.address
            
            }
          }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageR.layer.cornerRadius = 10
        self.imageR.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
