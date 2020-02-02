//
//  FeedsDetailInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class FeedsDetailInteractor: FeedsDetailInteractorInputProtocol {
    var presenter: FeedsDetailInteractorOutputProtocol?
    var localDatamanager: FeedsDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: FeedsDetailRemoteDataManagerInputProtocol?
    
    func fetchFeedsDetail() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchFeedsDetail(With: savedUser)
        }else {
            presenter?.didFailToFetchFeedsDetail("user profile not found")
        }
    }
}

extension FeedsDetailInteractor: FeedsDetailLocalDataManagerOutputProtocol {
    
}

extension FeedsDetailInteractor: FeedsDetailRemoteDataManagerOutputProtocol {
    func onFetchFeedsDetail(_ response: RewardResponse?) {
        presenter?.didFetchFeedsDetail(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchFeedsDetail(message)
    }
}
