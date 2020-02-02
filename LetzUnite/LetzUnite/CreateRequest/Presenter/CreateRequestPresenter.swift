//
//  CreateRequestPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class CreateRequestPresenter: CreateRequestPresenterProtocol {
    var view: CreateRequestViewProtocol?
    var interactor: CreateRequestInteractorInputProtocol?
    var wireFrame: CreateRequestWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleCreateBloodRequestView()
        view?.animateCreateBloodRequestView()
    }
    
    func dismiss(_ view: CreateRequestViewProtocol) {
        wireFrame?.dismiss(view)
    }
    
    func createBloodRequest(With parameters: BloodRequestModel) {
        interactor?.createBloodRequest(With: parameters)
    }
}


extension CreateRequestPresenter: CreateRequestInteractorOutputProtocol {
    func didCreateBloodRequest(With response: BloodRequestResponse?) {
        view?.hideLoading()
        view?.updateView(With: response)
        //or show message
        view?.showMessage(response?.message)
    }
    
    func didFailToCreateBloodRequest(_ message: String?) {
        view?.hideLoading()
        view?.showError(message)
    }
}
