//
//  CreateRequestRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

class CreateRequestRemoteDataManager: CreateRequestRemoteDataManagerInputProtocol {
    var remoteRequestHandler: CreateRequestRemoteDataManagerOutputProtocol?
    var validationManager: CreateRequestValidationInputProtocol?
    
    func createBloodRequest(With parameters: BloodRequestModel, profileInfo: UserProfileSingleton?) {
        validationManager?.validateParameters(parameters, endpoint: .bloodRequest, profileInfo: profileInfo)
    }
    
    func callCreateBloodRequestApi(With validatedParameters: Dictionary<String, Any>, endpoint: Endpoint) {
        self.callApi(with: endpoint, parameters: validatedParameters, method: .post)
    }

    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let bloodRequestOp = JSONOperation<Any?>.init()
        bloodRequestOp.onParseResponse = { resp in
            switch endpoint {
            case .bloodRequest:
                do {
                    let response = try BloodRequestResponse.init(json: resp)
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
            bloodRequestOp.request = request
        }else if method == .get {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: parameters, fields: nil, body: nil, isEncrypted: false)
            bloodRequestOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        service.headers["userId"] = parameters["_id"] as? String ?? ""

        bloodRequestOp.execute(in: service, retry: 0).then { (res) -> (Void) in
            
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
                case .bloodRequest:
                    self.remoteRequestHandler?.onCreateBloodRequest(resp as! BloodRequestResponse)
                default:
                    print("default")
                }
            }else {
                self.remoteRequestHandler?.onError(with:"unable to get response", errorCode: nil, endpoint: endpoint)
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


extension CreateRequestRemoteDataManager: CreateRequestValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .bloodRequest:
            self.callCreateBloodRequestApi(With: parameters, endpoint: endpoint)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        switch endpoint {
        case .bloodRequest:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        default:
            print("default")
        }
    }
}
