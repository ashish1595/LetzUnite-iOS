//
//  BloodRequestValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class BloodRequestValidationManager: BloodRequestValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var BloodRequestValidationHandler: BloodRequestValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.BloodRequestValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.BloodRequestValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
