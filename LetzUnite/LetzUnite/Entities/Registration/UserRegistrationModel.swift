//
//  UserRegistrationModel.swift
//  LetzUnite
//
//  Created by Himanshu on 4/29/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserRegistrationResponse {
    private struct SerializationKeys {
        static let status = "status"
        static let data = "data"
        static let message = "message"
        static let email = "email"
    }
    
    var data: String?
    var message: String?
    var email: String?
    var status: Int?
}

extension UserRegistrationResponse {
    init(json:JSON) throws{
        guard let status = json[SerializationKeys.status].int else {
            throw Serialization.missing(SerializationKeys.status)
        }
        
        self.status = status
        self.message = json[SerializationKeys.message].string ?? ""
        self.email = json[SerializationKeys.email].string ?? ""

        if self.status != 200 {
            if self.status == 8006 {
                var dummyResponse = UserRegistrationResponse()
                dummyResponse.status = self.status
                dummyResponse.message = self.message
                dummyResponse.data = self.message
                dummyResponse.email = self.email
                throw Serialization.businessCase(self.status!, self.message!, dummyResponse)
            }else {
                throw Serialization.businessCase(self.status!, self.message!, nil)
            }
        }
        
        self.data = json[SerializationKeys.data].string ?? ""
    }
}
