//
//  NetworkServiceConfiguration.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

/// This class is used to configure network connection with a backend server
public final class ServiceConfig: CustomStringConvertible, Equatable {
    
    /// Name of the server configuration. Tipically you can add it your environment name, ie. "Testing" or "Production"
    private(set) var name: String
    
    /// This is the base host url (ie. "http://www.myserver.com/api/v2"
    private(set) var url: URL
    
    /// These are the global headers which must be included in each session of the service
    private(set) var headers: HeadersDictionary = [:]
    
    /// Cache policy you want apply to each request done with this service
    /// By default is `.useProtocolCachePolicy`.
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    
    /// Global timeout for any request. If you want, you can override it in Request
    /// Default value is 15 seconds.
    public var timeout: TimeInterval = 15.0
    
    /// Initialize a new service configuration
    ///
    /// - Parameters:
    ///   - name: name of the configuration (its just for debug purpose)
    ///   - urlString: base url of the service
    ///   - api: path to APIs service endpoint
    public init?(name: String? = nil, base urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
        self.name = name ?? (url.host ?? "")
    }
    
    /// Attempt to load server configuration from Info.plist
    ///
    /// - Returns: ServiceConfig if Info.plist of the app can be parsed, `nil` otherwise
    public static func appConfig() -> ServiceConfig? {
        return ServiceConfig()
    }
    
    /// Initialize a new service configuration by looking at paramters
    public convenience init?() {
        // Attemp to load the configuration inside the Info.plist of your app.
        // It must be a dictionary of this type ```{ "endpoint" : { "base" : "host.com", path : "api/v2" } }```
        let appCfg = JSON(Bundle.main.object(forInfoDictionaryKey: NetworkConstants.ServerConfiguration.endpoint.rawValue) as Any)
        guard let base = appCfg[NetworkConstants.ServerConfiguration.base.rawValue].string else {
            return nil
        }
        // Initialize with parameters
        self.init(name: appCfg[NetworkConstants.ServerConfiguration.name.rawValue].stringValue, base: base)
        
        // Attempt to read a fixed list of headers from configuration
        if let fixedHeaders = appCfg[NetworkConstants.ServerConfiguration.headers.rawValue].dictionaryObject as? HeadersDictionary {
            self.headers = fixedHeaders
        }
    }
    
    /// Readable description
    public var description: String {
        return "\(self.name): \(self.url.absoluteString)"
    }
    
    /// A Service configuration is equal to another if both url and path to APIs endpoint are the same.
    /// This comparison ignore service name.
    ///
    /// - Parameters:
    ///   - lhs: configuration a
    ///   - rhs: configuration b
    /// - Returns: `true` if equals, `false` otherwise
    public static func ==(lhs: ServiceConfig, rhs: ServiceConfig) -> Bool {
        return lhs.url.absoluteString.lowercased() == rhs.url.absoluteString.lowercased()
    }
}
