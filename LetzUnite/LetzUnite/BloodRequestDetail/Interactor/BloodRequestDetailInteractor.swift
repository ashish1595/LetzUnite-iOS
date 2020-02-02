//
//  BloodRequestDetailInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class BloodRequestDetailInteractor: BloodRequestDetailInteractorInputProtocol {
    var presenter: BloodRequestDetailInteractorOutputProtocol?
    var localDatamanager: BloodRequestDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: BloodRequestDetailRemoteDataManagerInputProtocol?
    
    func fetchBloodRequestDetail() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchBloodRequestDetail(With: savedUser)
        }else {
            presenter?.didFailToFetchBloodRequestDetail("user profile not found")
        }
    }
}

extension BloodRequestDetailInteractor: BloodRequestDetailLocalDataManagerOutputProtocol {
    
}

extension BloodRequestDetailInteractor: BloodRequestDetailRemoteDataManagerOutputProtocol {
    func onFetchBloodRequestDetail(_ response: RewardResponse?) {
        presenter?.didFetchBloodRequestDetail(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchBloodRequestDetail(message)
    }
}
