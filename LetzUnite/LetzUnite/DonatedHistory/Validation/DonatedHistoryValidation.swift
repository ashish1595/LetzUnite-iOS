//
//  DonatedHistoryValidation.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation

class DonatedHistoryValidationManager: DonatedHistoryValidationInputProtocol {
    
    private struct SerializationKeys {
        static let userId = "userId"
    }
    
    var DonatedHistoryValidationHandler: DonatedHistoryValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileSingleton, endpoint: Endpoint) {
        var paramDict:Dictionary<String,Any> = Dictionary()
        if let value = parameters._id, value.count != 0 {
            paramDict[SerializationKeys.userId] = value
        }else {
            self.DonatedHistoryValidationHandler?.didValidateWithError("userId is missing", endpoint: endpoint)
            return
        }
        
        self.DonatedHistoryValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
