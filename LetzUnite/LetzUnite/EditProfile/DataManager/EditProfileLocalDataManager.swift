//
//  EditProfileLocalDataManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation


class EditProfileLocalDataManager: EditProfileLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: EditProfileLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() -> UserProfileSingleton? {
        if userProfileManager != nil {
            return userProfileManager!
        }else {
            return nil
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
