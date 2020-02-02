//
//  EditProfilePresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class EditProfilePresenter: EditProfilePresenterProtocol {
    var view: EditProfileViewProtocol?
    var interactor: EditProfileInteractorInputProtocol?
    var wireFrame: EditProfileWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleEditView()
        view?.animateEditView()
    }
    
    func updateProfile(with profileData: UserProfileModel) {
        interactor?.updateProfile(With: profileData)
    }
    
    func popToProfileScreen() {
        wireFrame?.popToProfileScreen(from: view!)
    }
}


extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    
    func didFailToFetchProfile(with message: String) {
        self.view?.hideLoading()
        view?.showError(message)
    }
    
    func didUpdateProfile(With response: UserUpdateProfileResponse) {
        self.view?.hideLoading()
        self.view?.showMessage(response.data)
        wireFrame?.popToProfileScreen(from: view!)
    }
    
    func didFailToUpdateProfile(_ message: String?) {
        self.view?.hideLoading()
        view?.showError(message)
    }    
}
