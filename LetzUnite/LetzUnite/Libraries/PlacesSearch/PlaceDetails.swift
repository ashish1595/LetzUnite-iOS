//
//  PlaceDetails.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import MapKit

private struct AllKeys {
    static let result = "result"
    static let formattedAddress = "formatted_address"
    static let name = "name"
    static let addressDetails = "address_components"
    static let streetNumber = "street_number"
    static let route = "route"
    static let postalCode = "postal_code"
    static let country = "country"
    static let locality = "locality"
    static let sublocality = "sublocality"
    static let administrativeAreaLevel1 = "administrative_area_level_1"
    static let administrativeAreaLevel2 = "administrative_area_level_2"
    static let geometry = "geometry"
    static let location = "location"
    static let lat = "lat"
    static let lng = "lng"
    static let types = "types"
}

enum DetailsType: String {
    case short = "short_name"
    case long = "long_name"
}

open class PlaceDetails: CustomStringConvertible {
    //CustomStringConvertible protocol can provide their own representation to be used when converting an instance to a string
    open var name: String? = nil
    open let formattedAddress: String
    
    open var streetNumber: String? = nil
    open var route: String? = nil

    open var postalCode: String? = nil
    open var countryCode: String? = nil
    open var country: String? = nil
    
    open var locality: String? = nil
    open var subLocality: String? = nil
    
    open var administrativeArea: String? = nil
    open var administrativeAreaCode: String? = nil
    open var subAdministrativeArea: String? = nil
    
    open var coordinate: CLLocationCoordinate2D? = nil
    
    init?(json: [String: Any]) {
        guard let result = json[AllKeys.result] as? [String: Any],
            let formattedAddress = result[AllKeys.formattedAddress] as? String
            else { return nil }
        
        self.name = result[AllKeys.name] as? String
        self.formattedAddress = formattedAddress
        
        if let addressDetails = result[AllKeys.addressDetails] as? [[String: Any]] {
            streetNumber = get(AllKeys.streetNumber, from: addressDetails, ofType: .short)
            route = get(AllKeys.route, from: addressDetails, ofType: .short)
            
            postalCode = get(AllKeys.postalCode, from: addressDetails, ofType: .long)
            countryCode = get(AllKeys.country, from: addressDetails, ofType: .short)
            country = get(AllKeys.country, from: addressDetails, ofType: .long)
            
            locality = get(AllKeys.locality, from: addressDetails, ofType: .long)
            subLocality = get(AllKeys.sublocality, from: addressDetails, ofType: .long)
            
            administrativeArea = get(AllKeys.administrativeAreaLevel1, from: addressDetails, ofType: .long)
            administrativeAreaCode = get(AllKeys.administrativeAreaLevel1, from: addressDetails, ofType: .short)
            subAdministrativeArea = get(AllKeys.administrativeAreaLevel2, from: addressDetails, ofType: .long)
        }
        
        if let geometry = result[AllKeys.geometry] as? [String: Any],
            let location = geometry[AllKeys.location] as? [String: Any],
            let latitude = location[AllKeys.lat] as? CLLocationDegrees,
            let longitude = location[AllKeys.lng] as? CLLocationDegrees {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    open var description: String {
        return "\nAddress: \(formattedAddress)\ncoordinate: (\(coordinate?.latitude ?? 0), \(coordinate?.longitude ?? 0))\n"
    }
    
    func get(_ detail: String, from array: [[String: Any]], ofType: DetailsType) -> String? {
        return (array.first { ($0[AllKeys.types] as? [String])?.contains(detail) == true })?[ofType.rawValue] as? String
    }
}
