//
//  SearchInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var locationManager = AppLocationManager.sharedInstance
    
    func searchRecords(With parameters: SearchRequestModel) {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.searchRecordsRequest(With: parameters, profileInfo: savedUser)
        }else {
            presenter?.didFailToSearchRecords("unable to fetch saved profile")
        }
    }
    
    func getCurrentLocation() {
        locationManager.determineMyCurrentLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.checkLocationAvailable()
        })
    }
    
    @objc func checkLocationAvailable() {
        if locationManager.currentLocation != nil {
            presenter?.didUpdateLocation(coordinates: (locationManager.currentLocation?.coordinate.latitude)!, longitude: (locationManager.currentLocation?.coordinate.longitude)!)
        }else {
            presenter?.didFailToGetLocation(locationManager.locationStatus)
        }
    }
}

extension SearchInteractor: SearchLocalDataManagerOutputProtocol {
    
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    func onSearchRecords(_ response: SearchResponse) {
        presenter?.didSearchRecords(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToSearchRecords(message)
    }    
}
