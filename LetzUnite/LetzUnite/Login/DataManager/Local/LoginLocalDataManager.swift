//
//  LoginLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class LoginLocalDataManager: LoginLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: LoginLocalDataManagerOutputProtocol?
    
    func saveUserProfile(_ loginResponse: UserLoginResponse) {
        userProfileManager?.name = loginResponse.name
        userProfileManager?._id = loginResponse._id
        userProfileManager?.emailId = loginResponse.emailId
        userProfileManager?.mobileNumber = loginResponse.mobileNumber
        userProfileManager?.userToken = loginResponse.tokenId
        userProfileManager?.additionalInfo = loginResponse.additionalInfo
        
        //Saving UserProfile in UserDefaults
        UserDefaults.saveObject(object: userProfileManager ?? UserProfileSingleton.sharedInstance, forKey: UserDefaultsSerializationKey.profile.rawValue)
    }
}
