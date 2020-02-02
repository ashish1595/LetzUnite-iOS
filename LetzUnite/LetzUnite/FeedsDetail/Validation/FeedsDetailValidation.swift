//
//  FeedsDetailValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 7/11/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class FeedsDetailValidationManager: FeedsDetailValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var FeedsDetailValidationHandler: FeedsDetailValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.FeedsDetailValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.FeedsDetailValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
