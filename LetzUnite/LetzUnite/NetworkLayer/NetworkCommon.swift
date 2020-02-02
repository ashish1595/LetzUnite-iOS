//
//  NetworkCommon.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case profile
    case login
    case forgotPassword = "login/generate/passcode"
    case confirmResetPassword = "login/verify/passcode"
    case reward
    case updateProfile
    case feeds = "notification/feeds"
    case bloodRequest = "requirement/blood"
    case search = "search/user"
    case history = "history"
}

enum Serialization: Error {
    case missing(String)
    case businessCase(Int,String,Any?)
    
    func associatedValue() -> Any {
        switch self {
            case .missing(let value):
                return value
            case .businessCase(let status, let message, let data):
                return (status,message,data)
        }
    }
}

/// Define the parameter's dictionary
public typealias ParametersDictionary = [String : Any?]

/// Define the header's dictionary
public typealias HeadersDictionary = [String: String]

/// Constants define
public struct NetworkConstants {
    
    /// This represent keys used into the Info.plist file of your app.
    /// The root node is `endpoint` with `base`, `pathAPI` and `name` inside which contains
    /// your server configuration.
    ///
    /// - endpoint: endpoint
    /// - base: base
    /// - pathAPI: api service path
    /// - name: name of the configuration
    /// - headers: global headers to include in a service base configuration
    public enum ServerConfiguration: String {
        case endpoint    =    "endpoint"
        case base        =    "base"
        case pathAPI     =    "path"
        case name        =    "name"
        case headers     =    "headers"
    }
    
    /// Avoid initialization of this (it's just for namingspace purposes)
    private init() {}
    
}

/// Define what kind of HTTP method must be used to carry out the `Request`
///
/// - get: get (no body is allowed inside)
/// - post: post
/// - put: put
/// - delete: delete
/// - patch: patch
public enum RequestMethod: String {
    case get        = "GET"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case patch      = "PATCH"
}
