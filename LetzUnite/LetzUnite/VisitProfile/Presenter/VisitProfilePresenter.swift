//
//  VisitProfilePresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class VisitProfilePresenter: VisitProfilePresenterProtocol {
    
    var view: VisitProfileViewProtocol?
    var interactor: VisitProfileInteractorInputProtocol?
    var wireFrame: VisitProfileWireFrameProtocol?
    
    func viewDidLoad() {
        //self.fetchVisitProfile()

        view?.prepareForAnimation()
        view?.styleVisitProfileView()
        view?.animateVisitProfileView()
    }
    
    func fetchVisitProfile() {
        interactor?.fetchVisitProfileToDisplay()
    }
    
    func updateVisitProfile(with VisitProfileData: UserProfileModel) {
        interactor?.updateVisitProfile(With: VisitProfileData)
    }
    
    func showEditVisitProfileScreen() {
        wireFrame?.presentChatScreen(from: view!)
    }
    
}


extension VisitProfilePresenter: VisitProfileInteractorOutputProtocol {
    func didFetchVisitProfile(With response: UserProfileModel) {
        self.view?.hideLoading()
        view?.updateView(With: response)
    }
    
    func didFailToFetchVisitProfile(with message: String) {
        self.view?.hideLoading()
        view?.showError(message)
    }
    
    func didUpdateVisitProfile(With response: UserUpdateProfileResponse) {
        self.view?.hideLoading()
        self.view?.showLoading()
        self.fetchVisitProfile()
    }
    
    func didFailToUpdateVisitProfile(_ message: String?) {
        self.view?.hideLoading()
        view?.showError(message)
    }
}
