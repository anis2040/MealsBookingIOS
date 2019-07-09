//
//  DetailViewController.swift
//  MealsBooking
//
//  Created by Anis on 5/3/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Cosmos
import MapKit
import AlamofireImage
import CoreData

class DetailViewController: UIViewController{
   
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var maxPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var fRating: CosmosView!
    @IBOutlet weak var sRating: CosmosView!
    @IBOutlet weak var aRating: CosmosView!
    @IBOutlet weak var hRating: CosmosView!
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    weak var delegate: LocationActions?
    
   
    var resto : Restaurant!
    var user : [User] = []
    var ratingList : [Rating] = []
    var average:Double = 0.0
    var averageF:Double = 0.0
    var averageS:Double = 0.0
    var averageA:Double = 0.0
    var averageH:Double = 0.0
    
    
    
    
    var restoImages : [String] = []
    var restoMenu: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getRatings()
        
        let myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        
        fRating.settings.updateOnTouch = false
        sRating.settings.updateOnTouch = false
        aRating.settings.updateOnTouch = false
        hRating.settings.updateOnTouch = false
        
        
        
        
        mapView.delegate = self
        locationManager.delegate = self
       mapView.userTrackingMode = MKUserTrackingMode.follow
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        pageControl.hidesForSinglePage = true
        
        
        restoImages.append(resto.image!.photo1)
        restoImages.append(resto.image!.photo2)
        restoImages.append(resto.image!.photo3)
        
        self.viewRating.layer.cornerRadius = 20
        self.viewRating.clipsToBounds = true
        
        name.text = resto.name
        address.text = resto.address
        minPrice.text = resto.minPrice
        maxPrice.text = resto.maxPrice
        desc.text = resto.description
        category.text = resto.category
        phone.text = resto.phone
        
        let marker = Marker(title: resto.name!,
                            locationName: resto.address!,
                            discipline: "Sculpture",
                            coordinate: CLLocationCoordinate2D(latitude: Double(resto!.latitude!) as! CLLocationDegrees, longitude: Double(resto!.longitude!) as! CLLocationDegrees))
        mapView.addAnnotation(marker)
        
        
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        // mapView.setVisibleMapRect(zoomRect, animated: true)
        
        
    }
    

    @IBAction func likeAction(_ sender: UIButton) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appdelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        //managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurants") // cast it as NSManagedObject if we want to access the object values
        
        fetchRequest.predicate = NSPredicate(format: "name == %@",resto.name!)
        
        do{
            let Result = try managedContext.fetch(fetchRequest)
            if Result.count == 0 {
                let entityRestaurant = NSEntityDescription.entity(forEntityName: "Restaurants", in: managedContext)
                let restaurant = NSManagedObject(entity: entityRestaurant!, insertInto: managedContext)
                
                print("count is 0")
                restaurant.setValue(resto.photo, forKey: "image")
                restaurant.setValue(resto.name, forKey: "name")
                restaurant.setValue(resto.address, forKey: "address")
                
                do{
                    try managedContext.save()
                    
                }
            }else {
                
                let alertController = UIAlertController(title: "Alert", message: "Already bookmarked", preferredStyle: .alert)
                
                let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    print("You've pressed OK");
                }
                
                let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
                    print("You've pressed cancel");
                }
                alertController.addAction(action1)
                alertController.addAction(action2)
                self.present(alertController, animated: true, completion: nil)
                print("already exists")
            }
        }catch{
            let nserror = error as NSError
            print(nserror.userInfo)
        }
        
        
        
    }
    
    var restos : [Restaurant] = []
    var size : CGSize!
    
    func getRatings() {
        ApiClient.getRattings(onSuccess: { (rating) in
            rating.forEach({ (r) in
                if (r.restaurant?.id == self.resto.id) {
                    self.ratingList.append(r)
                }
            })
            
            self.getRatingResto()
            self.sRating.rating = self.averageS
            self.aRating.rating = self.averageA
            self.hRating.rating = self.averageH
            self.sRating.rating = self.averageS
            self.averageLabel.text = String(String(self.average))
            self.tableView.reloadData()

        }) { (Error) in
            
        }
    }
    func getRatingResto() {
        var somme:Double = 0
        var sommeS:Double = 0
        var sommeA:Double = 0
        var sommeH:Double = 0
        var sommeR:Double = 0
        var i:Double = 0
        ratingList.forEach { (rating) in
            let s:Double? = (rating.s_rating as NSString).doubleValue
            let a:Double? = (rating.a_rating as NSString).doubleValue
            let h:Double? = (rating.h_rating as NSString).doubleValue
            let r:Double? = (rating.rating as NSString).doubleValue
            sommeS += s!
            sommeA += a!
            sommeH += h!
            sommeR += r!
            let sommeCat = (s! + a! + h! + r!) / 4
            somme += sommeCat
        
            i += 1
        }
        self.averageA = sommeA / i
        self.averageS = sommeS / i
        self.averageH = sommeH / i
        self.averageF = sommeR / i
        self.average = round(10 * (somme / i))/10
    }
    

    

    
    func centerMap(for coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10, longitudinalMeters: 10)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
//        detailView?.mapView?.addAnnotation(annotation)
//        detailsFoodView?.mapView?.setRegion(region, animated: true)
    }
    
    
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        var returnValue = 0
        
        if collectionView == collectionView {
            // Return number of hashtags
            returnValue = restoImages.count
        }
        
        if collectionView == menuCollectionView {
            // I only want 3 cells in the create collection view
            returnValue = (self.resto.menu?.count)!
        }
        return returnValue
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {

            if let cell: DetailCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as? DetailCollectionViewCell
            {
                cell.resto = resto
                cell.restoImages = restoImages[indexPath.row]
                return cell
            }
        } else if collectionView == self.menuCollectionView
        {
            if let cell: MenuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell
            {
                
             //  restoMenu = resto.menu
                cell.restoMenu = resto.menu![indexPath.row]
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offSet = scrollView.contentOffset.x
//        let width = scrollView.frame.width
//        let horizontalCenter = width / 2
//
//        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
//    }

    
    
    
    @IBAction func backBtn(_ sender: Any) {
          self.dismiss(animated: true, completion:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is RatingViewController
        {
            let vc = segue.destination as? RatingViewController
            vc?.restaurant_id = resto.id!
        }
    }
    
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingList.count
        
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as? RatingsTableViewCell
            {
                cell.ratings = ratingList[indexPath.row]
          //      tableView.reloadData()
                return cell
                
                
            }
            return UITableViewCell()
        }
}




extension DetailViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Marker else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation , reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Marker
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
}
