//
//  NotificationValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class NotificationValidationManager: NotificationValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var NotificationValidationHandler: NotificationValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.NotificationValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.NotificationValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
