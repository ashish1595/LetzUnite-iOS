//
//  RegistrationPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class RegistrationPresenter: RegistrationPresenterProtocol {
    
    var view: RegistrationViewProtocol?
    var interactor: RegistrationInterectorInputProtocol?
    var wireFrame: RegistrationWireFrameProtocol?
    
    func viewDidLoad() {
        view?.styleRegistrationView()
    }
    
    func viewDidAppear(){
        view?.animateRegistrationView()
    }
    
    func registerUser(With userProfileInfo: UserProfileModel) {
        interactor?.registerUser(With: userProfileInfo)
    }
    
    func backToPreviousScreen() {
        wireFrame?.popToLoginScreen(from: view!)
    }
    
    func actionStartAnimatingRegistrationButton() {
        view?.startAnimatingRegistrationButton()
    }
    
    func actionStopAnimatingRegistrationButton() {
        view?.stopAnimatingRegistrationButton()
    }
}


extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    
    func didRegisterUser(With response: UserRegistrationResponse) {
        view?.stopAnimatingRegistrationButton()
        wireFrame?.popToLoginScreenAndShowSignInView(from: view!, with: response.email)
    }
    
    func didNotRegisterUser(With response: UserRegistrationResponse) {
        view?.stopAnimatingRegistrationButton()
        view?.showError(response.message)
    }
    
    func didFailWithError(_ message: String?) {
        view?.stopAnimatingRegistrationButton()
        view?.showError(message)
    }
}
