//
//  AppBaseInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/3/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class AppBaseInteractor: AppBaseInteractorInputProtocol {
    var presenter: AppBaseInteractorOutputProtocol?
    var localDatamanager: AppBaseLocalDataManagerInputProtocol?
    var remoteDatamanager: AppBaseRemoteDataManagerInputProtocol?
    
    func retrieveTabBarDetails() {
        
    }
}

extension AppBaseInteractor: AppBaseLocalDataManagerOutputProtocol {
    func onLocalUserRetrieved(_ userProfile: UserProfileSingleton) {
        presenter?.didRetrieveUserProfile(userProfile)
    }
    
    func onLocalDataManagerError() {
        
    }
}

extension AppBaseInteractor: AppBaseRemoteDataManagerOutputProtocol {
    
}
