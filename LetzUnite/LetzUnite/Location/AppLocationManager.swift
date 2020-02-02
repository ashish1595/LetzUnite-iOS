//
//  AppLocationManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/22/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import CoreLocation

class AppLocationManager: NSObject {
    var locationManager:CLLocationManager!
    var locationStatus : String = "No Location Available"
    var seenError : Bool = false
    var currentLocation: CLLocation?
    
    static let sharedInstance = AppLocationManager()
    private override init() {}
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }else {
            Utility.showMessage(message: "Location services are disable, Go to settings>privacy>location to enable it")
        }
    }
}

extension AppLocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let userLocation:CLLocation = locations[0] as CLLocation
        if CLLocationCoordinate2DIsValid(userLocation.coordinate) {
                self.currentLocation = userLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to access location"
            shouldIAllow = true
        }
        if (shouldIAllow == true) {
            locationManager.startUpdatingLocation()
        } else {
            Utility.showMessage(message: "GPS: \(locationStatus)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            if (seenError == false) {
                seenError = true
                print(error)
            }
    }
    
}
