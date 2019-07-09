//
//  ProfileViewController.swift
//  MealsBooking
//
//  Created by Anis on 5/2/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import CoreData
import NVActivityIndicatorView
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController,NVActivityIndicatorViewable ,UITableViewDelegate, UITableViewDataSource, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func editBtn(_ sender: Any) {
        performSegue(withIdentifier: "editProfile", sender: Any?.self)
    }
    
    var reservationList : [Reservation] = []
    var favorisList : [NSManagedObject]    = []
    var favoris : [Restaurant]    = []
    
    var idUser : Int?
    var user : [User] = []
    
    var  fullName : String?
  
    let size = CGSize(width: 60.0, height: 60.0)
    
    var activityIndicator : NVActivityIndicatorView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  getCurrentUser()
       // sign(GIDSignIn?, didSignInFor: GIDGoogleUser?, withError: Error?)
        
        
        
        
        getFBUserData()
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        // add your color
        let activityData = ActivityData()
        
        fetchRestaurant()
        getReservations()
        
       tableView.reloadData()
        startAnimating(size, message: "Loading",color: UIColor.white, textColor: UIColor.white, fadeInAnimation: nil)
     
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.stopAnimating()
        }
        
    }
    
    func getCurrentUser() {
        ApiClient.getUser(onSuccess: { (user) in
            self.user = user
            self.idUser = user[0].id
            self.nameLabel.text = user[0].name
            self.emailLabel.text = user[0].email
        }) { (error) in
            
        }
    }
    
    
    @IBAction func logoutBtn(_ sender: UIButton) {
      
        
        if((FBSDKAccessToken.current()) != nil){
        FBSDKLoginManager().logOut()
        }
        UserDefaults.standard.set(nil, forKey: "token")
        self.performSegue(withIdentifier: "logout", sender: Any?.self)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segment.selectedSegmentIndex {
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteItemCell", for: indexPath) as? FavorisTableViewCell {
            
                
                cell.favourites = self.favoris[indexPath.row]
                return cell


            }
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationTableViewCell", for: indexPath) as? ReservationTableViewCell {
                    cell.userId = idUser
                    cell.reservation = self.reservationList[indexPath.row]
                
                
                
                    return cell
            }
            
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationTableViewCell", for: indexPath) as? ReservationTableViewCell {
                cell.reservation = self.reservationList[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segment.selectedSegmentIndex)
        {
        case 0:
            return  reservationList.count
        case 1:
            return favorisList.count
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if segment.selectedSegmentIndex == 1
        {
            
            if editingStyle == .delete{
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                let persistentContainer = appdelegate.persistentContainer
                let managedContext = persistentContainer.viewContext
                managedContext.delete(favorisList[indexPath.row])
                
                
                do{
                    try managedContext.save()
                    
                }catch{ let nserror = error as NSError
                    print(nserror.userInfo)
                }
                favorisList.remove(at: indexPath.row)
                tableView.reloadData()
            }
            
      }
    }
    
    
    @IBAction func segmentedControlActionChanged(_ sender: UISegmentedControl) {
        switch(segment.selectedSegmentIndex)
        {
        case 0:
            tableView.reloadData()
            
        case 1:
            tableView.reloadData()
            
        default:
            break
            
        }
    }
    
    func fetchRestaurant(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurants")
        do{
            try favorisList = managedContext.fetch(fetchRequest)
            for data in favorisList {
                var name = data.value(forKey: "name") as! String
                var photo = data.value(forKey: "image") as! String
                var address = data.value(forKey: "address") as! String
                
                favoris.append(Restaurant(name: name, photo: photo, address: address))
                
                //    favoris.append(data.value(forKey: "image") as! String)
                
                
            }
            tableView.reloadData()
            
        }catch{
            
            let nserror = error as NSError
            print(nserror.userInfo)
        }
        
          tableView.reloadData()
    }
    
    
    func getReservations(){
        ApiClient.getAllReservations(onSuccess: { (resarvations) in
            self.reservationList = resarvations
            self.tableView.reloadData()
        }) { (error) in
            
        }
        
    }
    
    
    func getFBUserData(){
       
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result)
                    
                    if
                        let fields = result as? [String:Any],
                        let firstName = fields["first_name"] as? String,
                        let lastName = fields["last_name"] as? String,
                        let email = fields["email"] as? String,
                        let imageURL = ((fields["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
                        //let picture = fields["picture.type(large)"] as? String
                    {
                        self.nameLabel.text = "\(firstName) \(lastName)"
                        self.emailLabel.text = email
                        let url = URL(string: imageURL)
                        let data = NSData(contentsOf: url!)
                        let image = UIImage(data: data! as Data)
                        self.imageView.image = image
                        
                        print("firstName -> \(firstName)")
                        print("lastName -> \(lastName)")
                        
                        print("picture -> \(imageURL)")
                    }
                    
//                    self.nameLabel.text = result as! String
//                    self.emailLabel.text = self.user[0].email
                    
                    
                }
            })
        }else{
            
            if fullName != nil {
                print(fullName)
                
            }
            getCurrentUser()
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
             self.fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    
    
    
}
