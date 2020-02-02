//
//  SearchRemoteDataManager.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchRemoteDataManager: SearchRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    var validationManager: SearchValidationInputProtocol?
    
    func searchRecordsRequest(With parameters: SearchRequestModel, profileInfo: UserProfileSingleton?) {
        self.validationManager?.validateParameters(parameters, endpoint: .search, profileInfo: profileInfo)
    }
    
    func callSearchRecordApi(With validatedParameters: Dictionary<String, Any>, endpoint: Endpoint) {
        self.callApi(with: endpoint, parameters: validatedParameters, method: .get)
    }
    
    func callApi(with endpoint:Endpoint, parameters:Dictionary<String,Any>, method: RequestMethod) {
        let searchOp = JSONOperation<Any?>.init()
        searchOp.onParseResponse = { resp in
            switch endpoint {
            case .search:
                do {
                    print("search")
                    return try SearchResponse(json: resp)
                }catch {
                    return error
                }
            default:
                return nil
            }
        }
        
        if method == .post {
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: RequestBody.json(parameters), isEncrypted: true)
            searchOp.request = request
        }else if method == .get{
            let request = Request.init(method: method, endpoint: endpoint.rawValue, params: nil, fields: parameters, body: nil, isEncrypted: false)
            searchOp.request = request
        }
        
        let service = Service.init(ServiceConfig.appConfig()!)
        service.headers["Content-Type"] = "application/json"
        
        searchOp.execute(in: service, retry: 0).then { (res) -> (Void) in
            
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
                case .search:
                    self.remoteRequestHandler?.onSearchRecords(resp as! SearchResponse)
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

extension SearchRemoteDataManager: SearchValidationOutputProtocol {
    func didValidate(_ parameters: Dictionary<String, Any>, endpoint: Endpoint) {
        switch endpoint {
        case .search:
            self.callSearchRecordApi(With: parameters, endpoint: endpoint)
        default:
            print("default")
        }
    }
    
    func didValidateWithError(_ errorMessage: String, endpoint: Endpoint) {
        
    }
}
