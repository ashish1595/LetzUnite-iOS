//
//  PlacesSearchController.swift
//  LetzUnite
//
//  Created by B0081006 on 8/4/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit
import MapKit

class PlacesSearchController: UISearchController, UISearchBarDelegate {

    convenience public init(delegate: PlacesAutocompleteTableViewControllerDelegate, apiKey: String, placeType: PlaceType = .all, coordinate: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid, radius: CLLocationDistance = 0.0) {
        
        if apiKey.isEmpty == true {
            print("API key missing")
        }
        
        let autocompleteViewController = PlacesAutocompleteTableViewController(
            delegate: delegate,
            apiKey: apiKey,
            placeType: placeType,
            coordinate: coordinate,
            radius: radius
        )
        
        self.init(searchResultsController: autocompleteViewController)
        self.searchResultsUpdater = autocompleteViewController
        self.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
