//
//  RewardsValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class RewardsValidationManager: RewardsValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var rewardsValidationHandler: RewardsValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
                paramDict[SerializationKeys.userId] = value
            }else {
                self.rewardsValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
                return
            }
        
        self.rewardsValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
