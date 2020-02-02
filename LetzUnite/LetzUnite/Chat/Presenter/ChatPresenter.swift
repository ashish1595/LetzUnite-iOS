//
//  ChatPresenter.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class ChatPresenter: ChatPresenterProtocol {
    var view: ChatViewProtocol?
    var interactor: ChatInteractorInputProtocol?
    var wireFrame: ChatWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleChatView()
        view?.animateChatView()
    }
    
    func updateProfile(with profileData: UserProfileModel) {
        interactor?.updateProfile(With: profileData)
    }
    
    func popToPreviousScreen() {
        wireFrame?.popToPreviousScreen(from: view!)
    }
}


extension ChatPresenter: ChatInteractorOutputProtocol {
    
    func didFailToFetchProfile(with message: String) {
        self.view?.hideLoading()
        view?.showError(message)
    }
    
    func didUpdateProfile(With response: UserUpdateProfileResponse) {
        self.view?.hideLoading()
        self.view?.showMessage(response.data)
        wireFrame?.popToPreviousScreen(from: view!)
    }
    
    func didFailToUpdateProfile(_ message: String?) {
        self.view?.hideLoading()
        view?.showError(message)
    }    
}
