//
//  RegistrationInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation


class RegistrationInteractor: RegistrationInterectorInputProtocol {
    var presenter: RegistrationInteractorOutputProtocol?
    var remoteDatamanager: RegistrationRemoteDataManagerInputProtocol?
    
    func registerUser(With userProfileInfo: UserProfileModel) {
        remoteDatamanager?.registerUser(With: userProfileInfo)
    }
}

extension RegistrationInteractor: RegistrationRemoteDataManagerOutputProtocol {
    
    func onUserRegistration(_ response: UserRegistrationResponse) {
            presenter?.didRegisterUser(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailWithError(message)
    }
    
    func onError(_ message: String?, endpoint: Endpoint) {
        presenter?.didFailWithError(message)
    }
    
    func onError(_ message: String?) {
        presenter?.didFailWithError(message)
    }
    
    func onError() {

    }
}
