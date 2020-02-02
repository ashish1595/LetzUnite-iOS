//
//  NotificationInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class NotificationInteractor: NotificationInteractorInputProtocol {
    var presenter: NotificationInteractorOutputProtocol?
    var localDatamanager: NotificationLocalDataManagerInputProtocol?
    var remoteDatamanager: NotificationRemoteDataManagerInputProtocol?
    
    func fetchNotification() {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.fetchNotification(With: savedUser)
        }else {
            presenter?.didFailToFetchNotification("user profile not found")
        }
    }
}

extension NotificationInteractor: NotificationLocalDataManagerOutputProtocol {
    
}

extension NotificationInteractor: NotificationRemoteDataManagerOutputProtocol {
    func onFetchNotification(_ response: RewardResponse?) {
        presenter?.didFetchNotification(With: response)
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToFetchNotification(message)
    }
}
