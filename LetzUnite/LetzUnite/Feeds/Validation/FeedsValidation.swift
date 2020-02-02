//
//  FeedsValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class FeedsValidationManager: FeedsValidationInputProtocol {
    var feedsValidationHandler: FeedsValidationOutputProtocol?
    
    private struct SerializationKeys {
        static let userId = "userId"
        static let type = "type"
    }
    
    func validateParameters(_ parameters: UserProfileSingleton?, endpoint: Endpoint) {
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        if (parameters != nil) {
            if let value = parameters?._id, value.count != 0 {
                //paramDict[SerializationKeys.userId] = value
            }else {
            self.feedsValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
                return
            }
            
            //TODO: what is type and why it is 1, need to be dynamic
            paramDict[SerializationKeys.type] = "1"
            
            self.feedsValidationHandler?.didValidate(paramDict, endpoint: endpoint)
        }else {
            self.feedsValidationHandler?.didValidateWithError("user profile not found", endpoint: endpoint)
            return
        }

    }
 
}
