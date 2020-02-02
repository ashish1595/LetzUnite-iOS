//
//  SearchLocalDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class SearchLocalDataManager: SearchLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: SearchLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() -> UserProfileSingleton? {
        if userProfileManager != nil {
            return userProfileManager!
        }else {
            return nil
        }
    }
}
