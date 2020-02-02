//
//  PlacesSearchConstants.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

public enum PlaceType: String {
    case all = ""
    case address
    case regions = "(regions)"
    case cities = "(cities)"
    case geocode
    case establishment
}

public enum googleAPIs: String {
    case placeDetails = "https://maps.googleapis.com/maps/api/place/details/json"
    case placeAutocomplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
}


