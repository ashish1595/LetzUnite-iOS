//
//  ProfileValidationManager.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class ProfileValidationManager: ProfileValidationInputProtocol {
    
    private struct SerializationKeys {
        static let _id = "id"
        static let emailId = "emailId"
        static let name = "name"
        static let password = "password"
        static let confirmPassword = "confirm_password"
        static let mobileNumber = "mobileNumber"
        static let deviceId = "deviceId"
        static let additionalInfo = "additionalInfo"
    }
    
    var profileValidationHandler: ProfileValidationOutputProtocol?
    
    func validateParameters(_ parameters: UserProfileModel, endpoint: Endpoint) {
        
    }
    
    func validateParameters(_ parameters: UserProfileModel, endpoint: Endpoint, savedUserProfile: UserProfileSingleton) {
        switch endpoint {
        case .profile:
            self.validateUpdateProfileRequest(parameters, endpoint: endpoint, savedUser: savedUserProfile)
        default:
            print("Unknown Request")
        }
    }
    
    func validateUpdateProfileRequest(_ parameters:UserProfileModel, endpoint:Endpoint, savedUser: UserProfileSingleton){
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        if let value = savedUser._id, value.count != 0 {
            paramDict[SerializationKeys._id] = value
        }else {
            self.profileValidationHandler?.didValidateWithError("userId is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.username, value.count != 0 {
            paramDict[SerializationKeys.name] = value
        }else {
            self.profileValidationHandler?.didValidateWithError("username is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.email, value.count != 0 {
            if String.validateEmailWithString(checkString: value) {
                paramDict[SerializationKeys.emailId] = value
            }else {
                self.profileValidationHandler?.didValidateWithError("invalid email", endpoint: .profile)
                return
            }
        }else {
            self.profileValidationHandler?.didValidateWithError("email is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.mobile, value.count != 0 {
            if value.count == registration_mobile_num_equals {
                paramDict[SerializationKeys.mobileNumber] = value
            }else {
                self.profileValidationHandler?.didValidateWithError("mobilenumber is incorrect", endpoint: .profile)
                return
            }
        }else {
            self.profileValidationHandler?.didValidateWithError("mobilenumber is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.password, value.count != 0 {
            paramDict[SerializationKeys.password] = value
        }else {
            self.profileValidationHandler?.didValidateWithError("password is mandatory", endpoint: .profile)
            return
        }
        
        if let value = parameters.confirmPassword, value.count != 0 {
            if (parameters.password != value) {
                self.profileValidationHandler?.didValidateWithError("password & confirm password should be same", endpoint: .profile)
                return
            }
        }else {
            self.profileValidationHandler?.didValidateWithError("confirm password is mandatory", endpoint: .profile)
            return
        }
        
        /*
         need to set data from saved user like user id etc
         */
        
        paramDict[SerializationKeys.deviceId] = Utility.getDeviceIdentifier()

        //paramDict[SerializationKeys.additionalInfo] = ""
        
        self.profileValidationHandler?.didValidate(paramDict, endpoint: endpoint, updatedProfile: parameters)
    }
}
