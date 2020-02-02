//
//  BloodRequestInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
class BloodRequestInteractor: BloodRequestInteractorInputProtocol {
    var presenter: BloodRequestInteractorOutputProtocol?
    var localDatamanager: BloodRequestLocalDataManagerInputProtocol?
    var remoteDatamanager: BloodRequestRemoteDataManagerInputProtocol?
    
    func fetchBloodRequest() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchBloodRequest(With: savedUser)
        }else {
            presenter?.didFailToFetchBloodRequest("user profile not found")
        }
    }
}

extension BloodRequestInteractor: BloodRequestLocalDataManagerOutputProtocol {
    
}

extension BloodRequestInteractor: BloodRequestRemoteDataManagerOutputProtocol {
    func onFetchBloodRequest(_ response: RewardResponse?) {
        presenter?.didFetchBloodRequest(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchBloodRequest(message)
    }
}
