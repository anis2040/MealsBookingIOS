//
//  DetailCollectionViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/9/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var bgName: UIView!
    @IBOutlet weak var bgAddress: UIView!
    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()


     setup()
        
        
    }
    
    var restoImages : String!{
        didSet{
     
            self.photo.af_setImage(withURL: URL(string: restoImages!)!)
  
        }
    }
    
    var resto : Restaurant!{
        didSet{
            
            self.name.text = resto.name
            self.address.text = resto.address
            
        }
    }
    
    

    
    func setup() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            ])
    }
    
    
    
    
    
}
