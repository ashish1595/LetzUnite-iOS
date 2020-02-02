//
//  VisitProfileLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class VisitProfileLocalDataManager: VisitProfileLocalDataManagerInputProtocol {
    var userVisitProfileManager: UserProfileSingleton?
    var localRequestHandler: VisitProfileLocalDataManagerOutputProtocol?
    
    func retrieveUserVisitProfile() -> UserProfileSingleton? {
        if userVisitProfileManager != nil {
            return userVisitProfileManager!
        }else {
            return nil
        }
    }
    
    func retrieveUserVisitProfileToDisplay() {
        if userVisitProfileManager != nil {
            var user = UserProfileModel.init()
            user.firstname = userVisitProfileManager?.name
            user.email = userVisitProfileManager?.emailId
            user.mobile = userVisitProfileManager?.mobileNumber
            localRequestHandler?.onLocalVisitProfileRetrieval(user)
        }else {
            localRequestHandler?.onLocalVisitProfileRetrievalError("error in retriving user VisitProfile")
        }
    }
    
    func saveUpdatedUserVisitProfile(_ VisitProfile: UserProfileModel?) -> Bool {
        if let userVisitProfile = VisitProfile {
            userVisitProfileManager?.name = userVisitProfile.username
            userVisitProfileManager?.emailId = userVisitProfile.email
            userVisitProfileManager?.mobileNumber = userVisitProfile.mobile
            //add other params too
            return true
        }else {
            return false
        }
    }
    
}
