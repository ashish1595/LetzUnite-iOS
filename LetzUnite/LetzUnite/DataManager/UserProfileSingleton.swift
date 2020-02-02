//
//  UserProfileSingleton.swift
//  LetzUnite
//
//  Created by Himanshu on 5/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserProfileSingleton: NSObject,NSCoding {
    
    private struct SerializationKeys {
        static let tokenId = "tokenId"
        static let _id = "_id"
        static let name = "name"
        static let emailId = "emailId"
        static let mobileNumber = "mobileNumber"
        static let additionalInfo = "additionalInfo"
    }
    
    static let sharedInstance = UserProfileSingleton()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    var userToken: String? = ""
    var _id: String? = ""
    var name: String? = ""
    var emailId: String? = ""
    var mobileNumber: String? = ""
    var additionalInfo: String? = ""
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userToken, forKey: SerializationKeys.tokenId)
        aCoder.encode(_id, forKey: SerializationKeys._id)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(emailId, forKey: SerializationKeys.emailId)
        aCoder.encode(mobileNumber, forKey: SerializationKeys.mobileNumber)
        aCoder.encode(additionalInfo, forKey: SerializationKeys.additionalInfo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        userToken = aDecoder.decodeObject(forKey: SerializationKeys.tokenId) as? String ?? ""
        _id = aDecoder.decodeObject(forKey: SerializationKeys._id) as? String ?? ""
        name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String ?? ""
        emailId = aDecoder.decodeObject(forKey: SerializationKeys.emailId) as? String ?? ""
        mobileNumber = aDecoder.decodeObject(forKey: SerializationKeys.mobileNumber) as? String ?? ""
        additionalInfo = aDecoder.decodeObject(forKey: SerializationKeys.additionalInfo) as? String ?? ""
    }
}

