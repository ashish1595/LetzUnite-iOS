//
//  NetworkOperation.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

/// Data operation, return a response via Promise
open class DataOperation<ResponseProtocol>: OperationProtocol {
    typealias T = ResponseProtocol
    
    /// Request to send
    public var request: RequestProtocol?
    
    /// Init
    public init() { }
    
    /// Execute the request in a service and return a promise with server response
    ///
    /// - Parameters:
    ///   - service: service to use
    ///   - retry: retry attempts in case of failure
    /// - Returns: Promise
    public func execute(in service: ServiceProtocol, retry: Int? = nil) -> Promise<ResponseProtocol> {
        
        return Promise<ResponseProtocol>(resolvers: { (fulfill, reject) in
            guard let rq = self.request else { // missing request
                reject(NetworkError.missingEndpoint)
                return
            }

            //execute the request
            service.executeReq(rq, retry: retry).then(execute: { (dataResponse) -> Void in
                let x: ResponseProtocol = dataResponse as! ResponseProtocol
                fulfill(x)
            }).catch(execute: { (error) in
                
            })
        })
        
        
    }
}


/// JSON Operation, return a response as JSON
open class JSONOperation<Output>: OperationProtocol {
    
    typealias T = Output
    
    /// Request
    public var request: RequestProtocol?
    
    /// Implement this function to provide a parsing from raw JSON to `Output`
    public var onParseResponse: ((JSON) throws -> (Output))? = nil
    
    /// Init
    public init() {
        self.onParseResponse = { _ in
            fatalError("You must implement a `onParseResponse` to return your <Output> from JSONOperation")
        }
    }
    
    /// Execute a request and return your specified model `Output`.
    ///
    /// - Parameters:
    ///   - service: service to use
    ///   - retry: retry attempts
    /// - Returns: Promise
    public func execute(in service: ServiceProtocol, retry: Int? = nil) -> Promise<Output> {
        return Promise<Output>(resolvers: { (fulfill, reject) in
            guard let rq = self.request else { // missing request
                reject(NetworkError.missingEndpoint)
                return
            }

            //execute the request
            service.executeReq(rq, retry: retry).then(execute: { response -> Void in
                    let json = response.toJSON() // parse json response
                    do {
                        // Attempt to call custom parsing. Your own class must implement it.
                        let parsedObj = try self.onParseResponse!(json)
                        fulfill(parsedObj)
                    } catch {
                        throw NetworkError.failedToParseJSON(json,response)
                    }
            }).catch(execute: { (error) in
                print(error.localizedDescription)
                reject(error)
            })
        })
    }
}
