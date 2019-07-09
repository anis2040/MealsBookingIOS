//
//  Restaurant.swift
//  MealsBooking
//
//  Created by Chakib Fathallah on 4/26/19.
//  Copyright © 2019 Sim1718. All rights reserved.
//

import Foundation
import Contacts
import MapKit

class RestaurantList:Codable{
    var restaurants : [Restaurant]
    enum CodingKeys: String, CodingKey {
        case restaurants = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurants = try values.decodeIfPresent([Restaurant].self, forKey: .restaurants) ?? [Restaurant]()
    }
    
}
class Restaurant: Codable  {
    var id: Int?
    var name: String?
    var photo : String?
    var address : String?
    var phone : String?
    var minPrice : String?
    var maxPrice : String?
    var longitude :String?
    var latitude : String?
    var description : String?
    var category : String?
    var image : Image?
    var menu: [Menu]?
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo = "photo"
        case address = "address"
        case minPrice = "priceMin"
        case maxPrice = "priceMax"
        case longitude = "longitude"
        case latitude = "latitude"
        case image = "image"
        case phone = "phone"
        case description = "description"
        case category = "category"
        case menu = "menu"
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? "Unknown"
        photo = try values.decodeIfPresent(String.self, forKey: .photo) ?? "Unknown"
        address = try values.decodeIfPresent(String.self, forKey: .address) ?? "Unknown"
        image = try values.decodeIfPresent(Image.self, forKey: .image)
        phone = try values.decodeIfPresent(String.self, forKey: .phone) ?? "Unknown"
        minPrice = try values.decodeIfPresent(String.self, forKey: .minPrice) ?? "Unknown"
        maxPrice = try values.decodeIfPresent(String.self, forKey: .maxPrice) ?? "Unknown"
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude) ?? "Unknown"
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude) ?? "Unknown"
        category = try values.decodeIfPresent(String.self, forKey: .category) ?? "Unknown"
        menu = try values.decodeIfPresent([Menu].self, forKey: .menu) ??  [Menu]()
    }
    
    
    init(id: Int,name: String, description : String, photo: String, address : String, phone : String, image : Image, priceMin : String, priceMax : String,longitude : String, latitude : String, category : String, menu : [Menu]){
        self.id = id
        self.name = name
        self.photo = photo
        self.address = address
        self.image = image
        self.phone = phone
        self.minPrice = priceMin
        self.longitude = longitude
        self.latitude = latitude
        self.maxPrice = priceMax
        self.description = description
        self.category = category
        self.menu = menu
  
    }
    
    init(name: String, photo: String, address : String){
        self.name = name
        self.photo = photo
        self.address = address
        
    }
    
    
    
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: address]
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(latitude!) as! CLLocationDegrees, longitude: Double(longitude!) as! CLLocationDegrees), addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        
        return mapItem
    }
    
}
