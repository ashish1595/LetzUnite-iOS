//
//  SearchPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var wireFrame: SearchWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func searchRecords(With parameters: SearchRequestModel) {
        interactor?.searchRecords(With: parameters)
    }
    
    func getCurrentLocation() {
        interactor?.getCurrentLocation()
    }
    
    func showVisitProfileScreen() {
        wireFrame?.presentVisitProfileScreen(from: view!)
    }
}


extension SearchPresenter: SearchInteractorOutputProtocol {
    func didUpdateLocation(coordinates latitude: Double, longitude: Double) {
        view?.hideLoading()
        view?.updateLocation(latitude, longitude: longitude)
    }
    
    func didFailToGetLocation(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
    
    func didSearchRecords(With response: SearchResponse) {
        view?.hideLoading()
        view?.updateView(With: response)
    }
    
    func didFailToSearchRecords(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
