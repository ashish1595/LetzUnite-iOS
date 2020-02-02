//
//  UserLoginModel.swift
//  LetzUnite
//
//  Created by Himanshu on 5/2/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserLoginResponse {
    private struct SerializationKeys {
        static let data = "data"
        static let tokenId = "tokenId"
        static let userProfile = "userProfile"
        static let _id = "_id"
        static let name = "name"
        static let emailId = "emailId"
        static let mobileNumber = "mobileNumber"
        static let status = "status"
        static let message = "message"
        static let additionalInfo = "additionalInfo"
    }
    
    let tokenId: String?
    let _id: String?
    let name: String?
    let emailId: String?
    let mobileNumber: String?
    let status: Int?
    let message: String?
    let additionalInfo: String?
}

extension UserLoginResponse {
    init(json:JSON) throws{
        
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        guard let tokenId = json[SerializationKeys.data][SerializationKeys.tokenId].string else {
            throw Serialization.missing(SerializationKeys.tokenId)
        }
        
        guard let _id = json[SerializationKeys.data][SerializationKeys.userProfile][SerializationKeys._id].string else {
            throw Serialization.missing(SerializationKeys._id)
        }
        
        let name = json[SerializationKeys.data][SerializationKeys.userProfile][SerializationKeys.name].string ?? ""
        
        guard let emailId = json[SerializationKeys.data][SerializationKeys.userProfile][SerializationKeys.emailId].string else {
            throw Serialization.missing(SerializationKeys.emailId)
        }
        
        guard let mobileNumber = json[SerializationKeys.data][SerializationKeys.userProfile][SerializationKeys.mobileNumber].string else {
            throw Serialization.missing(SerializationKeys.mobileNumber)
        }
        
        let additionalInfo = json[SerializationKeys.data][SerializationKeys.userProfile][SerializationKeys.additionalInfo].string ?? ""
        
        self.tokenId = tokenId
        self._id = _id
        self.name = name
        self.emailId = emailId
        self.mobileNumber = mobileNumber
        self.additionalInfo = additionalInfo
    }
}

struct ForgotPasswordResponse {
    private struct SerializationKeys {
        static let data = "data"
        static let status = "status"
        static let message = "message"
    }

    let status: Int?
    let message: String?
    let data: String?
}

extension ForgotPasswordResponse {
    init(json:JSON) throws{
        guard let status = json[SerializationKeys.status].int else {
        throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
        throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        self.data = json[SerializationKeys.data].string ?? ""
    }
}

struct VerifyPasswordResponse {
    private struct SerializationKeys {
        static let data = "data"
        static let status = "status"
        static let message = "message"
    }
    
    let status: Int?
    let message: String?
    let data: String?
}

extension VerifyPasswordResponse {
    init(json:JSON) throws{
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        
        if self.status != 200 {
            throw Serialization.businessCase(self.status!, self.message!, nil)
        }
        
        self.data = json[SerializationKeys.data].string ?? ""
    }
}
