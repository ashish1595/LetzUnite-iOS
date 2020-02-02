//
//  CreateRequestValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class CreateRequestValidationManager: CreateRequestValidationInputProtocol {
    
    private struct SerializationKeys {        
        static let availableHours = "availableHours"
        static let bloodType = "bloodType"
        static let city = "city"
        static let contactPersonNumber = "contactPersonNumber"
        static let disease = "disease"
        static let hospitalContactPerson = "hospitalContactPerson"
        static let hospitalName = "hospitalName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let location = "location"
        static let patientName = "patientName"
        static let state = "state"
        static let _id = "_id"
    }
    
    var createRequestValidationHandler: CreateRequestValidationOutputProtocol?
    
    func validateParameters(_ parameters: BloodRequestModel, endpoint: Endpoint, profileInfo: UserProfileSingleton?) {
        self.validateCreateBloodRequestRequest(parameters, endpoint: endpoint, savedUser: profileInfo!)
    }
    
    func validateCreateBloodRequestRequest(_ parameters:BloodRequestModel, endpoint:Endpoint, savedUser: UserProfileSingleton){
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        paramDict[SerializationKeys.availableHours] = parameters.availableHours ?? ""
        paramDict[SerializationKeys.bloodType] = parameters.bloodType ?? ""
        paramDict[SerializationKeys.city] = parameters.city ?? ""
        paramDict[SerializationKeys.contactPersonNumber] = parameters.contactPersonNumber ?? ""
        paramDict[SerializationKeys.hospitalName] = parameters.hospitalName ?? ""
        paramDict[SerializationKeys.disease] = parameters.disease ?? ""
        paramDict[SerializationKeys.hospitalContactPerson] = parameters.hospitalContactPerson ?? ""
        paramDict[SerializationKeys.latitude] = parameters.latitude ?? ""
        paramDict[SerializationKeys.longitude] = parameters.longitude ?? ""
        paramDict[SerializationKeys.location] = parameters.location ?? ""
        paramDict[SerializationKeys.patientName] = parameters.patientName ?? ""
        paramDict[SerializationKeys.state] = parameters.state ?? ""
        paramDict[SerializationKeys._id] = savedUser._id ?? ""

        self.createRequestValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
