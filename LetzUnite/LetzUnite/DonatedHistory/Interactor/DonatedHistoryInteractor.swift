//
//  DonatedHistoryInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class DonatedHistoryInteractor: DonatedHistoryInteractorInputProtocol {
    var presenter: DonatedHistoryInteractorOutputProtocol?
    var localDatamanager: DonatedHistoryLocalDataManagerInputProtocol?
    var remoteDatamanager: DonatedHistoryRemoteDataManagerInputProtocol?
    
    func fetchDonatedHistory() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchDonatedHistory(With: savedUser)
        }else {
            presenter?.didFailToFetchDonatedHistory("user profile not found")
        }
    }
}

extension DonatedHistoryInteractor: DonatedHistoryLocalDataManagerOutputProtocol {
    
}

extension DonatedHistoryInteractor: DonatedHistoryRemoteDataManagerOutputProtocol {
    func onFetchDonatedHistory(_ response: RewardResponse?) {
        presenter?.didFetchDonatedHistory(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchDonatedHistory(message)
    }
}
