//
//  ReceivedHistoryValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class ReceivedHistoryValidationManager: ReceivedHistoryValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var ReceivedHistoryValidationHandler: ReceivedHistoryValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.ReceivedHistoryValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.ReceivedHistoryValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
