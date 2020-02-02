//
//  BloodRequestDetailValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class BloodRequestDetailValidationManager: BloodRequestDetailValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var BloodRequestDetailValidationHandler: BloodRequestDetailValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.BloodRequestDetailValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.BloodRequestDetailValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
