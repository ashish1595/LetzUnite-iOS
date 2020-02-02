//
//  CreateRequestLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class CreateRequestLocalDataManager: CreateRequestLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: CreateRequestLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() -> UserProfileSingleton? {
        if userProfileManager != nil {
            return userProfileManager!
        }else {
            return nil
        }
    }
    
}
