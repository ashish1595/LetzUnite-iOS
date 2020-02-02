//
//  NetworkService.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

/// Service is a concrete implementation of the ServiceProtocol
public class Service: ServiceProtocol {
    
    /// Configuration
    public var configuration: ServiceConfig
    
    /// Session headers
    public var headers: HeadersDictionary
    
    /// Initialize a new service with given configuration
    ///
    /// - Parameter configuration: configuration. If `nil` is passed attempt to load configuration from your app's Info.plist
    public required init(_ configuration: ServiceConfig) {
        self.configuration = configuration
        self.headers = self.configuration.headers // fillup with initial headers
        
        let userToken = (UserDefaults.retrieveObject(forKey: UserDefaultsSerializationKey.profile.rawValue) as? UserProfileSingleton)?.userToken ?? ""
        headers["AUTH_TOKEN"] = userToken
    }
    
    /// Execute a request and return a promise with the response
    ///
    /// - Parameters:
    ///   - request: request to execute
    ///   - retry: retry attempts. If `nil` only one attempt is made. Default value is `nil`.
    /// - Returns: Promise
    /// - Throws: throw an exception if operation cannot be executed
    public func executeReq(_ request: RequestProtocol, retry: Int?) -> Promise<ResponseProtocol> {
        
        let op = Promise<ResponseProtocol> { (fulfill, reject) in
            // Attempt to create the object to perform request
            let dataOperation: DataRequest = try Alamofire.request(request.urlRequest(in: self))

            // Execute operation in Alamofire
            dataOperation.response(completionHandler: { rData in
                // Parse response
                let parsedResponse = Response(afResponse: rData, request: request)
                switch parsedResponse.type {
                    case .success: // success
                        fulfill(parsedResponse)
                    case .error: // failure
                        reject(NetworkError.error(parsedResponse))
                    case .noResponse:  // no response
                        reject(NetworkError.noResponse(parsedResponse))
                }
            })
        }
        return op
    }
    
}
