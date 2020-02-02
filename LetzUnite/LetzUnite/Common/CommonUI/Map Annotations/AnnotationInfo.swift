//
//  AnnotationInfo.swift
//  LetzUnite
//
//  Created by B0081006 on 7/6/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class AnnotationInfo: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let annotationType: String
    let coordinate: CLLocationCoordinate2D
    let imageUrl: String?
    let userId: String?
    
    var subtitle: String? {
        return locationName
    }
    
    init(title: String, locationName: String, type: String, coordinate: CLLocationCoordinate2D, imageUrl:String?, userId:String?) {
        self.title = title
        self.locationName = locationName
        self.annotationType = type
        self.coordinate = coordinate
        self.imageUrl = imageUrl
        self.userId = userId
        super.init()
    }
    
    init?(json: Dictionary<String,Any>) {
        if let title = json["title"] as? String {
            self.title = title
        } else {
            self.title = "No Title"
        }
        self.locationName = json["description"] as! String
        self.annotationType = json["type"] as! String
        if let latitude = Double(json["lat"] as! String),
            let longitude = Double(json["lon"] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        
        if let imgUrl = json["imageUrl"] as? String {
            self.imageUrl = imgUrl
        }else {
            self.imageUrl = ""
        }
        
        if let userId = json["id"] as? String {
            self.userId = userId
        }else {
            self.userId = ""
        }
    }
    
    var markerPinColor: UIColor  {
        switch annotationType {
        case "bloodBank":
            return .red
        case "donor":
            return .cyan
        case "user":
            return .blue
        default:
            return .green
        }
    }
    
    var imageName: String? {
        if annotationType == "bloodBank" {
            return "bloodBankPin"
        }else if (annotationType == "donor") {
            return "bloodBankPin"
        }
        return "bloodBankPin"
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
