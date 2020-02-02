//
//  RewardsInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class RewardsInteractor: RewardsInteractorInputProtocol {
    var presenter: RewardsInteractorOutputProtocol?
    var localDatamanager: RewardsLocalDataManagerInputProtocol?
    var remoteDatamanager: RewardsRemoteDataManagerInputProtocol?
    
    func fetchRewards() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchRewards(With: savedUser)
        }else {
            presenter?.didFailToFetchRewards("user profile not found")
        }
    }
}

extension RewardsInteractor: RewardsLocalDataManagerOutputProtocol {
    
}

extension RewardsInteractor: RewardsRemoteDataManagerOutputProtocol {
    func onFetchRewards(_ response: RewardResponse?) {
        presenter?.didFetchRewards(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchRewards(message)
    }
}
