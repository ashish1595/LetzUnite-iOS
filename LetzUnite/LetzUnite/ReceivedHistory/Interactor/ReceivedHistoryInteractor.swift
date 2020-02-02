//
//  ReceivedHistoryInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class ReceivedHistoryInteractor: ReceivedHistoryInteractorInputProtocol {
    var presenter: ReceivedHistoryInteractorOutputProtocol?
    var localDatamanager: ReceivedHistoryLocalDataManagerInputProtocol?
    var remoteDatamanager: ReceivedHistoryRemoteDataManagerInputProtocol?
    
    func fetchReceivedHistory() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchReceivedHistory(With: savedUser)
        }else {
            presenter?.didFailToFetchReceivedHistory("user profile not found")
        }
    }
}

extension ReceivedHistoryInteractor: ReceivedHistoryLocalDataManagerOutputProtocol {
    
}

extension ReceivedHistoryInteractor: ReceivedHistoryRemoteDataManagerOutputProtocol {
    func onFetchReceivedHistory(_ response: RewardResponse?) {
        presenter?.didFetchReceivedHistory(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchReceivedHistory(message)
    }
}
