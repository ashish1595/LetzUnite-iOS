//
//  NetworkRequestBody.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation

/// This define how the body should be encoded
///
/// - none: no transformation is applied, data is sent raw as received in `body` param of the request.
/// - json: attempt to serialize a `Dictionary` or a an `Array` as `json`. Other types are not supported and throw an exception.
/// - urlEncoded: it expect a `Dictionary` as input and encode it as url encoded string into the body.
/// - custom->: custom serializer. `Any` is accepted, `Data` is expected as output.
public struct RequestBody {
    
    /// Data to carry out into the body of the request
    let data: Any
    
    /// Type of encoding to use
    let encoding: Encoding
    
    /// Encoding type
    ///
    /// - raw: no encoding, data is sent as received
    /// - json: json encoding
    /// - urlEncoded: url encoded string
    /// - custom: custom serialized data
    public enum Encoding {
        case rawData
        case rawString(_: String.Encoding?)
        case json
        case urlEncoded(_: String.Encoding?)
        case custom(_: CustomEncoder)
        
        /// Encoder function typealias
        public typealias CustomEncoder = ((Any) -> (Data))
    }
    
    /// Private initializa a new body
    ///
    /// - Parameters:
    ///   - data: data
    ///   - encoding: encoding type
    private init(_ data: Any, as encoding: Encoding = .json) {
        self.data = data
        self.encoding = encoding
    }
    
    /// Create a new body which will be encoded as JSON
    ///
    /// - Parameter data: any serializable to JSON object
    /// - Returns: RequestBody
    public static func json(_ data: Any) -> RequestBody {
        return RequestBody(data, as: .json)
    }
    
    /// Create a new body which will be encoded as url encoded string
    ///
    /// - Parameters:
    ///   - data: a string of encodable data as url
    ///   - encoding: encoding type to transform the string into data
    /// - Returns: RequestBody
    public static func urlEncoded(_ data: ParametersDictionary, encoding: String.Encoding? = .utf8) -> RequestBody {
        return RequestBody(data, as: .urlEncoded(encoding))
    }
    
    /// Create a new body which will be sent in raw form
    ///
    /// - Parameter data: data to send
    /// - Returns: RequestBody
    public static func raw(data: Data) -> RequestBody {
        return RequestBody(data, as: .rawData)
    }
    
    /// Create a new body which will be sent as plain string encoded as you set
    ///
    /// - Parameter data: data to send
    /// - Returns: RequestBody
    public static func raw(string: String, encoding: String.Encoding? = .utf8) -> RequestBody {
        return RequestBody(string, as: .rawString(encoding))
    }
    
    /// Create a new body which will be encoded with a custom function.
    ///
    /// - Parameters:
    ///   - data: data to encode
    ///   - encoder: encoder function
    /// - Returns: RequestBody
    public static func custom(_ data: Data, encoder: @escaping Encoding.CustomEncoder) -> RequestBody {
        return RequestBody(data, as: .custom(encoder))
    }
    
    /// Encoded data to carry out with the request
    ///
    /// - Returns: Data
    public func encodedData() throws -> Data {
        switch self.encoding {
        case .rawData:
            return self.data as! Data
        case .rawString(let encoding):
            guard let string = (self.data as! String).data(using: encoding ?? .utf8) else {
                throw NetworkError.dataIsNotEncodable(self.data)
            }
            return string
        case .json:
            return try JSONSerialization.data(withJSONObject: self.data, options: [])
        case .urlEncoded(let encoding):
            let encodedString = try (self.data as! ParametersDictionary).urlEncodedString()
            guard let data = encodedString.data(using: encoding ?? .utf8) else {
                throw NetworkError.dataIsNotEncodable(encodedString)
            }
            return data
        case .custom(let encodingFunc):    return encodingFunc(self.data)
        }
    }
    
    /// Return the representation of the body as `String`
    ///
    /// - Parameter encoding: encoding use to read body's data. If not specified `utf8` is used.
    /// - Returns: String
    /// - Throws: throw an exception if string cannot be decoded as string
    public func encodedString(_ encoding: String.Encoding = .utf8) throws -> String {
        let encodedData = try self.encodedData()
        guard let stringRepresentation = String(data: encodedData, encoding: encoding) else {
            throw NetworkError.stringFailedToDecode(encodedData, encoding: encoding)
        }
        return stringRepresentation
    }
}
