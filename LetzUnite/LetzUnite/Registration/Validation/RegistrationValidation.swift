//
//  RegistrationValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class RegistrationValidationManager: RegistrationValidationInputProtocol {
    var registrationValidationHandler: RegistrationValidationOutputProtocol?
    
    private struct SerializationKeys {
        static let emailId = "emailId"
        static let name = "name"
        static let password = "password"
        static let confirmPassword = "confirm_password"
        static let mobileNumber = "mobileNumber"
        static let deviceId = "deviceId"
        static let additionalInfo = "additionalInfo"
    }
    
    func validateParameters(_ parameters: UserProfileModel, endpoint: Endpoint) {
        switch endpoint {
        case .profile:
            self.validateRegistrationRequest(parameters, endpoint: endpoint)
        default:
            print("Unknown Request")
        }
    }
    
    
    func validateRegistrationRequest(_ parameters:UserProfileModel, endpoint:Endpoint){
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        if let value = parameters.username, value.count != 0 {
            paramDict[SerializationKeys.name] = value
        }else {
            self.registrationValidationHandler?.didValidateWithError("username is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.email, value.count != 0 {
            if String.validateEmailWithString(checkString: value) {
                paramDict[SerializationKeys.emailId] = value
            }else {
                self.registrationValidationHandler?.didValidateWithError("invalid email", endpoint: .profile)
                return
            }
        }else {
            self.registrationValidationHandler?.didValidateWithError("email is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.mobile, value.count != 0 {
            if value.count == registration_mobile_num_equals {
                paramDict[SerializationKeys.mobileNumber] = value
            }else {
                self.registrationValidationHandler?.didValidateWithError("mobilenumber is incorrect", endpoint: .profile)
                return
            }
        }else {
            self.registrationValidationHandler?.didValidateWithError("mobilenumber is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.password, value.count != 0 {
            paramDict[SerializationKeys.password] = value
        }else {
            self.registrationValidationHandler?.didValidateWithError("password is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.confirmPassword, value.count != 0 {
            if (parameters.password != value) {
                self.registrationValidationHandler?.didValidateWithError("password & confirm password should be same", endpoint: .profile)
                return
            }
        }else {
            self.registrationValidationHandler?.didValidateWithError("confirm password is mandatory", endpoint: .profile)
            return
        }
        
        
        
        paramDict[SerializationKeys.deviceId] = Utility.getDeviceIdentifier()
        //paramDict[SerializationKeys.additionalInfo] = ""
        
        self.registrationValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
}
