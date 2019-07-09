//
//  DetailView.swift
//  MealsBooking
//
//  Created by Anis on 5/8/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import UIKit
import Cosmos
import MapKit

@IBDesignable class DetailView: BaseView {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceMinLabel: UILabel!
    @IBOutlet weak var priceMaxLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    @IBOutlet weak var foodRating: CosmosView!
    
    @IBOutlet weak var serviceRating: CosmosView!
    
    @IBOutlet weak var AmbienceRating: CosmosView!
    
    @IBOutlet weak var HygieneRating: CosmosView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func handleControl(_ sender: UIPageControl) {
        
    }
    
}
