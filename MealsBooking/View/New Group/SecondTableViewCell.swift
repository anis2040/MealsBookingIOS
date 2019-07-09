//
//  SecondTableViewCell.swift
//  MealsBooking
//
//  Created by Anis on 5/1/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    let categoriesArray = ["Tunisian","Mexican","Marrocan","Italien","Turkish","libanese"]
    let categoriesImageArray = ["tunisienne","mexicaine","marroc","italienne","turques","libanaise"]

    var restos : [Restaurant]!{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.restos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: SecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell3", for: indexPath) as? SecondCollectionViewCell
        {
            cell.resto = self.categoriesArray[indexPath.row]
            cell.restoImage = self.categoriesImageArray[indexPath.row]

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 120, height: 120)
        return size
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


}
