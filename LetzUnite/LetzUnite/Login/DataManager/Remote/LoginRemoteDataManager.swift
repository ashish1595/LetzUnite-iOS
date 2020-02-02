//
//  LoginRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

class LoginRemoteDataManager: LoginRemoteDataManagerInputProtocol {

    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    var validationManager: LoginValidationInputProtocol?
    
    func retrieveUser(With username: String, password: String) {
        validationManager?.validateLoginParameters(username, password: password, endpoint: .login)
    }

    func callLoginApi(With validatedParams: Dictionary<String, Any>) {
        self.callApi(with: .login, parameters: validatedParams, method: .post)
    }
    
    func resetPassword(With emailId: String) {
        validationManager?.validateForgotPasswordParameters(emailId, endpoint: .forgotPassword)
    }
    
    func callForgotPasswordApi(With parameters:Dictionary<String,Any>) {
        self.callApi(with: .forgotPassword, parameters: parameters, method: .get)
    }
    
    func confirmResetPassword(email: String, otp: String, newPassword: String, confirmPassword: String) {
        validationManager?.validateConfirmPasswordParameters(email: email, otp: otp, password: newPassword, confirmPassword: confirmPassword, endpoint: .confirmResetPassword)
    }
    
    func callConfirmResetPasswordApi(With parameters:Dictionary<String,Any>) {
        self.callApi(with: .confirmResetPassword, parameters: parameters, method: .get)
    }
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let loginOp = JSONOperation<Any?>.init()
        loginOp.onParseResponse = { resp in
            
                switch endpoint {
                case .login:
                    do {
                        print("login")
                        return try UserLoginResponse(json: resp)
                    }catch {
                        return error
                    }
                case .forgotPassword:
                    print("forgotPassword")
                    do {
                        return try ForgotPasswordResponse(json: resp)
                    }catch {
                        return error
                    }
                case .confirmResetPassword:
                    print("confirmResetPassword")
                    do {
                        return try VerifyPasswordResponse(json: resp)
                    }catch {
                        return error
                    }
                default:
                    return nil
                }
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        
        if endpoint == .forgotPassword {
            service.headers["email"] = parameters["email"] as? String ?? ""
        }
        
        if endpoint == .confirmResetPassword {
            service.headers["email"] = parameters["email"] as? String ?? ""
            service.headers["passcode"] = parameters["passcode"] as? String ?? ""
        }
        
        if method == .post {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: RequestBody.json(parameters), isEncrypted: true)
            loginOp.request = request
        }else if method == .get{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: nil, isEncrypted: false)
            loginOp.request = request
        }
        
        loginOp.execute(in: service, retry: 0).then { (res) -> (Void) in
            
            if let err = res as? Serialization {
                if case let .missing(message) = err {
                    self.remoteRequestHandler?.onError(with: message, errorCode: nil, endpoint: endpoint)
                    return
                }
                
                if case let .businessCase(status,message,nil) = err {
                    self.remoteRequestHandler?.onError(with: message, errorCode: status, endpoint: endpoint)
                    return
                }
            }
            
            if let resp = res {
                switch endpoint {
                case .login:
                    self.remoteRequestHandler?.onUserRetrieved(resp as! UserLoginResponse)
                case .forgotPassword:
                    self.remoteRequestHandler?.onResetPassword(response: resp as! ForgotPasswordResponse)
                case .confirmResetPassword:
                    self.remoteRequestHandler?.onConfirmResetPassword(response: resp as! VerifyPasswordResponse)
                default:
                    print("default")
                }
            }else {
                self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
            }
            
            }.catch(execute: { (error) in
                if let newError = error as? NetworkError {
                    if case let .error(err) = newError {
                        if let responseError = err as? Response {
                            let data:JSON = responseError.toJSON()
                            self.remoteRequestHandler?.onError(with: data["message"].string, errorCode: data["status"].int, endpoint: endpoint)
                        }else {
                            self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
                        }
                    }else if case let .noResponse(err) = newError {
                        if let responseError = err as? Response {
                            print(responseError.toString() as Any)
                            
                            self.remoteRequestHandler?.onError(with: "no response", errorCode: nil, endpoint: endpoint)
                            
                        }else {
                            self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
                        }
                    }else {
                        self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
                    }
                }else {
                    self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
                }
            })
    }
}

extension LoginRemoteDataManager: LoginValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .login:
            self.callLoginApi(With: parameters)
        case .forgotPassword:
            self.callForgotPasswordApi(With: parameters)
        case .confirmResetPassword:
            self.callConfirmResetPasswordApi(With: parameters)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        switch endpoint {
        case .login:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        case .forgotPassword:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        case .confirmResetPassword:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        default:
            print("default")
        }
    }
}
