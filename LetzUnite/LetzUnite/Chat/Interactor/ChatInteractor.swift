//
//  ChatInteractor.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class ChatInteractor: ChatInteractorInputProtocol {
    var presenter: ChatInteractorOutputProtocol?
    var localDatamanager: ChatLocalDataManagerInputProtocol?
    var remoteDatamanager: ChatRemoteDataManagerInputProtocol?
    
    func updateProfile(With userProfileInfo: UserProfileModel) {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.updateProfile(With: userProfileInfo, savedUser: savedUser)
        }else {
            presenter?.didFailToFetchProfile(with: "unable to retrieve saved profile")
        }
    }
}

extension ChatInteractor: ChatLocalDataManagerOutputProtocol {
    
}

extension ChatInteractor: ChatRemoteDataManagerOutputProtocol {
    
    func onUpdateProfile(_ response: UserUpdateProfileResponse, updatedProfile: UserProfileModel?) {
        let success = localDatamanager?.saveUpdatedUserProfile(updatedProfile)
        if success == true {
            presenter?.didUpdateProfile(With: response)
        }else {
            presenter?.didFailToUpdateProfile("unable to save profile")
        }
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToUpdateProfile(message)
        
    }
}
