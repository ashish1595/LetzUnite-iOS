//
//  FeedsInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class FeedsInteractor: FeedsInteractorInputProtocol {
    
    var presenter: FeedsInteractorOutputProtocol?
    var localDatamanager: FeedsLocalDataManagerInputProtocol?
    var remoteDatamanager: FeedsRemoteDataManagerInputProtocol?
    
    func fetchFeeds() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchFeeds(With: savedUser)
        }else {
            presenter?.didFailToFetchFeeds("user profile not found")
        }
    }
}

extension FeedsInteractor: FeedsLocalDataManagerOutputProtocol {
    
}

extension FeedsInteractor: FeedsRemoteDataManagerOutputProtocol {
    func onFetchFeeds(_ response: FeedsResponse) {
        presenter?.didFetchFeeds(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchFeeds(message)
    }
    
    func onError() {
        
    }
}
