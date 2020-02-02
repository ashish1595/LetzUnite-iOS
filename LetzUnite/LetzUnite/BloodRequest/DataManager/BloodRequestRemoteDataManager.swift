//
//  BloodRequestRemoteDataManager.swift
//  LetzUnite
//
//  Created by B0081006 on 6/30/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import Foundation
import SwiftyJSON

class BloodRequestRemoteDataManager: BloodRequestRemoteDataManagerInputProtocol {
    var remoteRequestHandler: BloodRequestRemoteDataManagerOutputProtocol?
    var validationManager: BloodRequestValidationInputProtocol?
    
    func fetchBloodRequest(With parameters: UserProfileSingleton) {
        validationManager?.validateParameters(parameters, endpoint: .reward)
    }
    
    func callFetchBloodRequestApi(With validatedParams: Dictionary<String,Any>, endpoint:Endpoint) {
        self.callApi(with: endpoint, parameters: validatedParams, method: .get)
    }
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let loginOp = JSONOperation<Any?>.init()
        loginOp.onParseResponse = { resp in
            
            switch endpoint {
            case .reward:
                do {
                    print("reward")
                    return try RewardResponse(json: resp)
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
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: nil, isEncrypted: false)
            loginOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        
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
                case .reward:
                    self.remoteRequestHandler?.onFetchBloodRequest(resp as? RewardResponse)
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


extension BloodRequestRemoteDataManager: BloodRequestValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .reward:
            self.callFetchBloodRequestApi(With: parameters, endpoint: endpoint)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        switch endpoint {
        case .reward:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        default:
            print("default")
        }
    }
}
