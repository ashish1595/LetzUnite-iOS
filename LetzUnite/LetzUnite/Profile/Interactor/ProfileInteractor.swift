//
//  ProfileInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {
    var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    
    func fetchProfileToDisplay() {
        localDatamanager?.retrieveUserProfileToDisplay()
    }
    
    func updateProfile(With userProfileInfo: UserProfileModel) {
        if let savedUser = localDatamanager?.retrieveUserProfile() {
            remoteDatamanager?.updateProfile(With: userProfileInfo, savedUser: savedUser)
        }else {
            presenter?.didFailToFetchProfile(with: "unable to retrieve saved profile")
        }
    }

}

extension ProfileInteractor: ProfileLocalDataManagerOutputProtocol {
    func onLocalProfileRetrieval(_ localProfile: UserProfileModel) {
        presenter?.didFetchProfile(With: localProfile)
    }
    
    func onLocalProfileRetrievalError(_ message: String) {
        presenter?.didFailToFetchProfile(with: message)
    }
}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    
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
    
    func onError() {
        
    }
}
