//
//  BloodRequestPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
class BloodRequestPresenter: BloodRequestPresenterProtocol {
    var view: BloodRequestViewProtocol?
    var interactor: BloodRequestInteractorInputProtocol?
    var wireFrame: BloodRequestWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleBloodRequestView()
        view?.animateBloodRequestView()
        
        self.fetchBloodRequest()
    }
    
    func fetchBloodRequest() {
        interactor?.fetchBloodRequest()
    }
    
    func popView(_ view: BloodRequestViewProtocol) {
        wireFrame?.popView(view)
    }
    
    func showBloodRequestDetailScreen() {
        wireFrame?.pushBloodRequestDetailScreen(from: view!)
    }
}


extension BloodRequestPresenter: BloodRequestInteractorOutputProtocol {
    func didFetchBloodRequest(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchBloodRequest(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
