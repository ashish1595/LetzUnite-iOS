//
//  NetworkServiceProtocol.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import PromiseKit

public protocol ServiceProtocol {
    
    /// This is the configuration used by the service
    var configuration: ServiceConfig { get }
    
    /// Headers used by the service. These headers are mirrored automatically
    /// to any Request made using the service. You can replace or remove it
    /// by overriding the `willPerform()` func of the `Request`.
    /// Session headers initially also contains global headers set by related server configuration.
    var headers: HeadersDictionary { get }
    
    /// Initialize a new service with specified configuration
    ///
    /// - Parameter configuration: configuration to use
    init(_ configuration: ServiceConfig)
    
    /// Execute a request and return a promise with a response
    ///
    /// - Parameter request: request to execute
    /// - Returns: Promise with response
    func executeReq(_ request: RequestProtocol, retry: Int?) -> Promise<ResponseProtocol>
    
}
