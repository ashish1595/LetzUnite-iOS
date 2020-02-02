//
//  BloodRequestDetailPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
class BloodRequestDetailPresenter: BloodRequestDetailPresenterProtocol {
    var view: BloodRequestDetailViewProtocol?
    var interactor: BloodRequestDetailInteractorInputProtocol?
    var wireFrame: BloodRequestDetailWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleBloodRequestDetailView()
        view?.animateBloodRequestDetailView()
        
        self.fetchBloodRequestDetail()
    }
    
    func fetchBloodRequestDetail() {
        interactor?.fetchBloodRequestDetail()
    }
    
    func popView(_ view: BloodRequestDetailViewProtocol) {
        wireFrame?.popView(view)
    }
}


extension BloodRequestDetailPresenter: BloodRequestDetailInteractorOutputProtocol {
    func didFetchBloodRequestDetail(With response: RewardResponse?) {
        view?.updateView(With: response)
        view?.hideLoading()
    }
    
    func didFailToFetchBloodRequestDetail(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
