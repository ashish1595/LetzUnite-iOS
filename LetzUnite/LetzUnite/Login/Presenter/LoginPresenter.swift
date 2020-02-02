//
//  LoginPresenter.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    
    weak var view: LoginViewProtocol?
    var interactor: LoginInterectorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    
    func viewDidLoad() {
        view?.prepareForAnimation()
        view?.styleLoginView()
        view?.animateLoginView()
    }
    
    func startLoginRequest(With username: String, password: String) {
        interactor?.retrieveUser(With: username, password: password)
    }
    
    func startResetPasswordRequest(With emailId: String) {
        interactor?.resetPassword(With: emailId)
    }
    
    func startConfirmResetPasswordRequest(email: String, otp: String, newPassword: String, confirmPassword: String) {
        interactor?.confirmResetPassword(email: email, otp: otp, newPassword: newPassword, confirmPassword: confirmPassword)
    }
    
    func actionLoginButton() {
        view?.showSignInView()
    }
    
    func actionSignInButton() {
        view?.animateSignInButton()
    }
    
    func actionStopAnimatingSignInButton() {
        view?.stopAnimatingSignInButton()
    }
    
    func actionForgotPasswordButton() {
        view?.showResetPasswordView()
    }
    
    func actionResetPasswordButton() {
        view?.animateResetPasswordButton()
    }
    
    func actionStopAnimatingResetPasswordButton() {
        view?.stopAnimatingResetPasswordButton()
    }
    
    func actionConfirmResetPasswordButton() {
        view?.animateConfirmResetPasswordButton()
    }
    
    func actionStopAnimatingConfirmResetPasswordButton() {
        view?.stopAnimatingConfirmResetPasswordButton()
    }
    
    func actionBackButton(_ viewType: LoginViewType) {
        
        if viewType == .resetPassword {
            view?.hideResetPasswordView()
            view?.showSignInView()
        }else if (viewType == .confirmResetPassword) {
            view?.hideConfirmResetPasswordView()
            view?.showResetPasswordView()
        }else {
            view?.hideSignInView()
        }
    }
    
    func actionNewUserRegistration() {
        view?.animateRegistrationButton()
    }
    
    func showRegistrationForm() {
        wireFrame?.presentNewUserRegistrationScreen(from: view!)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func didRetrieveLoginUser(_ profile: UserLoginResponse) {
        view?.stopAnimatingSignInButton()
        wireFrame?.presentBaseViewScreen(from: view!)
    }
    
    func didResetUserPassword(response: ForgotPasswordResponse) {
        view?.showMessage(response.data)
        view?.stopAnimatingResetPasswordButton()
        view?.showConfirmResetPasswordView()
    }
    
    func didConfirmResetUserPassword(response: VerifyPasswordResponse) {
        view?.showMessage(response.data)
        view?.stopAnimatingConfirmResetPasswordButton()
        view?.hideConfirmResetPasswordView()
        view?.showSignInView()
    }

    func didFailWithError() {
        
    }
    
    func didFailToLogin(_ message: String?) {
        view?.stopAnimatingSignInButton()
        view?.showError(message)
    }
    
    func didFailToResetPassword(_ message: String?) {
        view?.stopAnimatingResetPasswordButton()
        view?.showError(message)
    }
    
    func didFailToConfirmResetPassword(_ message:String?) {
        view?.stopAnimatingConfirmResetPasswordButton()
        view?.showError(message)
    }
}
