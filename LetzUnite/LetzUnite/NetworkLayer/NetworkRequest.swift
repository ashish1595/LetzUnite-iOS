//
//  NetworkRequest.swift
//  LetzUnite
//
//  Created by Himanshu on 4/15/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Alamofire
//import RNCryptor

public class Request: RequestProtocol {
    public var context: Context?
    
    /// Invalidation token to cancel the request
    //public var invalidationToken: InvalidationToken?
    
    /// Endpoint for request
    public var endpoint: String
    
    /// Body of the request
    public var body: RequestBody?
    
    /// HTTP method of the request
    public var method: RequestMethod?
    
    /// Fields of the request
    public var fields: ParametersDictionary?
    
    /// URL of the request
    public var urlParams: ParametersDictionary?
    
    /// Headers of the request
    public var headers: HeadersDictionary?
    
    /// Cache policy
    public var cachePolicy: URLRequest.CachePolicy?
    
    /// Timeout of the request
    public var timeout: TimeInterval?
    
    public var isEncrypted: Bool?

    /// Initialize a new request
    ///
    /// - Parameters:
    ///   - method: HTTP Method request (if not specified, `.get` is used)
    ///   - endpoint: endpoint of the request
    ///   - params: paramters to replace in endpoint
    ///   - fields: fields to append inside the url
    ///   - body: body to set
//    public init(method: RequestMethod = .get, endpoint: String = "", params: ParametersDictionary? = nil, fields: ParametersDictionary? = nil, body: RequestBody? = nil) {
//        self.method = method
//        self.endpoint = endpoint
//        self.urlParams = params
//        self.fields = fields
//        self.body = body
//    }
    public init(method: RequestMethod = .get, endpoint: String = "", params: ParametersDictionary? = nil, fields: ParametersDictionary? = nil, body: RequestBody? = nil, isEncrypted: Bool = false) {
        self.isEncrypted = isEncrypted
        self.method = method
        self.endpoint = endpoint
        self.urlParams = params
        self.fields = fields
        
        if self.isEncrypted == true {
            let unencrypted = self.getEncryptedRawData(paramsDictionary: params)
            self.body = RequestBody.json(unencrypted as Any)
        }else {
            self.body = body
        }
    }
    
    
//   fileprivate func encryptParams(dict: [String: String?]?) -> [String: String?]? {
//        if let params = dict {
//
//            do {
//                let data = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//
//                let dataKey = String.random(length: 12)
//
//
//
//
//            } catch {
//                return ["":""]
//            }
//
//
//
//
//            return params
//        }
//        return ["":""]
//    }

    
    // MARK -: Encryption Logic
//    func getEncryptedRawData(paramsDictionary: [String: Any?]?) -> [String:Any?]? {
//
//        do {
//            let userId = "letzunite"
//
//            //getting a random string of 12 characters length
//            let dataKey: String = String.random(length: 12)
//
//            //-------------------------converting string to encrypted data.--------------------------
//            let jsonData = try JSONSerialization.data(withJSONObject: paramsDictionary as Any, options: .prettyPrinted)
//
//            let encryptionSalt = "0001020304050607".dataFromHexEncoding!
//            let ivector = "02030405060708090a0b0c0d0e0f0001".dataFromHexEncoding!
//
//            let encryptedData = RNCryptor.encrypt(data: jsonData, withPassword: dataKey)
//
//            let encryptedString : String = encryptedData.base64EncodedString()
//
//            let dataKeyWithIVSalt = String(format: "%@%@%@%@%@",dataKey,userId,encryptionSalt.base64EncodedString(),userId,ivector.base64EncodedString()) // Key with dynamic IV and Salt with a separator
//
//
//            let rsa : RSAWrapper? = RSAWrapper()
//
////            let success : Bool = (rsa?.generateKeyPair(keySize: 2048, privateTag: "none", publicTag: "com.letzunite"))!
//
//            let success : Bool = (rsa?.getPublicKeyFromBundle(fileName: "public_new", extensionType: "der"))!
//
//
//            if (!success) {
//                print("Failed")
//                return ["":"" as Any?]
//            }
//
//            let encryptedKeyString = rsa?.encryptBase64(text: dataKeyWithIVSalt)
//
////            let decryptedKeyString = rsa?.decpryptBase64(encrpted: encryptedKeyString!)
//
//            print("data \(encryptedString)")
//            print("key \(encryptedKeyString!)")
//
//             let rawDataEncrypted = ["key":encryptedKeyString as Any,
//                                    "data":encryptedString as Any]
//
//            return rawDataEncrypted
//        }
//        catch {
//            print("Some error occured: \(error)");
//        }
//
//        return nil
//    }
    
    func getEncryptedRawData(paramsDictionary: [String: Any?]?) -> [String:Any?]? {
        
        do {
            let userId = "letzunite"
                        
            //getting a random string of 12 characters length
            let dataKey: String = String.random(length: 12)
            
            //-------------------------converting string to encrypted data.--------------------------
            let jsonData = try JSONSerialization.data(withJSONObject: paramsDictionary as Any, options: .prettyPrinted)
            
            var iv: NSData? = nil
            var salt: NSData? = nil
            
            let encrypted_dict: NSDictionary = try RNCryptManager.encryptedData(forDict: jsonData, password: dataKey, iv: &iv, salt: &salt) as NSDictionary // Encryption with AES

            let encryptedDataValue : NSData = encrypted_dict.object(forKey:"encryptedData") as! NSData
            let encryptedIValue : NSData = encrypted_dict.object(forKey:"ivData") as! NSData
            let encryptedSaltValue : NSData = encrypted_dict.object(forKey:"saltData") as! NSData
            
            let encryptedString : String = encryptedDataValue.base64EncodedString(options:NSData.Base64EncodingOptions(rawValue: 0))
            let encryptedStringIV : String = encryptedIValue.base64EncodedString(options:NSData.Base64EncodingOptions(rawValue: 0))
            let encryptedStringSalt : String = encryptedSaltValue.base64EncodedString(options:NSData.Base64EncodingOptions(rawValue: 0))
            
            let dataKeyWithIVSalt = String(format: "%@%@%@%@%@",dataKey,userId,encryptedStringSalt,userId,encryptedStringIV) // Key with dynamic IV and Salt with a separator
            
            let rsa : RSAWrapper? = RSAWrapper()
            
            let success : Bool = (rsa?.getPublicKeyFromBundle(fileName: "public_new", extensionType: "der"))!
            
            if (!success) {
                print("Failed")
                return ["":"" as Any?]
            }
            
            let encryptedKeyString = rsa?.encryptBase64(text: dataKeyWithIVSalt)
            
            print("data \(encryptedString)")
            print("key \(encryptedKeyString!)")
            
            let rawDataEncrypted = ["key":encryptedKeyString as Any,
                                    "data":encryptedString as Any]
            
            return rawDataEncrypted
        }
        catch {
            print("Some error occured: \(error)");
        }
        
        return nil
    }
    
}






