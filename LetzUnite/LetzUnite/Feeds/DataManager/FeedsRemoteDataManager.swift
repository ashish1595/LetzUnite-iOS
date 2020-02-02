//
//  FeedsRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedsRemoteDataManager: FeedsRemoteDataManagerInputProtocol {
    var remoteRequestHandler: FeedsRemoteDataManagerOutputProtocol?
    var validationManager: FeedsValidationInputProtocol?

    func fetchFeeds(With params: UserProfileSingleton?) {
        validationManager?.validateParameters(params, endpoint: .feeds)
    }
    
    func callFetchFeedsApi(With validatedParams: Dictionary<String, Any>, endpoint: Endpoint) {
        self.callApi(with: endpoint, parameters: validatedParams, method: .get)
    }
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let feedsOp = JSONOperation<Any?>.init()
        feedsOp.onParseResponse = { resp in
            
            switch endpoint {
            case .feeds:
                do {
                    print("feeds")
                    return try FeedsResponse(json: resp)
                }catch {
                    return error
                }
            default:
                return nil
            }
        }
        
        if method == .post {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: RequestBody.json(parameters), isEncrypted: true)
            feedsOp.request = request
        }else if method == .get{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: nil, isEncrypted: false)
            feedsOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        let _id = (UserDefaults.retrieveObject(forKey: UserDefaultsSerializationKey.profile.rawValue) as? UserProfileSingleton)?._id ?? ""
        service.headers["userId"] = _id
        
        feedsOp.execute(in: service, retry: 0).then { (res) -> (Void) in
            
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
                case .feeds:
                    self.remoteRequestHandler?.onFetchFeeds(resp as! FeedsResponse)
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


extension FeedsRemoteDataManager: FeedsValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .feeds:
            self.callFetchFeedsApi(With: parameters, endpoint: endpoint)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        switch endpoint {
        case .feeds:
            self.remoteRequestHandler?.onError(with: errorMessage, errorCode: nil, endpoint: endpoint)
        default:
            print("default")
        }
    }
}
