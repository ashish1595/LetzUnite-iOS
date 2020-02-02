//
//  VisitProfileInteractor.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class VisitProfileInteractor: VisitProfileInteractorInputProtocol {
    var presenter: VisitProfileInteractorOutputProtocol?
    var localDatamanager: VisitProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: VisitProfileRemoteDataManagerInputProtocol?
    
    func fetchVisitProfileToDisplay() {
        localDatamanager?.retrieveUserVisitProfileToDisplay()
    }
    
    func updateVisitProfile(With userVisitProfileInfo: UserProfileModel) {
        if let savedUser = localDatamanager?.retrieveUserVisitProfile() {
            remoteDatamanager?.updateVisitProfile(With: userVisitProfileInfo, savedUser: savedUser)
        }else {
            presenter?.didFailToFetchVisitProfile(with: "unable to retrieve saved VisitProfile")
        }
    }

}

extension VisitProfileInteractor: VisitProfileLocalDataManagerOutputProtocol {
    func onLocalVisitProfileRetrieval(_ localVisitProfile: UserProfileModel) {
        presenter?.didFetchVisitProfile(With: localVisitProfile)
    }
    
    func onLocalVisitProfileRetrievalError(_ message: String) {
        presenter?.didFailToFetchVisitProfile(with: message)
    }
}

extension VisitProfileInteractor: VisitProfileRemoteDataManagerOutputProtocol {
    
    func onUpdateVisitProfile(_ response: UserUpdateProfileResponse, updatedVisitProfile: UserProfileModel?) {
        let success = localDatamanager?.saveUpdatedUserVisitProfile(updatedVisitProfile)
        if success == true {
            presenter?.didUpdateVisitProfile(With: response)
        }else {
            presenter?.didFailToUpdateVisitProfile("unable to save VisitProfile")
        }
    }
    
    func onError(with message: String?, errorCode: Int?, endpoint: Endpoint) {
        presenter?.didFailToUpdateVisitProfile(message)
    }
    
    func onError() {
        
    }
}
