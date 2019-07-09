//
//  HomeIndexViewController.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 4/25/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import NVActivityIndicatorView

class HomeIndexViewController: UIViewController,NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var tableView: UITableView!
    

    
    var allRestaurants: [Restaurant] = []
    var activityIndicator : NVActivityIndicatorView!
    var animating = true
    let activityData = ActivityData()
    let size = CGSize(width: 60.0, height: 60.0)
    var selectedReso: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        self.tableView.dataSource =  self
        self.tableView.delegate =  self
        startAnimating(size, message: "Loading",color: UIColor.white, textColor: UIColor.white, fadeInAnimation: nil)
        getRestaurants()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
    }
    
    
    func getRestaurants(){
        ApiClient.getAllResto(onSuccess: { (resto) in
            self.allRestaurants = resto
            self.tableView.reloadData()
            self.animating = false
        }) { (error) in
            
        }
        
    }
}


extension HomeIndexViewController :  UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Most Viewed"
        case 1:
            return "Popular"
        default:
            return "Categories"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "restoCell1", for: indexPath) as? FirstTableViewCell{
                cell.setup(restos: self.allRestaurants)
                cell.size = CGSize(width: ((cell.bounds.width)-10), height: cell.bounds.height)
                cell.delegate =  self
                
                return cell
            }
            return UITableViewCell()
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "restoCell1", for: indexPath) as? FirstTableViewCell{
                cell.setup(restos: self.allRestaurants)
                cell.size = CGSize(width: cell.bounds.width/2, height: cell.bounds.height)
                cell.delegate = self

                
                return cell
            }
            return UITableViewCell()
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "restoCell3", for: indexPath) as? SecondTableViewCell{
                cell.restos = self.allRestaurants
                

                return cell
            }
            
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}



extension HomeIndexViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //    {
        switch indexPath.section {
        case 0:
            return 350
        case 1:
            return 200
        default:
            return 200
        }
    }
    
    
}

extension HomeIndexViewController : FirstTableDelegate {
    func didSelect(resto: Restaurant) {
        self.selectedReso = resto
        self.performSegue(withIdentifier: "segueDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let destinationVC = segue.destination as? DetailViewController {
            destinationVC.resto = self.selectedReso
        }
    }
    
    
}



extension UIView {
    func rounded(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.rounded(cornerRadius: newValue)
        }
    }
}
