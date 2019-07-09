//
//  LocationViewController.swift
//  MealsBooking
//
//  Created by Anis on 4/25/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import MapKit

protocol LocationActions: class {
    func didTapAllow()
}

class LocationViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    


    @IBOutlet weak var locationView: LocationView!
    var locationService: LocationService?
    //weak var delegate: LocationActions?
    
    var mapHasCenteredOnce = false
    
    var allRestaurants: [Restaurant] = []
    
    var locationManager = CLLocationManager()
    weak var delegate: LocationActions?
    
    //second
    fileprivate var annotation: MKAnnotation!
    fileprivate var isCurrentLocation: Bool = false
    
    //search
    private var searchController: UISearchController!
    private var localSearchRequest: MKLocalSearch.Request!
    private var localSearch: MKLocalSearch!
    private var localSearchResponse: MKLocalSearch.Response!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationView.didTapAllow = {
//            self.delegate?.didTapAllow()
//        }
//
        
        
        mapView.delegate = self
        locationManager.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
      
        
        
        //second
        let currentLocationButton = UIBarButtonItem(title: "Current Location", style: UIBarButtonItem.Style.plain, target: self, action: "currentLocationButtonAction:")
        self.navigationItem.leftBarButtonItem = currentLocationButton
        
        
        //search
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: "searchButtonAction:")
        self.navigationItem.rightBarButtonItem = searchButton
        
        setRestaurantsAnnotations()
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location!.coordinate
        pointAnnotation.title = "MealsBookingClient"
        mapView.addAnnotation(pointAnnotation)
    }
    
    
    func currentLocationButtonAction(sender: UIBarButtonItem) {
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
 
    
    @objc func searchButtonAction(_ button: UIBarButtonItem) {
        if searchController == nil {
            searchController = UISearchController(searchResultsController: nil)
        }
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { [weak self] (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil {
                let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                alert.show()
                return
            }
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.title = searchBar.text
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
            self!.mapView.centerCoordinate = pointAnnotation.coordinate
            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
        }
    }
    
    
    
    
    func setRestaurantsAnnotations(){
        ApiClient.getAllResto(onSuccess: { (resto) in
            self.allRestaurants = resto
            for location in self.allRestaurants {
                
                let marker = Marker(title: location.name!,
                                    locationName: location.address!,
                                    discipline: "Sculpture",
                                    coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude!) as! CLLocationDegrees, longitude: Double(location.longitude!) as! CLLocationDegrees))
                self.mapView.addAnnotation(marker)
                 self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                
//
//                let annotations = MKPointAnnotation()
//                annotations.title = location.name as String?
//
//                annotations.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude!) as! CLLocationDegrees, longitude: Double(location.longitude!) as! CLLocationDegrees)
//                self.mapView.addAnnotation(annotations)
                
            }
           
        }) { (error) in
            
        }
        
    }
    
 
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        locationAuthStatus()
    //    }
    //
    //    func locationAuthStatus() {
    //        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
    //            mapView.showsUserLocation = true
    //        } else {
    //            locationManager.requestWhenInUseAuthorization()
    //        }
    //    }
    //
    //
    //    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    //        if status == .authorizedWhenInUse {
    //            mapView.showsUserLocation = true
    //        }
    //    }
    //
    //    func centerMapOnLocation(location: CLLocation) {
    //        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
    //
    //        mapView.setRegion(coordinateRegion, animated: true)
    //    }
    //
    //    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    //
    //        if let loc = userLocation.location {
    //            if !mapHasCenteredOnce {
    //                centerMapOnLocation(location: loc)
    //                mapHasCenteredOnce = true
    //            }
    //        }
    //    }
    //
    //
    //
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //
    //
    //        var annotationView: MKAnnotationView?
    //
    //        if annotation.isKind(of: MKUserLocation.self) {
    //            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
    //            annotationView?.image = UIImage(named: "bg")
    //        }
    //
    //        return annotationView
    //
    //    }
    //
    
    
    
    
    

}

extension LocationViewController: MKMapViewDelegate {
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
