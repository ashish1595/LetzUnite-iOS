//
//  LoginValidation.swift
//  LetzUnite
//
//  Created by Himanshu on 5/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

class LoginValidationManager: LoginValidationInputProtocol {

    private struct SerializationKeys {
        static let emailId = "email"
        static let loginEmailId = "emailId"
        static let password = "new_password"
        static let loginPassword = "password"
        static let deviceId = "deviceId"
        static let additionalInfo = "additionalInfo"
        static let otp = "passcode"
    }
    
    var loginValidationHandler: LoginValidationOutputProtocol?
    
    func validateLoginParameters(_ email:String?, password:String?, endpoint:Endpoint) {
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        if let value = email, value.count != 0 {
            if String.validateEmailWithString(checkString: value) {
                paramDict[SerializationKeys.loginEmailId] = value
            }else {
                self.loginValidationHandler?.didValidateWithError("invalid email", endpoint: endpoint)
                return
            }
        }else {
            self.loginValidationHandler?.didValidateWithError("email is mandatory", endpoint: endpoint)
            return
        }
        
        if let value = password, value.count != 0 {
            paramDict[SerializationKeys.loginPassword] = value
        }else {
            self.loginValidationHandler?.didValidateWithError("password is mandatory", endpoint: endpoint)
            return
        }
        
        paramDict[SerializationKeys.deviceId] = Utility.getDeviceIdentifier()
        //paramDict[SerializationKeys.additionalInfo] = ""
        self.loginValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
    
    func validateForgotPasswordParameters(_ email:String?, endpoint:Endpoint) {
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        if let value = email, value.count != 0 {
            if String.validateEmailWithString(checkString: value) {
                paramDict[SerializationKeys.emailId] = value
            }else {
                self.loginValidationHandler?.didValidateWithError("invalid email", endpoint: endpoint)
                return
            }
        }else {
            self.loginValidationHandler?.didValidateWithError("email is mandatory", endpoint: endpoint)
            return
        }
        
        //paramDict[SerializationKeys.deviceId] = Utility.getDeviceIdentifier()
        //paramDict[SerializationKeys.additionalInfo] = ""
        
        self.loginValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }
    
    func validateConfirmPasswordParameters(email:String?, otp: String?, password: String?, confirmPassword: String?, endpoint: Endpoint) {
        
        var paramDict:Dictionary<String,Any> = Dictionary()
        
        if let value = email, value.count != 0 {
            paramDict[SerializationKeys.emailId] = value
        }else {
            self.loginValidationHandler?.didValidateWithError("email is mandatory", endpoint: endpoint)
            return
        }
        
        if let value = otp, value.count != 0 {
                paramDict[SerializationKeys.otp] = value
        }else {
            self.loginValidationHandler?.didValidateWithError("otp is mandatory", endpoint: endpoint)
            return
        }
        
        if let value = password, value.count != 0 {
            paramDict[SerializationKeys.password] = value
        }else {
            self.loginValidationHandler?.didValidateWithError("password is mandatory", endpoint: endpoint)
            return
        }
        
        if let value = confirmPassword, value.count != 0 {
            if confirmPassword?.count != password?.count {
                self.loginValidationHandler?.didValidateWithError("password & confirm password should be same", endpoint: endpoint)
                return
            }
        }else {
            self.loginValidationHandler?.didValidateWithError("confirm password is mandatory", endpoint: endpoint)
            return
        }
        
        self.loginValidationHandler?.didValidate(paramDict, endpoint: endpoint)
    }

}
