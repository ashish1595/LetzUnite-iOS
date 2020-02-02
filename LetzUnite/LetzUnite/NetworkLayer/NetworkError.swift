//
//  NetworkError.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum NetworkError: Error {
    case dataIsNotEncodable(_: Any)
    case stringFailedToDecode(_: Data, encoding: String.Encoding)
    case invalidURL(_: String)
    case error(_: ResponseProtocol)
    case noResponse(_: ResponseProtocol)
    case missingEndpoint
    case failedToParseJSON(_: JSON, _: ResponseProtocol)
    
    func associatedValue() -> Any {
        switch self {
        case .dataIsNotEncodable(let value):
            return value
        case .stringFailedToDecode(let value):
            return value
        case .invalidURL(let value):
            return value
        case .error(let value):
            return value
        case .noResponse(let value):
            return value
        case .missingEndpoint:
            return Void.self
        case .failedToParseJSON(let valueJSON, let response):
            return (valueJSON, response)
        }
    }
}
