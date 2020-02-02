//
//  ProfileLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class ProfileLocalDataManager: ProfileLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: ProfileLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() -> UserProfileSingleton? {
        if userProfileManager != nil {
            return userProfileManager!
        }else {
            return nil
        }
    }
    
    func retrieveUserProfileToDisplay() {
        if userProfileManager != nil {
            var user = UserProfileModel.init()
            user.firstname = userProfileManager?.name
            user.email = userProfileManager?.emailId
            user.mobile = userProfileManager?.mobileNumber
            localRequestHandler?.onLocalProfileRetrieval(user)
        }else {
            localRequestHandler?.onLocalProfileRetrievalError("error in retriving user profile")
        }
    }
    
    func saveUpdatedUserProfile(_ profile: UserProfileModel?) -> Bool {
        if let userProfile = profile {
            userProfileManager?.name = userProfile.username
            userProfileManager?.emailId = userProfile.email
            userProfileManager?.mobileNumber = userProfile.mobile
            //add other params too
            return true
        }else {
            return false
        }
    }
    
}
