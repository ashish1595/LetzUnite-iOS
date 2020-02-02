//
//  RegistrationRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

class RegistrationRemoteDataManager: RegistrationRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RegistrationRemoteDataManagerOutputProtocol?
    var validationManager: RegistrationValidationInputProtocol?

    func registerUser(With userProfileInfo: UserProfileModel) {
        validationManager?.validateParameters(userProfileInfo, endpoint: .profile)
    }
    
    func callRegisterUserApi(With validatedParams: Dictionary<String,Any>) {
//        let registrationOp = JSONOperation<Any?>.init()
//        registrationOp.onParseResponse = { resp in
//            do {
//                var response = try UserRegistrationResponse.init(json: resp)
//                response.email = validatedParams["emailId"] as? String
//                return response
//            }catch {
//                return error
//            }
//        }
//
//        let request = Request.init(method: .post, endpoint: Endpoint.profile.rawValue, params: validatedParams, fields: nil, body: RequestBody.json(validatedParams), isEncrypted: true)
//        registrationOp.request = request
//
//        let service = Service.init(ServiceConfig.appConfig()!)
//        service.headers = ["Content-Type":"application/json"]
//
//        registrationOp.execute(in: service, retry: 0).then { (res) -> (Void) in
//
//            if let err = res as? Serialization {
//                if case let .missing(message) = err {
//                    self.remoteRequestHandler?.onError(with: message, errorCode: nil, endpoint: endpoint)
//                    return
//                }
//
//                if case let .businessCase(status,message,nil) = err {
//                    self.remoteRequestHandler?.onError(with: message, errorCode: status, endpoint: endpoint)
//                    return
//                }
//            }
//
//
//
//            }.catch(execute: { (err) in
//                if err is NetworkError {
//                    let netErr:NetworkError = err as! NetworkError
//                    print(netErr.localizedDescription)
//                }else {
//                    print(err.localizedDescription)
//
//                }
//
//                self.remoteRequestHandler?.onError(err.localizedDescription, endpoint: Endpoint.profile)
//            })
        self.callApi(with: .profile, parameters: validatedParams, method: .post)
    }
    
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let registerOp = JSONOperation<Any?>.init()
        registerOp.onParseResponse = { resp in
            
            switch endpoint {
            case .profile:
                do {
                    print("profile")
                    var response = try UserRegistrationResponse.init(json: resp)
                        response.email = parameters["emailId"] as? String
                    return response
                }catch {
                    return error
                }
            default:
                return nil
            }
        }
        
        if method == .post {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: nil, isEncrypted: true)
            //body: RequestBody.json(parameters) when isEncrypted is false, params is nil
            registerOp.request = request
        }else if method == .get{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: nil, isEncrypted: false)
            registerOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        
        registerOp.execute(in: service, retry: 0).then { (res) -> (Void) in
            
            if let err = res as? Serialization {
                if case let .missing(message) = err {
                    self.remoteRequestHandler?.onError(with: message, errorCode: nil, endpoint: endpoint)
                    return
                }
                
                if case let .businessCase(status,message,resp) = err {
                    if resp != nil {
                        self.remoteRequestHandler?.onUserRegistration(resp as! UserRegistrationResponse)
                    }else {
                        self.remoteRequestHandler?.onError(with: message, errorCode: status, endpoint: endpoint)
                    }
                    return
                }
            }
            
            if let resp = res {
                switch endpoint {
                case .profile:
                    self.remoteRequestHandler?.onUserRegistration(resp as! UserRegistrationResponse)
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
                            
                            self.remoteRequestHandler?.onError(with: nil, errorCode: nil, endpoint: endpoint)
                            
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



extension RegistrationRemoteDataManager: RegistrationValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .profile:
            self.callRegisterUserApi(With: parameters)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        switch endpoint {
        case .profile:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        default:
            print("default")
        }
    }
}
