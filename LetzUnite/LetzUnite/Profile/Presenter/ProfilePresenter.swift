//
//  ProfilePresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    func viewDidLoad() {
        self.fetchProfile()
    }
    
    func fetchProfile() {
        interactor?.fetchProfileToDisplay()
    }
    
    func updateProfile(with profileData: UserProfileModel) {
        interactor?.updateProfile(With: profileData)
    }
    
    func showEditProfileScreen() {
        wireFrame?.presentEditProfileScreen(from: view!)
    }
    
}


extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func didFetchProfile(With response: UserProfileModel) {
        self.view?.hideLoading()
        view?.updateView(With: response)
    }
    
    func didFailToFetchProfile(with message: String) {
        self.view?.hideLoading()
        view?.showError(message)
    }
    
    func didUpdateProfile(With response: UserUpdateProfileResponse) {
        self.view?.hideLoading()
        self.view?.showLoading()
        self.fetchProfile()
    }
    
    func didFailToUpdateProfile(_ message: String?) {
        self.view?.hideLoading()
        view?.showError(message)
    }
}
