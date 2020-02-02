//
//  ProfileRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProfileRemoteDataManager: ProfileRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    var validationManager: ProfileValidationInputProtocol?
    
    func updateProfile(With parameters: UserProfileModel, savedUser: UserProfileSingleton) {
        validationManager?.validateParameters(parameters, endpoint: .profile, savedUserProfile: savedUser)
    }
    
    func callUpdateProfileApi(With validatedParams:Dictionary<String,Any>, endpoint:Endpoint, updatedProfile:UserProfileModel?) {
        self.callApi(with: endpoint, parameters: validatedParams, updatedProfile: updatedProfile!, method: .put)
    }
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, updatedProfile:UserProfileModel, method: RequestMethod) {
        let loginOp = JSONOperation<Any?>.init()
        loginOp.onParseResponse = { resp in
            
            switch endpoint {
            case .profile:
                do {
                    let response = try UserUpdateProfileResponse.init(json: resp)
                    return response
                }catch {
                    return error
                }
            default:
                return nil
            }
        }
        
        if method == .post {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: RequestBody.json(parameters), isEncrypted: true)
            loginOp.request = request
        }else if method == .get{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: nil, isEncrypted: false)
            loginOp.request = request
        }else if method == .put{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: RequestBody.json(parameters), isEncrypted: true)
            loginOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers = ["Content-Type":"application/json"]
        
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
                    case .profile:
                        self.remoteRequestHandler?.onUpdateProfile(resp as! UserUpdateProfileResponse, updatedProfile: updatedProfile)
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


extension ProfileRemoteDataManager: ProfileValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint, updatedProfile: UserProfileModel?) {
        switch endpoint {
        case .profile:
            self.callUpdateProfileApi(With: parameters, endpoint: endpoint, updatedProfile: updatedProfile)
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
