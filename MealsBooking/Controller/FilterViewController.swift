//
//  FilterViewController.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 5/9/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import ExpandingMenu
import MaterialComponents.MaterialCards

class FilterViewController: ViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
var allRestaurants: [Restaurant] = []
    var filteredRestaurantArray: [Restaurant] = []
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var filresto : [Restaurant] = []

    
    func getRestaurants(){
        ApiClient.getAllResto(onSuccess: { (resto) in
            self.allRestaurants = resto
            self.filteredRestaurantArray = self.allRestaurants
            self.tableView.reloadData()
  
        }) { (error) in

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FilterTableViewCell {
            cell.restoo = self.allRestaurants[indexPath.row]
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureExpandingMenuButton()
        
        self.tableView.dataSource =  self
        self.tableView.delegate =  self
        getRestaurants()
        
        
        tableView.reloadData()
    }
    
    func setUpSearchBar(){
        searchBar.delegate = self
    }
//    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredRestaurantArray = allRestaurants
            tableView.reloadData()
            return
        }
        filteredRestaurantArray = allRestaurants.filter({ (restaurant) -> Bool in
            guard let text = searchBar.text else {
                return false
            }
            return  (restaurant.name?.lowercased().contains(text.lowercased()))!
        })
        tableView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch selectedScope {
//        case 0:
//            filteredRestaurantArray = allRestaurants
//        case 1:
//            filteredRestaurantArray = allRestaurants.filter({ (restaurant) -> Bool in
//                restaurant
//            })
//        default:
//            <#code#>
//        }
//    }


    fileprivate func configureExpandingMenuButton() {
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), image: UIImage(named: "chooser-button-tab")!, rotatedImage: UIImage(named: "chooser-button-tab-highlighted")!)
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 72.0)
        self.view.addSubview(menuButton)
        
        func showAlert(_ title: String) {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Ascending", image: UIImage(named: "sort-ascending")!, highlightedImage: UIImage(named: "sort-ascending-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Music")
        }
        
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Descending", image: UIImage(named: "sort-descending")!, highlightedImage: UIImage(named: "sort-descending-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Place")
        }
        
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Ascending By Numeric order", image: UIImage(named: "sort-by-numeric-order")!, highlightedImage: UIImage(named: "sort-by-numeric-order-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Camera")
        }
        
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Descending By Numeric order", image: UIImage(named: "sort-by-order")!, highlightedImage: UIImage(named: "sort-by-order-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Thought")
        }
        
        let item5 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Ascending By Alphabet ", image: UIImage(named: "sort-by-alphabet")!, highlightedImage: UIImage(named: "sort-by-alphabet-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
//            self.allRestaurants.sorted(by: { UIContentSizeCategory(rawValue: $0.name!) > UIContentSizeCategory(rawValue: $1.name!) })
//            
        //  var sortedNames = self.allRestaurants.sorted(n, <)
        
              print("before")
            for resaurant in self.filteredRestaurantArray {
              
                print(resaurant.minPrice!)
                //print(resaurant.name!)
            }
            
            //self.filteredRestaurantArray.sorted(by: {$0.name! < $1.name!})
            self.filteredRestaurantArray.sorted(by: {$0.minPrice! < $1.minPrice!})
            print("after")
            for resaurant in self.filteredRestaurantArray {
                
                print(resaurant.minPrice!)
                  //print(resaurant.name!)
            }
            
           self.filresto = self.filteredRestaurantArray
            
            self.filresto.sorted(by: {$0.minPrice! < $1.minPrice!})
            
            showAlert("Sort Ascending By Alphabet")
        }
//
        
        let item6 = ExpandingMenuItem(size: menuButtonSize, title: "Sort Descending By Alphabet", image: UIImage(named: "sort-reverse-alphabetical-order")!, highlightedImage: UIImage(named: "sort-reverse-alphabetical-order-2")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
            showAlert("Thought")
        }
//
//        let item7 = ExpandingMenuItem(size: menuButtonSize, title: "Thought", image: UIImage(named: "sort-ascending-2")!, highlightedImage: UIImage(named: "sort-ascending")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
//            showAlert("Thought")
//        }
//        
//        let item8 = ExpandingMenuItem(size: menuButtonSize, title: "Thought", image: UIImage(named: "order-2")!, highlightedImage: UIImage(named: "order")!, backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted")) { () -> Void in
//            showAlert("Thought")
//        }
//        
        
    
        
        menuButton.addMenuItems([item1, item2, item3, item4, item5, item6])
        
        menuButton.willPresentMenuItems = { (menu) -> Void in
            print("MenuItems will present.")
        }
        
        menuButton.didDismissMenuItems = { (menu) -> Void in
            print("MenuItems dismissed.")
        }
    }

}
