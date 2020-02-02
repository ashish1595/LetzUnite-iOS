//
//  BloodRequestLocalDataManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
class BloodRequestLocalDataManager: BloodRequestLocalDataManagerInputProtocol {
    var userProfileManager: UserProfileSingleton?
    var localRequestHandler: BloodRequestLocalDataManagerOutputProtocol?
    
    func retrieveUserProfile() -> UserProfileSingleton? {
        if userProfileManager != nil {
            return userProfileManager!
        }else {
            return nil
        }
    }
}
