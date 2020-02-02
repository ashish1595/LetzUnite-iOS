//
//  NetworkOperationProtocol.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import PromiseKit

/// Operation Protocol
protocol OperationProtocol {
    associatedtype T
    
    /// Request
    var request: RequestProtocol? { get set }
    
    /// Execute an operation into specified service
    ///
    /// - Parameters:
    ///   - service: service to use
    ///   - retry: retry attempts
    /// - Returns: Promise
    func execute(in service: ServiceProtocol, retry: Int?) -> Promise<T>
}
