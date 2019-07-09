//
//  RestoTableViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/1/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
protocol FirstTableDelegate {
    func didSelect(resto : Restaurant)
}
class FirstTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var delegate : FirstTableDelegate!
    var restos : [Restaurant] = []
    var size : CGSize!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func setup(restos: [Restaurant]){
        self.restos = restos
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
   
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension FirstTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.didSelect(resto: restos[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell1", for: indexPath) as? FirstCollectionViewCell
        {
            cell.onClickListner = {(resto) in
                self.delegate.didSelect(resto: resto)
            }
            cell.resto = self.restos[indexPath.row]
            
            return cell
        }
    
        return UICollectionViewCell()
    }
    
    

}



extension FirstTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        //let size = CGSize(width: collectionView.bounds.width-10, height: collectionView.bounds.height)
        return size
    }
    
}
