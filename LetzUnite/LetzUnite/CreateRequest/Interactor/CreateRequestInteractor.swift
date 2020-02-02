//
//  CreateRequestInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class CreateRequestInteractor: CreateRequestInteractorInputProtocol {
    var presenter: CreateRequestInteractorOutputProtocol?
    var localDatamanager: CreateRequestLocalDataManagerInputProtocol?
    var remoteDatamanager: CreateRequestRemoteDataManagerInputProtocol?
    
    func createBloodRequest(With parameters: BloodRequestModel) {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.createBloodRequest(With: parameters, profileInfo: savedUser)
        }else {
            presenter?.didFailToCreateBloodRequest("unable to fetch saved profile")
        }
    }
}

extension CreateRequestInteractor: CreateRequestLocalDataManagerOutputProtocol {
    
}

extension CreateRequestInteractor: CreateRequestRemoteDataManagerOutputProtocol {
    func onCreateBloodRequest(_ response: BloodRequestResponse) {
        presenter?.didCreateBloodRequest(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToCreateBloodRequest(message)
    }
}
