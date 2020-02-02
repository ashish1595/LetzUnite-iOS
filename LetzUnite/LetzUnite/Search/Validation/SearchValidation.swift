//
//  SearchValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class SearchValidationManager: SearchValidationInputProtocol {
    
    private struct SerializationKeys {
        static let id = "userId"
        static let searchUserType = "searchUserType"
        static let location = "location"
        static let bloodGroup = "bloodGroup"
        static let range = "range"
    }
    
    var searchValidationHandler: SearchValidationOutputProtocol?
    
    func validateParameters(_ parameters: SearchRequestModel, endpoint: Endpoint, profileInfo: UserProfileSingleton?) {
        self.validateSearchRecordsRequest(parameters, endpoint: endpoint, savedUser: profileInfo!)
    }
    
    func validateSearchRecordsRequest(_ parameters:SearchRequestModel, endpoint:Endpoint, savedUser: UserProfileSingleton){
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        paramDict[SerializationKeys.id] = savedUser._id
        paramDict[SerializationKeys.searchUserType] = parameters.searchUserType
        paramDict[SerializationKeys.location] = parameters.location
        paramDict[SerializationKeys.bloodGroup] = parameters.bloodGroup
        paramDict[SerializationKeys.range] = parameters.range

        self.searchValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
