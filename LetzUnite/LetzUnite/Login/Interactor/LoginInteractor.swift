//
//  LoginInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInterectorInputProtocol {
    
    var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func retrieveUser(With username: String, password: String) {
        remoteDatamanager?.retrieveUser(With: username, password: password)
    }
    
    func resetPassword(With emailId: String) {
        remoteDatamanager?.resetPassword(With: emailId)
    }
    
    func confirmResetPassword(email: String, otp: String, newPassword: String, confirmPassword: String) {
        remoteDatamanager?.confirmResetPassword(email: email, otp: otp, newPassword: newPassword, confirmPassword: confirmPassword)
    }

}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    
    func onUserRetrieved(_ userProfile: UserLoginResponse) {
        localDatamanager?.saveUserProfile(userProfile)
        UserDefaults.saveObject(object:true, forKey: UserDefaultsSerializationKey.isLogined.rawValue)
        presenter?.didRetrieveLoginUser(userProfile)
    }
    
    func onResetPassword(response: ForgotPasswordResponse) {
        presenter?.didResetUserPassword(response: response)
    }
    
    func onConfirmResetPassword(response: VerifyPasswordResponse) {
        presenter?.didConfirmResetUserPassword(response: response)
    }
    
    func onError() {
        presenter?.didFailWithError()
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        switch endpoint {
        case .login:
            presenter?.didFailToLogin(message)
            print("login")
        case .forgotPassword:
            presenter?.didFailToResetPassword(message)
            print("forgotPassword")
        case .confirmResetPassword:
            presenter?.didFailToConfirmResetPassword(message)
            print("confirmResetPassword")
        default:
            print("default")
        }
    }
}

extension LoginInteractor: LoginLocalDataManagerOutputProtocol {
    func onLocalUserRetrieved(_ userProfile: UserProfileSingleton) {

    }
    func onLocalDataManagerError() {
        
    }
}

