//
//  AppBaseLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/3/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class AppBaseLocalDataManager: AppBaseLocalDataManagerInputProtocol {
    
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: AppBaseLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() {
        localRequestHandler?.onLocalUserRetrieved(userProfileManager!)
    }
    
}
